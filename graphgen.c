// Written by Kuo-Ping Hsu
// Required library: pcre, uthash
// MIT license
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>

#define PCRE2_STATIC
#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>

#include "uthash.h"
#include "graphgen.h"

#define MAXSIZE 128
#define MAXREG  64
#define MAXCHILD 2048
#define DEFAULT_MAXDEPTH 256

int MAXDEPTH = DEFAULT_MAXDEPTH;
int VERBOSE = 0;
int tree = 0;
int vcg = 1;
int frame_pointer = 0;
int recursived = 0;
int indirect = 0;
int stack_info = 0;
int nostack = 0;

// specify the ignore list
char ignore_list[4096] = "";

// name of root node
char root_node[MAXSIZE] = "";

char regmap[MAXREG][MAXSIZE];

#define getop(dst, src, ovector, n) snprintf(dst, MAXSIZE, "%.*s", (int)(ovector[2*(n)+1] - ovector[2*(n)]), (src + ovector[2*(n)]))

typedef struct _LIST {
    struct _NODE *child;
    struct _LIST *next;
} LIST;

typedef struct _NODE {
    struct _NODE *parent;
    struct _LIST *list;
    int  pc;
    int  prog_size;
    int  stack_size;
    int  frame_size;
    int  traversed;
    int  recursived;            // tag for recursive function
    char key[MAXSIZE];          // hash key
    char name[MAXSIZE];         // function name
    int  id;
    int  skip;
    int  unknown;
    int  mark;
    UT_hash_handle hh;          // makes this structure hashable
} NODE;

typedef struct _ROOT {
    struct _NODE *node;
    char name[MAXSIZE];         // function name
    int  id;
    int  frame_size;
    UT_hash_handle hh;          // makes this structure hashable
} ROOT;

// Traversed NODE
typedef struct _TNODE {
    char name[MAXSIZE];         // function name
    int  id;
    int  tag;
    UT_hash_handle hh;          // makes this structure hashable
} TNODE;

typedef struct _STRING {
    char name[MAXSIZE];         // function name
    UT_hash_handle hh;          // makes this structure hashable
} STRING;

NODE   *graph = NULL;           // graph node
ROOT   *root = NULL;            // root node
TNODE  *tnode = NULL;           // tag node
STRING *ignore = NULL;          // ignore node

void usage(void) {
    int i;

    printf(
"Generate call graph of a elf binary file.\n\n"
"Usage:\n"
"    graphgen [-v] [-a target] [-m n] [-g | -t] [-c | -d] [-r name]\n"
"             [-i list] [-h] asm_file vcg_file\n\n"
"    --verbose, -v           verbose output\n"
"    --target name, -a name  specify the target (see support target below)\n"
"    --max n, -m n           max depth (default 256)\n"
"    --graph, -g             generate call graph (default)\n"
"    --tree, -t              generate call tree\n"
"    --nostack, -k           do not gather statck size\n"
"    --vcg, -c               generate vcg graph (default)\n"
"    --dot, -d               generate dot graph\n"
"    --ignore list, -i list  ignore list\n"
"    --help, -h              help\n"
"\n");

    printf("Support target:\n");
    for(i=0; i<sizeof(arch)/sizeof(ARCH); i++) {
        if (i == 0) {
            printf("    %s (default)\n", arch[i].name);
        } else {
            printf("    %s\n", arch[i].name);
        }
    }

    printf(
"\nExample:\n\n"
"    $ graphgen --max 10 --tree --ignore abort,exit infile.s outfile.vcg\n"
"\n"
"    maximun tree depth is 10, generate a call tree, ignode function abort, and\n"
"    exit\n"
);

}

// strip space
char * trim(char * s) {
    static char str[MAXSIZE];
    int l = strlen(s);

    while(isspace(s[l - 1])) --l;
    while(* s && isspace(* s)) { ++s, --l; }

    strncpy(str, s, l);
    str[l] = 0;
    return str;
}

// generate ignore list to hash
void generate_ignore(void) {
    char *token;

    token = strtok(ignore_list, ",");

    while (token != NULL) {
        STRING *str;
        char *func_name = trim(token);

        if (func_name[0] != 0) {
            if ((str = malloc(sizeof(STRING))) == NULL) {
                printf("malloc fail\n");
                exit(-1);
            }

            strncpy(str->name, func_name, MAXSIZE);
            HASH_ADD_STR(ignore, name, str);
        }

        token = strtok(NULL, ",");
    }
}

NODE *node_dup(NODE *node) {
    NODE *s = NULL;

    // allocat a node
    if ((s = malloc(sizeof(NODE))) == NULL) {
        printf("malloc fail\n");
        exit(-1);
    }

    if (node) {
        memcpy(s, node, sizeof(NODE));

        if (s->list) {
            int i;
            LIST *list;
            LIST *l;
            LIST *p;
            if ((list = malloc(sizeof(LIST))) != NULL) {
                memcpy(list, s->list, sizeof(LIST));
            }
            s->list = list;

            p = s->list;
            l = list->next;
            for(i = 0; i<MAXCHILD && l != NULL; i++, l = l->next) {
                if ((list = malloc(sizeof(LIST))) != NULL) {
                    memcpy(list, l, sizeof(LIST));
                }
                p->next = list;
                p = list;
            }
        }
    } else {
        // init the node
        memset(s, 0, sizeof(NODE));
    }

    return s;
}

PCRE2_SIZE* regex(pcre2_code *re,
                  pcre2_match_data *match_data,
                  PCRE2_SPTR8 str,
                  PCRE2_SPTR8 pattern) {
    static PCRE2_SIZE* ovector;
    PCRE2_SIZE erroroffset;
    int rc;
    int errornumber;

    re = pcre2_compile(
        pattern,               /* the pattern */
        PCRE2_ZERO_TERMINATED, /* indicates pattern is zero-terminated */
        0,                     /* default options */
        &errornumber,          /* for error number */
        &erroroffset,          /* for error offset */
        NULL);                 /* use default compile context */

    match_data = pcre2_match_data_create_from_pattern(re, NULL);

    rc = pcre2_match(
        re,                    /* the compiled pattern */
        str,                   /* the subject string */
        strlen((char*)str),    /* the length of the subject */
        0,                     /* start at offset 0 in the subject */
        0,                     /* default options */
        match_data,            /* block for storing the result */
        NULL);                 /* use default match context */

    ovector = pcre2_get_ovector_pointer(match_data);

    return rc < 0 ? NULL : ovector;
}

int create_graph(char *filename) {
    FILE *fp;
    pcre2_code *re = NULL;
    pcre2_match_data *match_data = NULL;
    char line[MAXSIZE];
    char buf[MAXSIZE];
    char name[MAXSIZE];
    int PC, stack, i;
    NODE *node = NULL;
    NODE *unknown = NULL;
    int skip = 0;

    if ((fp = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "Can not open file %s\n", filename);
        return 1;
    }

    stack = 0;

    for(i=0; i<MAXREG; i++) {
        regmap[i][0] = 0;
    }

    while(!feof(fp) && fgets(line, sizeof(line), fp)) {
        PCRE2_SIZE* ovector = NULL;

        // Cross the section
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  "Disassembly of section.+");
        if (ovector != NULL) {
            if (node) {
                if (!node->stack_size) node->stack_size = stack;
                if (!node->prog_size) node->prog_size = PC - node->pc;
            }
            continue;
        }

        // function name declare
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_FUNC);
        if (ovector != NULL) {
            NODE *s;
            char key[MAXSIZE];

            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);

            getop(name, line, ovector, 2);

            // Is a ignore node
            {
                STRING *str;

                HASH_FIND_STR(ignore, name, str);

                skip = (str) ? 1 : 0;
            }

            if (node) {
                if (!node->stack_size) node->stack_size = stack;
                if (!node->prog_size) node->prog_size = PC - node->pc;
            }

            snprintf(key, MAXSIZE, "%s:0", name);

            // Is node exist
            HASH_FIND_STR(graph, key, s);

            if (!s) {
                // allocat a node
                node = node_dup(NULL);

                // function name
                strncpy(node->name, name, MAXSIZE);
                snprintf(node->key, MAXSIZE, "%s:0", name);

                // add node to hash
                HASH_ADD_STR(graph, key, node);
            } else {
                node = s;
            }

            node->skip = skip;
            node->pc = PC;
            stack = 0;

            // release the function map of registers
            for(i=0; i<MAXREG; i++) {
                regmap[i][0] = 0;
            }

            continue;
        }

        // get stack size
        if (ITEM_STACK[0] != 0) {
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_STACK);

            if (ovector != NULL) {
                int size;

                getop(buf, line, ovector, 1);
                sscanf(buf, "%x", &PC);

                getop(buf, line, ovector, 2);
                if (buf[0] == '0' && (buf[1] == 'x' || buf[1] == 'X')) {
                    sscanf(buf, "%x", &size);
                } else {
                    sscanf(buf, "%d", &size);
                }

                stack += size;

                // update stack size
                node->stack_size = stack;

                if (!nostack) stack_info = 1;

                continue;
            }
        }

        // get stack size
        if (ITEM_PUSH[0] != 0) {
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_PUSH);

            if (ovector != NULL) {
                int size;
                getop(buf, line, ovector, 1);
                sscanf(buf, "%x", &PC);

                getop(buf, line, ovector, 2);

                for(size=4, i = 0; buf[i] != 0 && i < MAXSIZE; i++) {
                    if (buf[i] == ',') size += 4;
                }

                stack += size;

                // update stack size
                node->stack_size = stack;

                if (!nostack) stack_info = 1;

                continue;
            }
        }

        // get loadr
        if (ITEM_LOADR[0] != 0) {
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_LOADR);

            if (ovector != NULL) {
                int reg;
                if (skip) continue;

                getop(buf, line, ovector, 1);
                sscanf(buf, "%x", &PC);

                // register number
                getop(buf, line, ovector, 2);
                reg = atoi(buf);

                // function name
                getop(buf, line, ovector, 3);

                if (reg < MAXREG) {
                    strncpy(regmap[reg], buf, MAXSIZE);

                    // modify the function name
                    for(i=0; regmap[reg][i] != 0 && i < MAXSIZE; i++)
                        if (regmap[reg][i] == '+' || regmap[reg][i] == '-') regmap[reg][i] = '_';
                }
                continue;
            }
        }

        // funcation call
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_CALL);
        if (ovector != NULL) {
            int i;
            NODE *s;
            LIST *ptr;
            LIST *list;
            int found = 0;
            char key[MAXSIZE];

            if (skip) continue;
            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);

            getop(name, line, ovector, 2);

            // modify the function name
            for(i=0; name[i] != 0 && i < MAXSIZE; i++)
                if (name[i] == '+' || name[i] == '-') name[i] = '_';

            // recursive checking
            if (tree && !strcmp(node->name, name)) {
                node->recursived = 1;
                recursived = 1;
                fprintf(stderr, "Warning: recursive function %s dectect\n", name);
                continue;
            }

            snprintf(key, MAXSIZE, "%s:0", name);

            // Is node exist
            HASH_FIND_STR(graph, key, s);

            if (!s) {
                // allocat a node
                s = node_dup(NULL);

                // function name
                strncpy(s->name, name, MAXSIZE);
                snprintf(s->key, MAXSIZE, "%s:0", name);

                // add node to hash
                HASH_ADD_STR(graph, key, s);
            }

            s->parent = node;

            list = node->list;
            if (!list) {
                if ((list = malloc(sizeof(LIST))) == NULL) {
                    fprintf(stderr, "malloc fail\n");
                    exit(-1);
                }

                node->list = list;
                list->next = NULL;
                list->child = s;
            } else {
                for(i=0; i<MAXCHILD && list->next != NULL; i++) {
                    if (!strcmp(s->name, list->child->name)) {
                        found = 1;
                        break;
                    }
                    list = list->next;
                }

                if (!strcmp(s->name, list->child->name)) {
                    found = 1;
                }

                if (!found) {
                    if ((ptr = malloc(sizeof(LIST))) == NULL) {
                        fprintf(stderr, "malloc fail\n");
                        exit(-1);
                    }

                    list->next = ptr;
                    ptr->next = NULL;
                    ptr->child = s;
                }

                if (i == MAXCHILD) {
                    fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                    exit(-1);
                }
            }

            if (VERBOSE && !found) {
                printf("add %s to %s\n", s->name, node->name);
            }

            continue;
        }

        // indirect funcation call
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_CALLR);
        if (ovector != NULL) {
            LIST *ptr;
            LIST *list;
            int found = 0;
            int reg;

            if (skip) continue;
            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);

            getop(buf, line, ovector, 2);
            reg = atoi(buf);

            if (regmap[reg][0]) {
                NODE *s;
                LIST *ptr;
                LIST *list;
                int found = 0;
                char key[MAXSIZE];

                if (VERBOSE) printf("Indirect function call '%s' detected\n", regmap[reg]);

                // recursive checking
                if (tree && !strcmp(node->name, regmap[reg])) {
                    node->recursived = 1;
                    recursived = 1;
                    fprintf(stderr, "Warning: recursive function %s dectect\n", regmap[reg]);
                    continue;
                }

                snprintf(key, MAXSIZE, "%s:0", regmap[reg]);

                // Is node exist
                HASH_FIND_STR(graph, key, s);

                if (!s) {
                    // allocat a node
                    s = node_dup(NULL);

                    // function name
                    strncpy(s->name, regmap[reg], MAXSIZE);
                    snprintf(s->key, MAXSIZE, "%s:0", regmap[reg]);

                    // add node to hash
                    HASH_ADD_STR(graph, key, s);
                }

                s->parent = node;

                list = node->list;
                if (!list) {
                    if ((list = malloc(sizeof(LIST))) == NULL) {
                        fprintf(stderr, "malloc fail\n");
                        exit(-1);
                    }

                    node->list = list;
                    list->next = NULL;
                    list->child = s;
                } else {
                    for(i=0; i<MAXCHILD && list->next != NULL; i++) {
                        if (!strcmp(s->name, list->child->name)) {
                            found = 1;
                            break;
                        }
                        list = list->next;
                    }

                    if (!strcmp(s->name, list->child->name)) {
                        found = 1;
                    }

                    if (!found) {
                        if ((ptr = malloc(sizeof(LIST))) == NULL) {
                            fprintf(stderr, "malloc fail\n");
                            exit(-1);
                        }

                        list->next = ptr;
                        ptr->next = NULL;
                        ptr->child = s;
                    }

                    if (i == MAXCHILD) {
                        fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                        exit(-1);
                    }
                }
            } else {
                indirect = 1;

                if (unknown == NULL) {
                    // allocat a node
                    unknown = node_dup(NULL);

                    // function name
                    strncpy(unknown->name, "__unknown__", MAXSIZE);
                    strncpy(unknown->key, "__unknown__:0", MAXSIZE);
                    unknown->unknown = 1;

                    // add node to hash
                    HASH_ADD_STR(graph, key, unknown);
                }

                unknown->parent = node;

                list = node->list;
                if (!list) {
                    if ((list = malloc(sizeof(LIST))) == NULL) {
                        fprintf(stderr, "malloc fail\n");
                        exit(-1);
                    }

                    node->list = list;
                    list->next = NULL;
                    list->child = unknown;
                } else {
                    for(i=0; i<MAXCHILD && list->next != NULL; i++) {
                        if (!strcmp(unknown->name, list->child->name)) {
                            found = 1;
                            break;
                        }
                        list = list->next;
                    }

                    if (!strcmp(unknown->name, list->child->name)) {
                        found = 1;
                    }

                    if (!found) {
                        if ((ptr = malloc(sizeof(LIST))) == NULL) {
                            fprintf(stderr, "malloc fail\n");
                            exit(-1);
                        }

                        list->next = ptr;
                        ptr->next = NULL;
                        ptr->child = unknown;
                    }

                    if (i == MAXCHILD) {
                        fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                        exit(-1);
                    }
                }
            }

            if (VERBOSE && !found) {
                printf("add %s to %s\n", unknown->name, node->name);
            }

            continue;
        }

        // get current PC
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  "^\\s*([0-9A-Fa-f]+):.+$");
        if (ovector != NULL) {
            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);
        }
    }

    if (!node) {
        fprintf(stderr, "!!Error!! can not create call graph\n");
        fclose(fp);
        exit(-1);
    }

    if (!node->stack_size) node->stack_size = stack;
    if (!node->prog_size) node->prog_size = PC - node->pc;

    pcre2_match_data_free(match_data);   /* Release memory used for the match */
    pcre2_code_free(re);                 /* data and the compiled pattern. */
    fclose(fp);

    return 0;
}

void mark_tree(NODE *node) {
    NODE *n;

    if (!node) return;
    node->mark = 1;

    n = node->parent;
    while (n) {
        n->mark = 1;
        n = n->parent;
    }
}

int maxdepth = 0;
int max_frame = 0;
NODE *mark_node = NULL;
void traverse(NODE *node) {
    int i;
    LIST *list;
    TNODE *t;

    if (!node) return;

    HASH_FIND_STR(tnode, node->name, t);

    if (!t) {
        fprintf(stderr, "internal data error\n");
        exit(-1);
    }

    frame_pointer += node->stack_size;
    t->tag = 1;
    node->traversed = 1;
    node->frame_size = frame_pointer;
    if (frame_pointer >= max_frame) {
        max_frame = frame_pointer;
        mark_node = node;
    }
    list = node->list;
    maxdepth++;

    if (VERBOSE)
        printf("%s (%d)\n", node->key, maxdepth);

    if (!list) {
        t->tag = 0;
        maxdepth--;
        frame_pointer -= node->stack_size;
        return;
    }

    if (maxdepth > MAXDEPTH) {
        if (MAXDEPTH == DEFAULT_MAXDEPTH)
            fprintf(stderr, "warning: exceed max depth of tree\n");
        t->tag = 0;
        node->list = 0;
        maxdepth--;
        frame_pointer -= node->stack_size;
        return;
    }

    for(i=0; i<MAXCHILD && list != NULL; i++, list = list->next) {
        TNODE *tn;

        HASH_FIND_STR(tnode, list->child->name, tn);

        if (!tn) {
            if ((tn = malloc(sizeof(TNODE))) == NULL) {
                fprintf(stderr, "malloc error\n");
                exit(-1);
            }
            strncpy(tn->name, list->child->name, MAXSIZE);
            tn->id = list->child->id;
            tn->tag = 0;
            HASH_ADD_STR(tnode, name, tn);
        } else {

            if (tn->tag) {
                list->child->recursived = 3;
            }

            {
                NODE *node_new;

                // duplicate node
                node_new = node_dup(list->child);

                tn->id++;
                node_new->mark = 0;
                node_new->parent = node;
                node_new->id = tn->id;
                node_new->traversed = 0;
                node_new->recursived = list->child->recursived;

                snprintf(node_new->key, MAXSIZE, "%s:%d", node_new->name, node_new->id);

                // add node to hash
                HASH_ADD_STR(graph, key, node_new);

                list->child = node_new;
            }

            // detect recursive
            if (tn->tag) {
                list->child->recursived = 2;
                list->child->traversed = 1;
                list->child->list = NULL;
                fprintf(stderr, "warnning: detect recursive funcion call at %s\n", list->child->name);
                continue;
            }
        }

        list->child->parent = node;

        traverse(list->child);
    }

    frame_pointer -= node->stack_size;
    t->tag = 0;
    maxdepth--;
}

void create_tree(char *name) {
    if (name == NULL) {
        NODE *s, *t1;
        ROOT *r, *t2;

        // find the root node
        HASH_ITER(hh, graph, s, t1) {
            if (!s->parent) {
                ROOT *r;
                if ((r=malloc(sizeof(ROOT))) == NULL) {
                    fprintf(stderr, "malloc fail\n");
                    exit(-1);
                }
                strncpy(r->name, s->name, sizeof(MAXSIZE));
                r->node = s;
                HASH_ADD_STR(root, name, r);
            }
        }

        // iterate the root node
        HASH_ITER(hh, root, r, t2) {
            maxdepth = 0;
            frame_pointer = 0;
            max_frame = 0;
            mark_node = NULL;
            {
                TNODE *t;
                if ((t = malloc(sizeof(TNODE))) == NULL) {
                    fprintf(stderr, "malloc fail\n");
                    exit(-1);
                }
                strncpy(t->name, r->node->name, MAXSIZE);
                t->tag = 0;
                t->id = r->node->id;
                HASH_ADD_STR(tnode, name, t);
            }
            traverse(r->node);
            mark_tree(mark_node);
            r->frame_size = max_frame;
            if (VERBOSE) printf("root: %s\n", r->node->name);
        }
    } else {
        NODE *s;
        char key[MAXSIZE];

        maxdepth = 0;
        frame_pointer = 0;
        snprintf(key, MAXSIZE, "%s:0", name);
        HASH_FIND_STR(graph, key, s);

        if (s) {
            {
                TNODE *t;
                if ((t = malloc(sizeof(TNODE))) == NULL) {
                    fprintf(stderr, "malloc fail\n");
                    exit(-1);
                }
                strncpy(t->name, s->name, MAXSIZE);
                t->tag = 0;
                t->id = s->id;
                HASH_ADD_STR(tnode, name, t);
            }

            max_frame = 0;
            mark_node = NULL;
            traverse(s);
            mark_tree(mark_node);
            printf("== stack summary ==\n");
            if (max_frame != 0)
                printf("root function %s: %d bytes stack usage\n", s->name, max_frame);
            else
                printf("root function %s\n", s->name);
        } else {
            fprintf(stderr, "can not find the function %s\n", name);
            exit(-1);
        }
    }

    // Shows satck summary
    if (name == NULL) {
        ROOT *r, *t2;

        printf("== stack summary ==\n");

        HASH_ITER(hh, root, r, t2) {
            if (r->frame_size)
                printf("function %s: %d bytes stack usage\n", r->node->name, r->frame_size);
            else
                printf("function %s\n", r->node->name);
        }
    }

    if (recursived || indirect) {
        printf("\n");
        printf("!!WARNING!! there's recursived or indirect funcation call,\n");
        printf("the estimation of stack usage is not correct.\n");
    }
}

void gen_graph_vcg(char *filename, int only_linked) {
    FILE *fp;
    int i;
    NODE *s, *tmp;
    LIST *list;
    int recursive_count = 0;

    if ((fp = fopen(filename, "w")) == NULL) {
        printf("Can not create file %s\n", filename);
        exit(-1);
    }

    fprintf(fp,
        "graph: {\n" \
        "  x: 450\n" \
        "  y: 30\n" \
        "  width:  550\n" \
        "  height: 500\n" \
        "  color: lightcyan\n" \
        "  stretch: 4\n" \
        "  shrink: 10\n\n");

    HASH_ITER(hh, graph, s, tmp) {
        char *color;
        char stack[MAXSIZE] = "";
        char frame[MAXSIZE] = "";

        if (VERBOSE) printf("%s: callee addr 0x%08x, prog size: %d, stack size: %d\n", s->name, s->pc, s->prog_size, s->stack_size);

        if (only_linked && !s->traversed)
            continue;

        if (stack_info)
            snprintf(stack, sizeof(stack), "\\nSTACK: %d", s->stack_size);

        if (tree && stack_info)
            snprintf(frame, sizeof(frame), "\\nFRAME: %d", s->frame_size);

        if (s->unknown || (s->prog_size == 0))
            color = "lightgrey";
        else if (s->mark)
            color = "white";
        else if (s->recursived)
            color = "aquamarine";
        else
            color = "white";

        // Add VCG Node
        fprintf(fp, \
            "  node: {\n" \
            "    title: \"%s\"\n" \
            "    label: \"%s\\nPROG: %d%s%s\"\n" \
            "    color: %s\n" \
            "  }\n\n",
            s->key,
            s->name,
            s->prog_size,
            stack,
            frame,
            color
        );

        // Add VCG edge
        list = s->list;
        for(i=0; list != NULL; i++) {
            if (list->child->mark && stack_info)
                fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"%s\" color: red }\n",
                    s->key, list->child->key);
            else
                fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"%s\" }\n",
                    s->key, list->child->key);
            list = list->next;
        }

        if (i != 0) fprintf(fp, "\n");

        if (s->recursived == 1) {
            fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"%s\" color: darkblue linestyle: dashed }\n",
                s->key, s->key);
        }

        if (s->recursived == 2) {
            fprintf(fp, "  node: { title: \"__r:%d\" color: darkgrey shape: rhomb width: 5 height: 5 }\n", recursive_count);
            fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"__r:%d\" color: darkblue linestyle: dashed }\n",
                s->key, recursive_count++);
        }

        if (s->recursived == 3) {
            fprintf(fp, "  node: { title: \"__r:%d\" color: darkgrey shape: rhomb width:5 height:5 }\n", recursive_count);
            fprintf(fp, "  edge: { sourcename: \"__r:%d\" targetname: \"%s\" color: darkblue linestyle: dashed }\n",
                recursive_count++, s->key);
        }

        if (s->recursived != 0) fprintf(fp, "\n");
    }

    fprintf(fp, "}\n");
    fclose(fp);
}

void gen_graph_dot(char *filename, int only_linked) {
    FILE *fp;
    int i;
    NODE *s, *tmp;
    LIST *list;

    if ((fp = fopen(filename, "w")) == NULL) {
        printf("Can not create file %s\n", filename);
        exit(-1);
    }

    fprintf(fp, "digraph callgraph {\n");

    HASH_ITER(hh, graph, s, tmp) {
        char *color;
        char stack[MAXSIZE] = "";
        char frame[MAXSIZE] = "";

        if (VERBOSE) printf("%s: callee addr 0x%08x, prog size: %d, stack size: %d\n", s->name, s->pc, s->prog_size, s->stack_size);

        if (only_linked && !s->traversed)
            continue;

        if (stack_info)
            snprintf(stack, sizeof(stack), "|STACK: %d", s->stack_size);

        if (tree && stack_info)
            snprintf(frame, sizeof(frame), "|FRAME: %d", s->frame_size);

        if (s->unknown || (s->prog_size == 0))
            color = "aquamarine";
        else if (s->mark)
            color = "white";
        else if (s->recursived)
            color = "aquamarine";
        else
            color = "white";

        // Add dot Node
        fprintf(fp,
            "  %s_%d [ label = \"%s|PROG: %d%s%s\" color = %s];\n",
            s->name, s->id,
            s->name,
            s->prog_size,
            stack,
            frame,
            color
        );

        // Add dot edge
        list = s->list;
        for(i=0; list != NULL; i++) {
            fprintf(fp, "  %s_%d -> %s_%d [color=\"0.650 0.700 0.700\"];\n",
                s->name, s->id, list->child->name, list->child->id);
            list = list->next;
        }

        if (s->recursived) {
            fprintf(fp, "  %s_%d -> %s_%d [color=\"0.650 0.700 0.700\"];\n",
                s->name, s->id, s->name, s->id);
        }

        if (i != 0) fprintf(fp, "\n");
    }

    fprintf(fp, "\n}\n");
    fclose(fp);
}

int main(int argc, char **argv) {
    int i;
    char infile[MAXSIZE];
    char outfile[MAXSIZE];

    const char *optstring = "a:vm:gtr:i:hcdk";
    int c;
    struct option opts[] = {
       {"target", 1, NULL, 'a'},
       {"verbose", 0, NULL, 'v'},
       {"max", 1, NULL, 'm'},
       {"graph", 0, NULL, 'g'},
       {"tree", 0, NULL, 't'},
       {"root", 1, NULL, 'r'},
       {"nostack", 0, NULL, 'k'},
       {"ignore", 1, NULL, 'i'},
       {"help", 0, NULL, 'h'},
       {"vcg", 0, NULL, 'c'},
       {"dot", 0, NULL, 'd'},
       {0, 0, 0, 0}
    };

    if (argc <= 2) {
        usage();
        return 1;
    }

    while((c = getopt_long(argc, argv, optstring, opts, NULL)) != -1) {
        switch(c) {
            case 'a':
                for(i=0; i<sizeof(arch)/sizeof(ARCH); i++) {
                    if (!strcmp(optarg, arch[i].name)) break;
                }
                if (i == sizeof(arch)/sizeof(ARCH)) {
                    usage();
                    fprintf(stderr, "\n!!Error!! Do not support the target arch '%s'.\n", optarg);
                    return 1;
                } else {
                    target = i;
                }
                break;
            case 'v':
                VERBOSE = 1;
                break;
            case 'm':
                MAXDEPTH = atoi(optarg);
                break;
            case 'g':
                tree = 0;
                break;
            case 't':
                tree = 1;
                break;
            case 'r':
                strncpy(root_node, optarg, sizeof(root_node));
                break;
            case 'i':
                strncpy(ignore_list, optarg, sizeof(ignore_list));
                break;
            case 'h':
                usage();
                return 1;
            case 'c':
                vcg = 1;
                break;
            case 'd':
                vcg = 0;
                break;
            case 'k':
                nostack = 1;
                break;
            default:
                printf("Unknown option");
                usage();
                return 1;
        }
    }

    if (argc - optind != 2) {
        usage();
        return 1;
    }

    strncpy(infile, argv[optind], sizeof(infile));
    strncpy(outfile, argv[optind+1], sizeof(outfile));

    generate_ignore();
    create_graph(infile);

    if (tree) {
        if (root_node[0]) {
            create_tree(root_node);
        } else {
            create_tree(NULL);
        }
    }

    if (vcg)
        gen_graph_vcg(outfile, tree);
    else
        gen_graph_dot(outfile, tree);

    return 0;
}

