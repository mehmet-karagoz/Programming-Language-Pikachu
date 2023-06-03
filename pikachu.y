%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char* yytext;
extern FILE* yyin;

void yyerror(const char* s);

// store variables in an array of int a-z = 0-25 A-Z = 26-51
int variables[52];
int body = 0;

int get_variable_index(char* variable) {
    int index = -1;
    if (variable[0] >= 'a' && variable[0] <= 'z') {
        index = variable[0] - 'a';
    } else if (variable[0] >= 'A' && variable[0] <= 'Z') {
        index = variable[0] - 'A' + 26;
    }
    return index;
}

void set_variable(char variable, int value) {
    int index = get_variable_index(&variable);
    if (index != -1) {
        variables[index] = value;
        printf("Set %c to %d\n", variable, value);
    }

}

int get_variable(char variable) {
    int index = get_variable_index(&variable);
    if (index != -1) {
        return variables[index];
    }
    return 0;
}
void my_function(int arg1) {
    int result = arg1 * body;
    printf("Function called argument with %d. The result of this function: %d\n", arg1,result);
}

%}

%union {
    int number;
    char variable;
    char* string;
    void (*func)(int);
}

%token <variable> VARIABLE 
%token <number> NUMBER
%token <string> STRING
%token <number> BOOLEAN_VAL
%token ASSIGN
%token PRINT_EXP
%token IF
%token ELSE
%token WHILE
%token <func> FUNCTION
%token <string> OPERATOR
%token EQUALS
%token NOT
%token LPAREN
%token RPAREN
%token COMMA

%type <variable> assign_statement
%type <variable> print_statement
%type <number> expression
%type <number> term
%type <number> boolean_expression
%type <variable> statement
%type <variable> statement_list
%type <variable> if_statement
%type <variable> while_statement
%type <func> function_call

%left '+'
%left '-'
%left '*'
%left '/'

%start prog

%%

prog: statement_list
    ;

statement_list: statement
              | statement_list statement
              ;

statement: assign_statement 
         | print_statement 
         | if_statement
         | while_statement
            | function_call
         ;

assign_statement: VARIABLE ASSIGN expression { set_variable($1, $3); }
    ;

print_statement: PRINT_EXP expression { printf("%d\n", $2); }
    | PRINT_EXP STRING { printf("%s\n", $2); }
    | PRINT_EXP boolean_expression { printf("%s\n", $2 ? "true" : "false"); }
    ;

term: NUMBER { $$ = $1; }
    | VARIABLE { $$ = get_variable($1); }
    ;

expression: term { $$ = $1; }
          | expression '+' expression { $$ = $1 + $3; }
          | expression '-' expression { $$ = $1 - $3; }
          | expression '*' expression { $$ = $1 * $3; }
          | expression '/' expression { $$ = $1 / $3; }
          ;

boolean_expression: BOOLEAN_VAL { $$ = $1; }
                    | expression EQUALS expression { $$ = ($1 == $3); $$==1 ? 1 : 0; }
                    | NOT boolean_expression { $$ = !$2; }
                  ;

if_statement: IF boolean_expression statement %prec IF { $$ = $2; if ($$==1) { printf("Inside If\n"); $$ = $3; } }
    | IF boolean_expression statement ELSE statement  %prec IF {$$ = $2;  if ($$==1) { printf("Indside If\n");$$ = $3; } else { printf("Inside Else\n");$$ = $3; } }
    ;

while_statement: WHILE boolean_expression statement %prec WHILE {
    $$ = $2;
    while ($$ == 1) {
        printf("Inside While %d \n",$2);
        $3; // Execute the statement
        $$ = $2; // Update the boolean expression for the next iteration
        break;
    }
}
;

function_call: FUNCTION LPAREN NUMBER RPAREN expression { body=$5;$<func>$ = my_function; $<func>$( $3); }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error opening file: %s\n", argv[1]);
            return 1;
        }
    }
    yyparse();
    return 0;
}
