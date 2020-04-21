// Written by Kuo-Ping Hsu
// MIT license

#ifndef __GRAPHGEN_H__
#define __GRAPHGEN_H__

#define MAXSTRLEN 1024

typedef struct _ARCH {
    char *name;
    int   multiline;
    char *pat[6];
} ARCH;

#ifdef __DEF_ARRAY__
ARCH        *_arch = NULL;
int          sizeof_arch = 0;
int          target = 0;
#else // __DEF_ARRAY__
extern ARCH *_arch;
extern int   sizeof_arch;
extern int   target;
#endif // __DEF_ARRAY__

#define MULTILINE  _arch[target].multiline
#define ITEM_NAME  _arch[target].name
#define ITEM_FUNC  _arch[target].pat[0]
#define ITEM_STACK _arch[target].pat[1]
#define ITEM_PUSH  _arch[target].pat[2]
#define ITEM_LOADR _arch[target].pat[3]
#define ITEM_CALL  _arch[target].pat[4]
#define ITEM_CALLR _arch[target].pat[5]

#define strncpy_s __strncpy_s
int xmlparse(char*);
int parse_xml_array (char *buf, int len);
char *strncpy_s(char *dest, const char *src, size_t n);

#endif // __GRAPHGEN_H__

