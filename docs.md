# Compiler
source code  =>  compiler =>  machine code (0 / 1)

source code => lexer => tokens => parser => tree => machine code

## lexer
- tokenize source code
- check for errors

## parser
- parse tokens into tree

```
tokens = 10 + 20 * 3
      +
    /   \
   10    *
        / \
       20  3

```

