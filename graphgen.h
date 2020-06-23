// Written by Kuo-Ping Hsu
// MIT license

#ifndef __GRAPHGEN_H__
#define __GRAPHGEN_H__

#define _CRT_SECURE_NO_WARNINGS 1

#if defined(__MINGW__) || defined(_MSC_VER)
#define __STDC_WANT_LIB_EXT1__ 1
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <stdint.h>

#define MAXSTRLEN 1024

typedef struct _ARCH {
    char *name;
    int   multiline;
    char *pat[7];
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
#define ITEM_JUMP  _arch[target].pat[6]

int xmlparse(char*);
int parse_xml_array (char *buf, int len);

#if defined __APPLE__
#  define strncpy_s(a,b,c,d) strlcpy(a,c,d)
#  define strncat_s(a,b,c,d) strlcat(a,c,d)
#elif !defined(__STDC_WANT_LIB_EXT1__)
#  define strncpy_s __strncpy_s
#  define strncat_s __strncat_s
char *strncpy_s(char *dest, size_t n, const char *src, size_t count);
char *strncat_s(char *dest, size_t n, const char *src, size_t count);
#endif

#endif // __GRAPHGEN_H__

