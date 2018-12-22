# callgraph
Generating the call graph from elf binary file

# Getting Started
It requires following library to build the code.

uthash: hash library
https://troydhanson.github.io/uthash/userguide.html

PCRE: Perl Compatible Regular Expressions
https://www.pcre.org/

Install the PCRE library to /usr/local directory.

Checkout the repository and initialize all submodules

```
$ git clone https://github.com/kuopinghsu/callgraph.git
$ git submodule update --init --recursive
```

build

```
$ make
```

# Features

- Generate call graph
- Generate call tree
- Recursive detection
- Calculate the stack usage

This is an example of call graph.<br>
<img src="https://github.com/kuopinghsu/callgraph/blob/master/images/dhrystone-callgraph.svg" alt="Dhrystone Call Graph" width=640>

This is an example of a call tree, and the red arc represents the call path used by the largest stack<br>
<img src="https://github.com/kuopinghsu/callgraph/blob/master/images/dhrystone-calltree.svg" alt="Dhrystone Call Tree" width=640>

(Note: This is a static analysis and is inaccurate if an indirect function call or recursion is detected.)

# Usage
```
Generate call graph of a elf binary file.

Usage:
    graphgen [-v] [-a target] [-m n] [-g | -t] [-c | -d] [-r name]
             [-i list] [-h] asm_file vcg_file

    --verbose, -v           verbose output
    --target name, -a name  specify the target (see support target below)
    --max n, -m n           max depth (default 256)
    --graph, -g             generate call graph (default)
    --tree, -t              generate call tree
    --vcg                   generate vcg graph (default)
    --dot                   generate dot graph
    --ignore list, -i list  ignore list
    --help, -h              help

Support target:
    riscv (default)
    arm
    openrisc

Example:
    $ graphgen --max 10 --tree --ignore abort,exit infile.s outfile.vcg

    maximun tree depth is 10, generate a call tree, ignode function abort, and exit
```

This is an example to show the call tree of RISC-V's dhrystone diag. Using binutils to generate the assembly file

```
riscv64-unknown-elf-objdump -d dhrystone.riscv > dhrystone.s
```

Generate the VCG file

```
graphgen --target riscv --tree dhrystone.s dhrystone.vcg
```

Recomment use <A Href="https://pp.ipd.kit.edu/firm/yComp.html">yComp</A> to browse the VCG file.<br>

<img src="https://github.com/kuopinghsu/callgraph/blob/master/images/yComp.png" alt="yComp">

# license
MIT license
