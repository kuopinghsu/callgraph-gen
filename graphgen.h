// Written by Kuo-Ping Hsu
// MIT license

#ifndef __GRAPHGEN_H__
#define __GRAPHGEN_H__

int target = 0;

typedef struct _ARCH {
    char *name;
    char *pat[6];
} ARCH;

ARCH arch[] = {
    { .name = "riscv",
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
        "^\\s*([0-9A-Fa-f]+):.+\\s+jal\\s+\\S+,[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+jalr\\s+(\\S+)"
      }
    },
    { .name = "arm",
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
        "^\\s*([0-9A-Fa-f]+):.+\\s+bl\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+blx\\s+(\\S+)"
      }
    },
    { .name = "openrisc",
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
        "^\\s*([0-9A-Fa-f]+):.+\\s+l\\.jal\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+\\s+l\\.jalr\\s+(\\S+)"
      }
    },
};

#define ITEM_FUNC  arch[target].pat[0]
#define ITEM_STACK arch[target].pat[1]
#define ITEM_PUSH  arch[target].pat[2]
#define ITEM_LOADR arch[target].pat[3]
#define ITEM_CALL  arch[target].pat[4]
#define ITEM_CALLR arch[target].pat[5]

#endif // __GRAPHGEN_H__

