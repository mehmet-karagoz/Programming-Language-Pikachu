%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern YYSTYPE yylval;
extern int yylineno;
extern int yylex();
void yyerror(const char* s);

%}

NUMBER      [0-9]+
STRING_DELIM \"
BOOLEAN_VAL (TRUE|FALSE|true|false|T|F|t|f)
PRINT_EXP   Pikachu:
COMMENT     ^@.*
ASSIGN      =
VARIABLE    [a-zA-Z]
IF          Pika
ELSE        Ash
WHILE       WhilePika
FUNCTION    Bulbasour
OPERATOR    (\+|\-|\*|\/)
EQUALS      (is|==)
NOT         (not|!)
LPAREN      [\(]
RPAREN      [\)]
COMMA      ,

%%

{COMMENT}         { ;}
{LPAREN}           { return LPAREN; }
{RPAREN}           { return RPAREN; }
{COMMA}            { return COMMA; }
{EQUALS}            { return EQUALS; }
{NOT}               { return NOT; }
{BOOLEAN_VAL}       { return BOOLEAN_VAL; }
{FUNCTION}          { return FUNCTION; }
{NUMBER}            { yylval.number = atoi(yytext); return NUMBER; }
{STRING_DELIM}[^\"\n]*{STRING_DELIM} { yylval.string = strdup(yytext + 1); yylval.string[strlen(yytext) - 2] = '\0'; return STRING ; }
{IF}                { return IF; }
{ELSE}              { return ELSE; }
{WHILE}             { return WHILE; }
{PRINT_EXP}         { return PRINT_EXP; }
{ASSIGN}            { return ASSIGN; }
{VARIABLE}          { yylval.variable = yytext[0]; return VARIABLE; }
{OPERATOR}          { return *yytext; }
[ \t{};]+            ;
\n                { yylineno++; } /* Increment line number */
.                   { yyerror("Unrecognized character"); }

%%

int yywrap(void) {
    return 1;
}
