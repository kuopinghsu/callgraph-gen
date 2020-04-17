// Written by Kuo-Ping Hsu
// MIT license

#ifndef __GRAPHGEN_H__
#define __GRAPHGEN_H__

typedef struct _ARCH {
    char *name;
    int   multiline;
    char *pat[6];
} ARCH;

#ifdef __DEF_ARRAY__
#ifdef __PREDEFINED_ARRAY__
ARCH arch[] = {
    { .name = "riscv",
      .multiline = 0,
      .pat = {
        // function name declaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "^\\s*([0-9A-Fa-f]+):.+\\s+addi\\s+sp,sp,\\-(\\d+)",
        // push
        "",
        // loadr
        "",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(jal)\\s+\\S+,[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(jalr)\\s+(\\S+)"
      }
    },
    { .name = "arm",
      .multiline = 0,
      .pat = {
        // function name delcaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "^\\s*([0-9A-Fa-f]+):.+\\s+sub\\s+sp,\\s*sp,\\s*#(\\d+)",
        // push
        "^\\s*([0-9A-Fa-f]+):.+\\s+push\\s+{(.+)}",
        // loadr
        "",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(bl)\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(blx)\\s+(\\S+)"
      }
    },
    { .name = "openrisc",
      .multiline = 0,
      .pat = {
        // function name delcaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "^\\s*([0-9A-Fa-f]+):.+l\\.\\s+l\\.addi\\s+r1,\\s*r1,\\s*\\-([0-9A-Fa-fxX]+)",
        // push
        "",
        // loadr
        "",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(l\\.jal)\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+(l\\.jalr)\\s+(\\S+)"
      }
    },
};

ARCH *_arch = (ARCH *)arch;
int sizeof_arch = sizeof(arch)/sizeof(ARCH);
int target = 0;
#else // __PREDEFINED_ARRAY__
ARCH *_arch = NULL;
int sizeof_arch = 0;
int target = 0;
#endif
#else // __DEF_ARRAY__
extern ARCH *_arch;
extern int sizeof_arch;
extern int target;
#endif // __DEF_ARRAY__

#define MULTILINE  _arch[target].multiline
#define ITEM_NAME  _arch[target].name
#define ITEM_FUNC  _arch[target].pat[0]
#define ITEM_STACK _arch[target].pat[1]
#define ITEM_PUSH  _arch[target].pat[2]
#define ITEM_LOADR _arch[target].pat[3]
#define ITEM_CALL  _arch[target].pat[4]
#define ITEM_CALLR _arch[target].pat[5]

int xmlparse(char*);
int parse_xml_array (char *buf, int len);

#endif // __GRAPHGEN_H__

