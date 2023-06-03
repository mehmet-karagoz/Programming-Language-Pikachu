# Pikachu Language Project
[![Language](https://img.shields.io/badge/Language-C-blue.svg)](https://en.wikipedia.org/wiki/C_(programming_language))
[![Language](https://img.shields.io/badge/Language-Lex-yellow.svg)](https://en.wikipedia.org/wiki/Lex_(software))
[![Language](https://img.shields.io/badge/Language-Yacc-green.svg)](https://en.wikipedia.org/wiki/Yacc)


>Project for CSE 334 - Programming Languages

>Project Members: [Gizem Akturk](https://github.com/gizemakturk) and [Mehmet Karagoz](https://github.com/mehmet-karagoz)

This project is an example implementation of a Yacc (Yet Another Compiler Compiler) parser using the yacc tool in C. The parser reads input files written in a specific grammar and performs parsing and actions based on the grammar rules.

The purpose of this project is to demonstrate how to build a basic programming language parser using Yacc. It showcases the use of lexical analysis (implemented with Lex) and syntax analysis (implemented with Yacc) to process input files according to a defined grammar.

The implemented grammar supports variable assignments, arithmetic expressions, print statements, if-else statements, while loops, error-handling and function calls. It provides a foundation for building more complex programming languages or interpreters.

## Table of Contents

- [Pikachu Language Project](#pikachu-language-project)
	- [Table of Contents](#table-of-contents)
	- [BNF Form](#bnf-form)
	- [Types of Tokens](#types-of-tokens)
	- [Building and Running the Project](#building-and-running-the-project)
	- [Example Input](#example-input)
		- [Operations](#operations)
		- [If-Else Statement](#if-else-statement)
		- [While Loop](#while-loop)
		- [Function Call](#function-call)
		- [Error Handling and Comments](#error-handling-and-comments)
	- [Summary](#summary)


## BNF Form

```bnf
<prog>               ::= <statement_list>

<statement_list>     ::= <statement>
                      | <statement_list> <statement>

<statement>          ::= <assign_statement>
                      | <print_statement>
                      | <if_statement>
                      | <while_statement>
                      | <function_call>

<assign_statement>   ::= VARIABLE ASSIGN <expression>

<print_statement>    ::= PRINT_EXP <expression>
                      | PRINT_EXP STRING
                      | PRINT_EXP <boolean_expression>

<term>               ::= NUMBER
                      | VARIABLE

<expression>         ::= <term>
                      | <expression> '+' <expression>
                      | <expression> '-' <expression>
                      | <expression> '*' <expression>
                      | <expression> '/' <expression>

<boolean_expression> ::= BOOLEAN_VAL
                      | <expression> EQUALS <expression>
                      | NOT <boolean_expression>

<if_statement>       ::= IF <boolean_expression> <statement> %prec IF
                      | IF <boolean_expression> <statement> ELSE <statement> %prec IF

<while_statement>    ::= WHILE <boolean_expression> <statement> %prec WHILE

<function_call>      ::= FUNCTION LPAREN NUMBER RPAREN <expression>

```

- `<prog>`: Represents the starting non-terminal symbol, which denotes the program.
- `<statement_list>`: Represents a list of statements in the program.
- `<statement>`: Represents a single statement in the program, which can be an assignment statement, print statement, if statement, while statement, or function call.
- `<assign_statement>`: Represents an assignment statement, where a variable is assigned a value.
- `<print_statement>`: Represents a print statement, which outputs the result of an expression or a string to the console.
- `<term>`: Represents a term in an arithmetic expression, which can be a number or a variable.
- `<expression>`: Represents an arithmetic expression composed of terms and operators.
- `<boolean_expression>`: Represents a boolean expression, which can be a boolean value, a comparison between expressions, or a negation of a boolean expression.
- `<if_statement>`: Represents an if statement, which executes a statement if a given boolean expression evaluates to true. It can also include an optional else statement for alternative execution.
- `<while_statement>`: Represents a while statement, which repeatedly executes a statement as long as a given boolean expression evaluates to true.
- `<function_call>`: Represents a function call, which invokes a function with a specified argument and an expression to determine a local variable called `body`.

These production rules define the structure and behavior of the language defined by the grammar. Understanding these parts will help in comprehending the functionality and flow of the program implemented using this yacc file.

## Types of Tokens

The following table lists the types of tokens used in the grammar and their corresponding values.
- `<variable>`: Represents a variable token.
- `<number>`: Represents a number token.
- `<string>`: Represents a string token.
- `<func>`: Represents a function token.

## Building and Running the Project

> **Note:** This project requires the `yacc` and `lex` tools to be installed on the system. The project was developed and tested on Ubuntu LTS.


The project can be built and run using the following commands:
```bash
make	
./pikachu example.mg
```
or
```bash
make	
./pikachu < example.mg
```

The `make` command will build the project using the `Makefile` and generate the executable file `pikachu`. The `pikachu` executable can then be run with an input file as an argument. The input file should contain a program written in the grammar defined in the yacc file.

## Example Input

The following is an example input file that can be used to test the program. It contains a program written in the grammar defined in the yacc file.

### Operations

**Input:**
```bash
x = 5
y = 10
z = x + y
Pikachu: z
```
**Output:**
```bash
Set x to 5
Set y to 10
Set z to 15
15
```

### If-Else Statement

**Input:**
```bash
a = 2
Pika a == 2
    a = 3
Ash
    a = 4
```
**Output:**
```bash
Set a to 2
Set a to 3
Indside If
```

### While Loop

**Input:**
```bash
a = 3
WhilePika not a == 4
    a = a + 1
```
**Output:**
```bash
Set a to 3
Set a to 4
Inside While 1 
```

### Function Call
**Input:**
```bash
a = 5
Bulbasour (3) a 
```
**Output:**
```bash
Set a to 5
Function called argument with 3. The result of this function: 15
```

### Error Handling and Comments
**Input:**
```bash
@ Error handling example in comment

Pikachu: +-*0
```
**Output:**
```bash
Error: syntax error at line 3
```

## Summary

This project demonstrates the implementation of a programming language using yacc. It defines a grammar for the language and uses yacc to generate a parser for the language. The parser is then used to parse a program written in the language and execute it. The program also demonstrates the use of error handling and comments in the language.
> **Note:** If you want to clean codes, you need to run `make clean` .


[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=11182905&assignment_repo_type=AssignmentRepo)