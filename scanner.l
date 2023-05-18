%{
#include <stdio.h>
%}
%option noyywrap
%option yylineno
%%

CREATE   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
ALTER    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
DROP     { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
ADD      { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}

SET    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
TABLE    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
SELECT   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
DELETE   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
INSERT   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
UPDATE   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
FROM     { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
WHERE    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
MODIFY   { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
IF      { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
EXISTS  { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
RENAME    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
VALUES    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
INT    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
FLOAT    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
STRING    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}
BOOLEAN    { fprintf(yyout, "<KEYWORD,%s,%d>", yytext,yylineno);}


\*       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}
\+       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}
\-       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}
\>       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}
\<       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}
\=       { fprintf(yyout, "<OPERATOR,%s,%d>", yytext,yylineno);}

[+-]?[0-9]+(\.[0-9]*)?   { fprintf(yyout, "<LITERAL,%s,%d>", yytext,yylineno);}
'[^']*'|\"[^"]*\"        { fprintf(yyout, "<LITERAL,%s,%d>", yytext,yylineno);}



[a-zA-Z]+[a-zA-Z0-9_]* { fprintf(yyout, "<IDENTIFIER,%s,%d>", yytext,yylineno);}
";"      { fprintf(yyout, "<EOS,%s,%d>", yytext,yylineno);}
.        { /* ignore other characters */ }
%%

int main(int argc, char*argv[])
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }
    FILE *input_file;
    input_file = fopen(argv[1], "r");
    if (!input_file) {
        fprintf(stderr, "Error opening input file %s\n", argv[1]);
        return 1;
    }
    FILE *output_file;
    output_file = fopen("scanner_output.txt", "w");
    if (!output_file) {
        fprintf(stderr, "Error opening output file %s\n", argv[1]);
        return 1;
    }
    yyin = input_file;
    yyout = output_file;
    yylex();
    fclose(input_file);
    fclose(output_file);
    return 0;
}