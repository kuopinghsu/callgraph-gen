// I forgot where I got this sample code. I made minor changes.
// If anyone knows the source of the code, please let me know.
// I will add notes on this source code.

#include "graphgen.h"

#include <libxml/parser.h>
#include <libxml/tree.h>

extern int VERBOSE;

int
parse_xml_array (char *buf, int len)
{
    xmlDocPtr doc;
    xmlNodePtr root, node, detail;
    xmlChar *name, *value;

    target = -1;
    doc = xmlParseMemory (buf, len);    //parse xml in memory

    if (doc == NULL) {
        if (VERBOSE > 1) printf ("doc == null\n");
        return -1;
    }

    root = xmlDocGetRootElement (doc);

    for (node = root->children; node; node = node->next) {
        if (xmlStrcasecmp (node->name, BAD_CAST "content") == 0)
            break;
    }

    if (node == NULL) {
        if (VERBOSE > 1) printf ("no node = content\n");
        return -1;
    }

    for (node = node->children; node; node = node->next) {
        if (xmlStrcasecmp (node->name, BAD_CAST "ncore") == 0) {    //get pro node
            name = xmlGetProp (node, BAD_CAST "id");
            value = xmlNodeGetContent (node);

            //get value, CDATA is not parse and don't take into value
            if (VERBOSE > 1)
                printf ("this is %s: %s\n", (char *) name, (char *) value);

            sizeof_arch = atoi((char*) value);

            if (sizeof_arch <= 0) {
                fprintf(stderr, "ncore <= 0\n");
                return -1;
            }

            if ((_arch = malloc(sizeof_arch * sizeof(ARCH))) == NULL) {
                fprintf(stderr, "malloc fail\n");
                return -1;
            }

            xmlFree (name);
            xmlFree (value);
        } else if (xmlStrcasecmp (node->name, BAD_CAST "core") == 0) {  //get pro node
            char *str;

            name = xmlGetProp (node, BAD_CAST "id");
            value = xmlNodeGetContent (node);

            //get value, CDATA is not parse and don't take into value
            if (VERBOSE > 1)
                printf ("this is %s: %s\n", (char *) name, (char *) value);

            target++;
            if ((str = malloc(strnlen((char*) value, MAXSTRLEN)+1)) == NULL) {
                fprintf(stderr, "malloc fail\n");
                return -1;
            }

            strncpy_s(str, MAXSTRLEN-1, (char*)value, MAXSTRLEN-1);
            ITEM_NAME = str;

            xmlFree (name);
            xmlFree (value);
        } else if (xmlStrcasecmp (node->name, BAD_CAST "details") == 0) {   //get details node
            for (detail = node->children; detail; detail = detail->next) {  //traverse detail node
                if (xmlStrcasecmp (detail->name, BAD_CAST "detail") == 0) {
                    char *str;

                    name = xmlGetProp (detail, BAD_CAST "name");
                    value = xmlNodeGetContent (detail);

                    if (strnlen ((char *) value, MAXSTRLEN) != 0) {
                        if (VERBOSE > 1) printf ("%s : %s\n", (char *) name, (char *) value);
                    } else {
                        if (VERBOSE > 1) printf ("%s has no value\n", (char *) name);
                    }

                    if ((str = malloc(strnlen((char*) value, MAXSTRLEN)+1)) == NULL) {
                        fprintf(stderr, "malloc fail\n");
                        return -1;
                    }

                    strncpy_s(str, MAXSTRLEN-1, (char*)value, MAXSTRLEN-1);

                    if (!strcmp((char*)name, "func")) {
                        ITEM_FUNC = str;
                    } else if (!strcmp((char*)name, "stack")) {
                        ITEM_STACK = str;
                    } else if (!strcmp((char*)name, "push")) {
                        ITEM_PUSH = str;
                    } else if (!strcmp((char*)name, "loader")) {
                        ITEM_LOADR = str;
                    } else if (!strcmp((char*)name, "call")) {
                        ITEM_CALL = str;
                    } else if (!strcmp((char*)name, "callx")) {
                        ITEM_CALLR = str;
                    } else if (!strcmp((char*)name, "jump")) {
                        ITEM_JUMP = str;
                    } else if (!strcmp((char*)name, "multiline")) {
                        MULTILINE = atoi((char*) str);
                        free(str);
                    }

                    xmlFree (name);
                    xmlFree (value);
                }
            }
        }
    }

    xmlFreeDoc (doc);
    return 0;
}

int
xmlparse (char *xmlfile)
{
    char   *content;
    unsigned long filesize;
    FILE   *file;

    if (!xmlfile) return 1;
    if (!xmlfile[0]) return 1;

    if ((file = fopen (xmlfile, "r")) == NULL) {
        fprintf (stderr, "openf file %s error", xmlfile);
        return 0;
    }

    fseek (file, 0, SEEK_END);
    filesize = ftell (file);
    rewind (file);
    content = (char *) malloc (filesize + 1);
    memset (content, 0, filesize + 1);

    if (fread (content, 1, filesize, file) != filesize) {
        fprintf (stderr, "file %s read failed", xmlfile);
        fclose(file);
        free(content);
        return 0;
    }

    fclose (file);

    if (parse_xml_array (content, filesize) < 0) {
        fprintf (stderr, "parse xml %s failed\n", xmlfile);
        return 0;
    }

    return 1;
}

