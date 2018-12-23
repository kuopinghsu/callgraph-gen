// Written by Kuo-Ping Hsu
// MIT license

#ifndef __GRAPHGEN_H__
#define __GRAPHGEN_H__

int target = 0;

typedef struct _ARCH {
    char *name;
    char *pat[4];
} ARCH;

ARCH arch[] = {
    { .name = "riscv",
      .pat = {
        // function name declaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "^\\s*([0-9A-Fa-f]+):.+addi\\s+sp,sp,\\-(\\d+)",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+jal\\s+\\S+,[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+jalr\\s+\\S+"
      }
    },
    { .name = "arm",
      .pat = {
        // function name delcaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "", // "^\\s*([0-9A-Fa-f]+):.+sub\\s+sp,\\s*sp,\\s*#(\\d+)",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+bl\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+blx\\s+\\S+"
      }
    },
    { .name = "openrisc",
      .pat = {
        // function name delcaration
        "^([0-9A-Fa-f]+)\\s+<([^\\+^\\-]+)>:",
        // stack allocation
        "^\\s*([0-9A-Fa-f]+):.+l\\.addi\\s+r1,\\s*r1,\\s*\\-([0-9A-Fa-fxX]+)",
        // function call
        "^\\s*([0-9A-Fa-f]+):.+jal\\s+[0-9A-Fa-f]+\\s+<(.+)>",
        // indirect function call
        "^\\s*([0-9A-Fa-f]+):.+jalr\\s+\\S+"
      }
    },
};

#define ITEM_FUNC  arch[target].pat[0]
#define ITEM_STACK arch[target].pat[1]
#define ITEM_CALL  arch[target].pat[2]
#define ITEM_CALLR arch[target].pat[3]

#endif // __GRAPHGEN_H__

