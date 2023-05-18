%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* msg);
int yylex(void);
extern FILE* yyin;
%}

%start sql_file
%token SELECT INSERT UPDATE DELETE FROM WHERE INTO VALUES SET CREATE TABLE INT FLOAT STRING BOOLEAN ALTER ADD DROP RENAME MODIFY TO IF EXISTS
%token EQ GT LT 
%token IDENTIFIER LITERAL ASTERISK SEMICOLON

%%

sql_file:
  /* empty */
  |sql_file query
  ;


query: select_query
     | delete_query
     | insert_query
     | update_query
     | create_query
     | alter_query
     | drop_query
     ;


select_query: SELECT select_list FROM IDENTIFIER where_clause SEMICOLON {printf("select statement parsed\n");}
            ;


select_list: ASTERISK 
           | column_list
           ;

column_list: IDENTIFIER
           | IDENTIFIER ',' column_list
           ;

where_clause: WHERE condition 
            | /* empty */
            ;

condition: IDENTIFIER operator LITERAL
         ;


operator: EQ | GT | LT
        ;


delete_query: DELETE FROM IDENTIFIER where_clause SEMICOLON {printf("delete statement parsed\n");}
            ;

insert_query: INSERT INTO IDENTIFIER '(' column_list ')' VALUES '(' value_list ')' SEMICOLON {printf("insert statement parsed\n");}
              |INSERT INTO IDENTIFIER '(' value_list ')' SEMICOLON {printf("insert statement parsed\n");}
              ;


value_list: LITERAL 
          | LITERAL ',' value_list 
          ;
        

update_query: UPDATE IDENTIFIER SET set_clause where_clause SEMICOLON {printf("update statement parsed\n");}
            ;

set_clause: assignment 
          | assignment ',' set_clause 
          ;


assignment: IDENTIFIER EQ LITERAL
           ;

create_query:
                  CREATE TABLE IDENTIFIER '(' column_definition_list ')' SEMICOLON {printf("create statement parsed\n");}
                  ;

column_definition_list:
                        column_definition
                        | column_definition ',' column_definition_list
                        ;

column_definition:
                  IDENTIFIER data_type
                  ;

data_type:
          INT
          | FLOAT
          | STRING
          | BOOLEAN
          ;


alter_query:
  ALTER TABLE IDENTIFIER alter_action SEMICOLON {printf("alter statement parsed\n");}
  ;

alter_action:
  ADD '(' column_definition ')'
  | DROP '(' IDENTIFIER ')'
  | MODIFY '(' column_definition ')'
  | RENAME TO IDENTIFIER
  ;

drop_query:
  DROP TABLE if_exists_opt IDENTIFIER SEMICOLON {printf("DROP statement parsed\n");}
  ;

if_exists_opt:
  IF EXISTS
  | /* empty */
  ;

%%

int main(int argc, char *argv[]) {
  if (argc ==2)
  {
    yyin = fopen(argv [1], "r");
  }
  yyparse();
  return 0;
}

void yyerror(const char* msg) {
  fprintf(stderr, "Parser error: %s\n", msg);
  exit(1);
}