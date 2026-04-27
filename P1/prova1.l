%{
#include "prova1.tab.h"
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
int yylex();
%}

%option noyywrap

DIGIT       [0-9]
LETTER      [a-zA-Z_]
INT         {DIGIT}+
FLOAT       {DIGIT}+"."{DIGIT}+
IDENT       {LETTER}({LETTER}|{DIGIT})*
STRING      \"[^\"\n]*\"

%%

[ \t\r\n]+         { /* whitespace */ }
"//".*             { /* comentario de uma linha */ }
for f in e2-tests/*.in; do ./prova1 "$f" /tmp/out.txt; diff /tmp/out.txt "${f%.in}.ora" && echo "ok $f"; done
"print"            { return PRINT; }
"concat"           { return CONCAT; }
"length"           { return LENGTH; }

{FLOAT}            { return FLOAT; }
{INT}              { return INT; }
{IDENT}            { return IDENT; }
{STRING}           { return STRING; }

"="                { return ASSIGN; }
"("                { return LPAREN; }
")"                { return RPAREN; }
","                { return COMMA; }
"+"                { return '+'; }
"-"                { return '-'; }
"*"                { return '*'; }
"/"                { return '/'; }

.                  { return ERROR; }

%%
