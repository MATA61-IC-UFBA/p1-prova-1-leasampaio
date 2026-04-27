%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *msg);

%}

%token INT FLOAT IDENT STRING
%token PRINT CONCAT LENGTH
%token ASSIGN LPAREN RPAREN COMMA
%token ERROR

%left '+' '-'
%left '*' '/'

%start program

%%

program
    : stmt_list
    ;

stmt_list
    : stmt
    | stmt_list stmt
    ;

stmt
    : IDENT ASSIGN expr
    | PRINT LPAREN exprlist RPAREN
    | expr
    ;

exprlist
    : expr
    | exprlist COMMA expr
    ;

expr
    : INT
    | FLOAT
    | IDENT
    | STRING
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | LPAREN expr RPAREN
    | CONCAT LPAREN exprlist RPAREN
    | LENGTH LPAREN expr RPAREN
    ;

%%
