%{
#include "parser.tab.h"

%}

%option noyywrap
%option yylineno


%%
[ \t\n]     { /* ignore whitespace */ }

"SELECT"  {printf("%s ",yytext);return SELECT;}
"DELETE"  {printf("%s ",yytext);return DELETE;}
"INSERT"  {printf("%s ",yytext);return INSERT;}
"UPDATE"  {printf("%s ",yytext);return UPDATE;}
"FROM"    {printf("%s ",yytext);return FROM;}
"WHERE"   {printf("%s ",yytext);return WHERE;}
"INTO"    {printf("%s ",yytext);return INTO;}
"VALUES"  {printf("%s ",yytext);return VALUES;}
"SET"     {printf("%s ",yytext);return SET;}
"CREATE"     {printf("%s ",yytext);return CREATE;}
"TABLE"     {printf("%s ",yytext);return TABLE;}
"INT"     {printf("%s ",yytext);return INT;}
"FLOAT"     {printf("%s ",yytext);return FLOAT;}
"STRING"     {printf("%s ",yytext);return STRING;}
"BOOLEAN"     {printf("%s ",yytext);return BOOLEAN;}
"ADD"     {printf("%s ",yytext);return ADD;}
"DROP"     {printf("%s ",yytext);return DROP;}
"MODIFY"     {printf("%s ",yytext);return MODIFY;}
"RENAME"     {printf("%s ",yytext);return RENAME;}
"TO"     {printf("%s ",yytext);return TO;}
"ALTER"   {printf("%s ",yytext);return ALTER;}
"IF"   {printf("%s ",yytext);return IF;}
"EXISTS"   {printf("%s ",yytext);return EXISTS;}


"*"       {printf("%s ",yytext);return ASTERISK;}
">"       {printf("%s ",yytext);return GT;}
"<"      {printf("%s ",yytext);return LT;}
"="       {printf("%s ",yytext);return EQ;}


[+-]?[0-9]+(\.[0-9]*)?  {printf("%s ",yytext);return LITERAL;}
'[^']*'|\"[^"]*\"       {printf("%s ",yytext);return LITERAL;}


[a-zA-Z]+[a-zA-Z0-9_]*  {printf("%s ",yytext);return IDENTIFIER;}
";"      {printf("%s ",yytext); return SEMICOLON;}
.          {return yytext[0]; }
%%