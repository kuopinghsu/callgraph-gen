// Written by Kuo-Ping Hsu
// Required library: pcre, uthash
// MIT license

#define __DEF_ARRAY__
#include "graphgen.h"
#include <getopt.h>

#define PCRE2_STATIC
#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>

#include "uthash/src/uthash.h"

#define MAXSIZE             MAXSTRLEN
#define MAXREG              64
#define MAXCHILD            2048
#define MAXLINE             4096
#define DEFAULT_MAXDEPTH    256

char default_xml[] = {
#include "default_xml.inc"
};

int MAXDEPTH = DEFAULT_MAXDEPTH;
int VERBOSE = 0;
int tree = 0;
int vcg = 1;
int frame_pointer = 0;
int recursived = 0;
int indirect = 0;
int stack_info = 0;
int nostack = 0;
int node_count = 0;
int edge_count = 0;
int recursive_count = 0;
int depth = 0;

// specify the ignore list
char ignore_list[4096] = "";

// name of root node
char root_node[MAXSIZE] = "";

char regmap[MAXREG][MAXSIZE];

// xml file
char xmlfile[MAXSIZE] = "";

#define getop(dst, src, ovector, n) snprintf(dst, MAXSIZE, "%.*s", (int)(ovector[2*(n)+1] - ovector[2*(n)]), (src + ovector[2*(n)]))

typedef struct _LIST {
    struct _NODE *child;
    int           attr;
    struct _LIST *next;
} LIST;

typedef struct _NODE {
    struct _NODE *parent;
    struct _LIST *list;
    unsigned int  pc;
    unsigned int  prog_size;
    unsigned int  stack_size;
    unsigned int  frame_size;
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

typedef struct _RNODE {
    char name[MAXSIZE];         // recursived function name
    UT_hash_handle hh;          // makes this structure hashable
} RNODE;

NODE   *graph = NULL;           // graph node
ROOT   *root = NULL;            // root node
TNODE  *tnode = NULL;           // tag node
STRING *ignore = NULL;          // ignore node
RNODE  *rnode = NULL;           // recursive node

#ifndef __STDC_WANT_LIB_EXT1__ 
char *strncpy_s(char *dest, size_t n, const char *src, size_t count) {
    int len = (int)strnlen(src, count);
    if (len > n) len = n;
    memcpy(dest, src, len);
    dest[len] = 0;
    return dest;
}

char *strncat_s(char *dest, size_t dest_n, const char *src, size_t count) {
    int len = (int)strnlen(dest, dest_n);
    int src_len = 0;
    if (len < count) {
        src_len = (int)strnlen(src, count-len);
        memcpy(&dest[len], src, src_len);
    }
    dest[len+src_len] = 0;
    return dest;
}
#endif

void usage(void) {
    int i;

    printf(
"Generate call graph of a elf binary file. " __DATE__ " build\n"
"Written by Kuoping Hsu, MIT license\n\n"
"Usage:\n"
"    graphgen [-v] [-a target] [-x file] [-r function_name] [-m n]\n"
"             [-g | -t] [-c | -d] [-r name] [-i list] [-h]\n"
"             asm_file [vcg_file]\n\n"
"    --verbose, -v           verbose output\n"
"    --target name, -a name  specify the target (see support target\n"
"                            below)\n"
"    --xml file, -x file     read config file\n"
"    --root func, -r func    specify the root function\n"
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
    for(i=0; i<sizeof_arch; i++) {
        printf("    %s\n", _arch[i].name);
    }

    printf(
"\nExample:\n\n"
"    $ graphgen --max 10 --tree --ignore abort,exit infile.s\n"
"\n"
"      maximun tree depth is 10, generate a call tree, ignode function\n"
"      abort, and exit.\n"
"\n"
"    $ graphgen --xml mycore.xml --tree --root init infile.s\n"
"\n"
"      Use a user-defined processor to generate a call tree from\n"
"      init() function.\n"
"\n"
);

}

// strip space
char * trim(char * s) {
    static char str[MAXSIZE];
    int l = (int)strnlen(s, MAXSIZE-1);

    while(isspace((int)s[l - 1])) --l;
    while(* s && isspace((int)* s)) { ++s, --l; }

    strncpy_s(str, MAXSIZE, s, l-1);
    return str;
}

// generate ignore list to hash
void generate_ignore(void) {
    char *token;

    token = strtok(ignore_list, ",");

    while (token != NULL) {
        char *func_name = trim(token);

        if (func_name[0] != 0) {
            STRING *str;

            if ((str = malloc(sizeof(STRING))) == NULL) {
                printf("malloc fail\n");
                exit(-1);
            }

            strncpy_s(str->name, MAXSIZE-1, func_name, MAXSIZE-1);
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
            if ((list = malloc(sizeof(LIST))) == NULL) {
                printf("malloc fail\n");
                exit(-1);
            }
            memcpy(list, s->list, sizeof(LIST));
            s->list = list;

            p = s->list;
            l = list->next;
            for(i = 0; i<MAXCHILD && l != NULL; i++, l = l->next) {
                if ((list = malloc(sizeof(LIST))) == NULL) {
                    printf("malloc fail\n");
                    exit(-1);
                }
                memcpy(list, l, sizeof(LIST));
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
        strnlen((char*)str, MAXSIZE-1),    /* the length of the subject */
        0,                     /* start at offset 0 in the subject */
        0,                     /* default options */
        match_data,            /* block for storing the result */
        NULL);                 /* use default match context */

    ovector = pcre2_get_ovector_pointer(match_data);

    return rc < 0 ? NULL : ovector;
}

int preparsing(char *filename) {
    FILE *fp;
    pcre2_code *re = NULL;
    pcre2_match_data *match_data = NULL;
    char line[MAXSIZE];
    int i, maxcnt;
    int target_cur;

    if ((fp = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "Can not open file %s\n", filename);
        return -1;
    }

    maxcnt = 0;
    target_cur = 0;
    for(i = 0; i < sizeof_arch; i++) {
        int linecnt = 0;
        int matched = 0;
        target = i;
    	while(!feof(fp) && fgets(line, sizeof(line), fp)) {
       	    PCRE2_SIZE* ovector = NULL;

            if (linecnt++ > MAXLINE)
                break;

            // Cross the section
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      "Disassembly of section.+");
            if (ovector != NULL) {
                continue;
            }

            // function name declare
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_FUNC);
            if (ovector != NULL) {
                matched++;
                continue;
            }

            // get stack size
            if (ITEM_STACK[0] != 0) {
                ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_STACK);

                if (ovector != NULL) {
                    matched++;
                    if (!MULTILINE) continue;
                }
            }

            // get stack size
            if (ITEM_PUSH[0] != 0) {
                ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_PUSH);

                if (ovector != NULL) {
                    matched++;
                    if (!MULTILINE) continue;
                }
            }

            // get loadr
            if (ITEM_LOADR[0] != 0) {
                ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_LOADR);

                if (ovector != NULL) {
                    matched++;
                    if (!MULTILINE) continue;
                }
            }

            // function call
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_CALL);
            if (ovector != NULL) {
                matched++;
                if (!MULTILINE) continue;
            }

            // indirect function call
            ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                      ITEM_CALLR);
            if (ovector != NULL) {
                matched++;
                if (!MULTILINE) continue;
            }
        }

        if (matched > maxcnt) {
            maxcnt = matched;
            target_cur = i;
        }

        if (VERBOSE > 1)
            printf("%s %d patterns match\n", _arch[i].name, matched);

        rewind(fp);
    }

    pcre2_match_data_free(match_data);   /* Release memory used for the match */
    pcre2_code_free(re);                 /* data and the compiled pattern. */
    fclose(fp);

    return target_cur;
}

int create_graph(char *filename) {
    FILE *fp;
    pcre2_code *re = NULL;
    pcre2_match_data *match_data = NULL;
    char line[MAXSIZE];
    char buf[MAXSIZE];
    char name[MAXSIZE];
    int  i;
    unsigned int PC, stack;
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
                strncpy_s(node->name, MAXSIZE-1, name, MAXSIZE-1);
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
                unsigned int size;

                getop(buf, line, ovector, 1);
                sscanf(buf, "%x", &PC);

                getop(buf, line, ovector, 2);
                if (buf[0] == '0' && (buf[1] == 'x' || buf[1] == 'X')) {
                    sscanf(buf, "%x", &size);
                } else {
                    sscanf(buf, "%u", &size);
                }

                stack += size;

                // update stack size
                node->stack_size = stack;

                if (!nostack) stack_info = 1;

                if (!MULTILINE) continue;
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

                for(size=4, i = 0; i < MAXSIZE && buf[i] != 0; i++) {
                    if (buf[i] == ',') size += 4;
                }

                stack += size;

                // update stack size
                node->stack_size = stack;

                if (!nostack) stack_info = 1;

                if (!MULTILINE) continue;
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
                    strncpy_s(regmap[reg], MAXSIZE-1, buf, MAXSIZE-1);

                    // modify the function name
                    for(i=0; regmap[reg][i] != 0 && i < MAXSIZE; i++)
                        if (regmap[reg][i] == '+' || regmap[reg][i] == '-') regmap[reg][i] = '_';
                }
                if (!MULTILINE) continue;
            }
        }

        // function call
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_CALL);
        if (ovector != NULL) {
            int i;
            NODE *s;
            LIST *ptr;
            LIST *list;
            int stackoff = 0;
            int found = 0;
            char key[MAXSIZE];

            if (skip) continue;
            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);

            getop(buf, line, ovector, 2);
            int windows = buf[strnlen(buf, MAXSIZE - 1)-1] - '0';
            if (windows >= 0 && windows <= 9) { // digits
                stackoff = windows * 4;
            }

            getop(name, line, ovector, 3);

            // modify the function name
            for(i=0; i < MAXSIZE && name[i] != 0; i++)
                if (name[i] == '+' || name[i] == '-') name[i] = '_';

            // recursive checking
            if (tree && !strcmp(node->name, name)) {
                node->recursived = 1;
                recursived = 1;
                recursive_count++;

                {
                    RNODE *str = NULL;

                    HASH_FIND_STR(rnode, name, str);

                    if (!str) {
                        fprintf(stderr, "Warning: recursive function %s dectect\n", name);

                        if ((str = malloc(sizeof(RNODE))) == NULL) {
                            printf("malloc fail\n");
                            exit(-1);
                        }

                        strncpy_s(str->name, MAXSIZE-1, name, MAXSIZE-1);
                        HASH_ADD_STR(rnode, name, str);
                    }
                }
                continue;
            }

            snprintf(key, MAXSIZE, "%s:0", name);

            // Is node exist
            HASH_FIND_STR(graph, key, s);

            if (!s) {
                // allocate a node
                s = node_dup(NULL);

                // function name
                strncpy_s(s->name, MAXSIZE-1, name, MAXSIZE-1);
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
                list->attr = stackoff;
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
                    ptr->attr = stackoff;
                    ptr->next = NULL;
                    ptr->child = s;
                }

                if (i == MAXCHILD) {
                    fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                    exit(-1);
                }
            }

            if (VERBOSE > 1 && !found) {
                printf("add %s to %s\n", s->name, node->name);
            }

            if (!MULTILINE) continue;
        }

        // indirect function call
        ovector = regex(re, match_data, (PCRE2_SPTR8)line, (PCRE2_SPTR8)
                  ITEM_CALLR);
        if (ovector != NULL) {
            LIST *ptr;
            LIST *list;
            int stackoff = 0;
            int reg;

            if (skip) continue;
            getop(buf, line, ovector, 1);
            sscanf(buf, "%x", &PC);

            getop(buf, line, ovector, 2);
            int windows = buf[strnlen(buf, MAXSIZE-1)-1] - '0';
            if (windows >= 0 && windows <= 9) { // digits
                stackoff = windows * 4;
            }

            getop(buf, line, ovector, 3);
            reg = atoi(buf);

            if (regmap[reg][0]) {
                NODE *s;
                LIST *ptr;
                LIST *list;
                int found = 0;
                char key[MAXSIZE];

                if (VERBOSE > 1)
                    printf("Indirect function call '%s' detected\n", regmap[reg]);

                // recursive checking
                if (tree && !strcmp(node->name, regmap[reg])) {
                    node->recursived = 1;
                    recursived = 1;
                    recursive_count++;
                    {
                        RNODE *str = NULL;

                        HASH_FIND_STR(rnode, regmap[reg], str);

                        if (!str) {
                            fprintf(stderr, "Warning: recursive function %s dectect\n",
                                    regmap[reg]);

                            if ((str = malloc(sizeof(RNODE))) == NULL) {
                                printf("malloc fail\n");
                                exit(-1);
                            }

                            strncpy_s(str->name, MAXSIZE-1, regmap[reg], MAXSIZE-1);
                            HASH_ADD_STR(rnode, name, str);
                        }
                    }
                    continue;
                }

                snprintf(key, MAXSIZE, "%s:0", regmap[reg]);

                // Is node exist
                HASH_FIND_STR(graph, key, s);

                if (!s) {
                    // allocate a node
                    s = node_dup(NULL);

                    // function name
                    strncpy_s(s->name, MAXSIZE-1, regmap[reg], MAXSIZE-1);
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
                    list->attr = stackoff;
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
                        ptr->attr = stackoff;
                        ptr->next = NULL;
                        ptr->child = s;
                    }

                    if (i == MAXCHILD) {
                        fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                        exit(-1);
                    }
                }

                if (VERBOSE > 1 && !found) {
                    printf("add %s to %s\n", s->name, node->name);
                }
            } else {
                int found = 0;
                indirect++;

                if (unknown == NULL) {
                    // allocate a node
                    unknown = node_dup(NULL);

                    // function name
                    strncpy_s(unknown->name, MAXSIZE-1, "__unknown__", MAXSIZE-1);
                    strncpy_s(unknown->key, MAXSIZE-1, "__unknown__:0", MAXSIZE-1);
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
                    list->attr = stackoff;
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
                        ptr->attr = stackoff;
                        ptr->next = NULL;
                        ptr->child = unknown;
                    }

                    if (i == MAXCHILD) {
                        fprintf(stderr, "Error: out of range for MAXCHILD: %d\n", i);
                        exit(-1);
                    }
                }

                if (VERBOSE > 1 && !found) {
                    printf("add %s to %s\n", unknown->name, node->name);
                }
            }

            if (!MULTILINE) continue;
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
void traverse(NODE *node, int attr) {
    int i;
    LIST *list;
    TNODE *t;

    if (!node) return;

    HASH_FIND_STR(tnode, node->name, t);

    if (!t) {
        fprintf(stderr, "internal data error\n");
        exit(-1);
    }

    frame_pointer += (node->stack_size + attr);
    t->tag = 1;
    node->traversed = 1;
    node->frame_size = frame_pointer;
    if (frame_pointer >= max_frame) {
        max_frame = frame_pointer;
        mark_node = node;
    }
    list = node->list;
    maxdepth++;

    if (maxdepth > depth)
        depth = maxdepth;

    if (VERBOSE > 1)
        printf("%s (%d)\n", node->key, maxdepth);

    if (!list) {
        t->tag = 0;
        maxdepth--;
        frame_pointer -= (node->stack_size + attr);
        return;
    }

    if (maxdepth > MAXDEPTH) {
        if (MAXDEPTH == DEFAULT_MAXDEPTH)
            fprintf(stderr, "warning: exceed max depth of tree\n");
        t->tag = 0;
        node->list = 0;
        maxdepth--;
        frame_pointer -= (node->stack_size + attr);
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
            strncpy_s(tn->name, MAXSIZE-1, list->child->name, MAXSIZE-1);
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
                recursive_count++;

                {
                    RNODE *str = NULL;

                    HASH_FIND_STR(rnode, list->child->name, str);

                    if (!str) {
                        fprintf(stderr, "Warning: detect recursive funcion call at %s\n",
                                list->child->name);

                        if ((str = malloc(sizeof(RNODE))) == NULL) {
                            printf("malloc fail\n");
                            exit(-1);
                        }

                        strncpy_s(str->name, MAXSIZE-1, list->child->name, MAXSIZE-1);
                        HASH_ADD_STR(rnode, name, str);
                    }
                }

                continue;
            }
        }

        list->child->parent = node;

        traverse(list->child, list->attr);
    }

    frame_pointer -= (node->stack_size + attr);
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
                strncpy_s(r->name, MAXSIZE-1, s->name, MAXSIZE-1);
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
                strncpy_s(t->name, MAXSIZE-1, r->node->name, MAXSIZE-1);
                t->tag = 0;
                t->id = r->node->id;
                HASH_ADD_STR(tnode, name, t);
            }
            traverse(r->node, 0);
            mark_tree(mark_node);
            r->frame_size = max_frame;
            if (VERBOSE > 1) printf("root: %s\n", r->node->name);
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
                strncpy_s(t->name, MAXSIZE-1, s->name, MAXSIZE-1);
                t->tag = 0;
                t->id = s->id;
                HASH_ADD_STR(tnode, name, t);
            }

            max_frame = 0;
            mark_node = NULL;
            traverse(s, 0);
            mark_tree(mark_node);
            if (VERBOSE > 0) {
                printf("== stack summary ==\n");
                if (max_frame != 0)
                    printf("root function %s: %d bytes stack usage\n", s->name, max_frame);
                else
                    printf("root function %s\n", s->name);
            }
        } else {
            fprintf(stderr, "can not find the function %s\n", name);
            exit(-1);
        }
    }

    // Shows satck summary
    if (name == NULL && VERBOSE > 0) {
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
    int rcount = 0;

    node_count = 0;
    edge_count = 0;

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

        if (VERBOSE > 1)
            printf("%s: callee addr 0x%08x, prog size: %u, stack size: %u\n",
                    s->name, s->pc, s->prog_size, s->stack_size);

        if (only_linked && !s->traversed)
            continue;

        if (stack_info)
            snprintf(stack, sizeof(stack), "\\nSTACK: %u", s->stack_size);

        if (tree && stack_info)
            snprintf(frame, sizeof(frame), "\\nFRAME: %u", s->frame_size);

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
            "    label: \"%s\\nPROG: %u%s%s\"\n" \
            "    color: %s\n" \
            "  }\n\n",
            s->key,
            s->name,
            s->prog_size,
            stack,
            frame,
            color
        );

        node_count++;

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
            edge_count++;
        }

        if (i != 0) fprintf(fp, "\n");

        if (s->recursived == 1) {
            fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"%s\" color: darkblue linestyle: dashed }\n",
                s->key, s->key);
            edge_count++;
        }

        if (s->recursived == 2) {
            fprintf(fp, "  node: { title: \"__r:%d\" color: darkgrey shape: rhomb width: 5 height: 5 }\n", rcount);
            fprintf(fp, "  edge: { sourcename: \"%s\" targetname: \"__r:%d\" color: darkblue linestyle: dashed }\n",
                s->key, rcount++);
            node_count++;
            edge_count++;
        }

        if (s->recursived == 3) {
            fprintf(fp, "  node: { title: \"__r:%d\" color: darkgrey shape: rhomb width:5 height:5 }\n", rcount);
            fprintf(fp, "  edge: { sourcename: \"__r:%d\" targetname: \"%s\" color: darkblue linestyle: dashed }\n",
                rcount++, s->key);
            node_count++;
            edge_count++;
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

    node_count = 0;
    edge_count = 0;

    if ((fp = fopen(filename, "w")) == NULL) {
        printf("Can not create file %s\n", filename);
        exit(-1);
    }

    fprintf(fp, "digraph callgraph {\n");

    HASH_ITER(hh, graph, s, tmp) {
        char *color;
        char stack[MAXSIZE] = "";
        char frame[MAXSIZE] = "";

        if (VERBOSE > 1)
            printf("%s: callee addr 0x%08x, prog size: %u, stack size: %u\n",
                    s->name, s->pc, s->prog_size, s->stack_size);

        if (only_linked && !s->traversed)
            continue;

        if (stack_info)
            snprintf(stack, sizeof(stack), "|STACK: %u", s->stack_size);

        if (tree && stack_info)
            snprintf(frame, sizeof(frame), "|FRAME: %u", s->frame_size);

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
            "  %s_%d [ label = \"%s|PROG: %u%s%s\" color = %s];\n",
            s->name, s->id,
            s->name,
            s->prog_size,
            stack,
            frame,
            color
        );

        node_count++;

        // Add dot edge
        list = s->list;
        for(i=0; list != NULL; i++) {
            fprintf(fp, "  %s_%d -> %s_%d [color=\"0.650 0.700 0.700\"];\n",
                s->name, s->id, list->child->name, list->child->id);
            list = list->next;
            edge_count++;
        }

        if (s->recursived) {
            fprintf(fp, "  %s_%d -> %s_%d [color=\"0.650 0.700 0.700\"];\n",
                s->name, s->id, s->name, s->id);
            edge_count++;
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
    int automatic = 1;
    int debug = 0;

    const char *optstring = "a:x:vm:gtr:i:hcdDk";
    int c;
    struct option opts[] = {
       {"target", 1, NULL, 'a'},
       {"xml", 1, NULL, 'x'},
       {"verbose", 0, NULL, 'v'},
       {"debug", 0, NULL, 'D'},
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

    if (parse_xml_array (default_xml, sizeof(default_xml)) < 0) {
        fprintf (stderr, "parse default xml failed\n");
        return 1;
    }

    if (argc <= 2) {
        usage();
        return 1;
    }

    while((c = getopt_long(argc, argv, optstring, opts, NULL)) != -1) {
        switch(c) {
            case 'a':
                for(i=0; i<sizeof_arch; i++) {
                    if (!strcmp(optarg, _arch[i].name)) break;
                }
                if (i == sizeof_arch) {
                    usage();
                    fprintf(stderr, "\n!!Error!! Do not support the target arch '%s'.\n", optarg);
                    return 1;
                } else {
                    target = i;
                }
                automatic = 0;
                break;
            case 'x':
                strncpy_s(xmlfile, sizeof(xmlfile)-1, optarg, sizeof(xmlfile)-1);
                if (!xmlparse(xmlfile)) {
                    fprintf(stderr, "program exit\n");
                    return 1;
                }
                break;
            case 'v':
                VERBOSE = 1;
                break;
            case 'D':
                debug = 1;
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
                strncpy_s(root_node, sizeof(root_node)-1, optarg, sizeof(root_node)-1);
                break;
            case 'i':
                strncpy_s(ignore_list, sizeof(ignore_list)-1, optarg, sizeof(ignore_list)-1);
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

    if (debug)
        VERBOSE = 2;

    if (((argc - optind) != 1) && (((argc - optind) != 2))) {
        usage();
        return 1;
    }

    strncpy_s(infile, sizeof(infile)-1, argv[optind], sizeof(infile)-1);

    if (argc - optind == 2) {
        strncpy_s(outfile, sizeof(outfile)-1, argv[optind+1], sizeof(outfile)-1);
    } else {
        int i = 0;
        strncpy_s(outfile, sizeof(outfile)-1, argv[optind], sizeof(outfile)-1);
        for(i=(int)strnlen(outfile,MAXSIZE)-1; i>0 && outfile[i]!='.'; i--) ;
        if (i != 0) outfile[i] = 0;
        strncat_s(outfile, MAXSIZE, ".vcg", MAXSIZE);
    }

    if (automatic) {
        int result;
        result = preparsing(infile);
        if (result < 0) return 1;
        target = result;
        printf("Parsing target '%s'\n", ITEM_NAME);
    }

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

    printf("\nGraph info:\n");
    printf("===========\n");
    printf("Total node count: %d\n", node_count);
    printf("Total edge count: %d\n", edge_count);
    if (recursive_count)
        printf("Detected recursive count: %d\n", recursive_count);
    if (indirect)
        printf("Indirect function call: %d\n", indirect);
    if (tree)
        printf("The depthest node is at level %d.\n", depth);
    printf("\n");

    return 0;
}

