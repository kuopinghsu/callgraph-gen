# callgraph
Generating the call graph from elf binary file

# pre-requirment
It requires following library to build the code.

uthash: hash library
    https://troydhanson.github.io/uthash/userguide.html

PCRE: Perl Compatible Regular Expressions
    https://www.pcre.org/

# features

An example of call graph:<br>
<img src="https://github.com/kuopinghsu/callgraph/blob/master/images/dhrystone-callgraph.svg" alt="Dhrystone Call Graph" width=640>

An example of call tree:<br>
<img src="https://github.com/kuopinghsu/callgraph/blob/master/images/dhrystone-calltree.svg" alt="Dhrystone Call Tree" width=640>

# usage

Usage: graphgen [-v] [-a target] [-m n] [-g | -t] [-c | -d] [-r name]
        [-i list] [-h] asm_file vcg_file

        --verbose, -v           verbose output
        --target, -a            specify the target arch
        --max n, -m n           max depth (default 256)
        --graph, -g             generate call graph (default)
        --tree, -t              generate call tree
        --vcg                   generate vcg graph (default)
        --dot                   generate dot graph
        --ignore list, -i list  ignore list
        --help, -h              help

Support target arch:
        riscv (default)
        arm
        openrisc

Example:
    graphgen --max 10 --tree --ignore _exit,abort infile.s outfile.vcg

        maximun tree depth is 10, generate a call tree
        ignode function _exit and abort

# license
MIT license
