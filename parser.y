%{
#include <iostream>
#include <stdio.h>
#include <string>
#include "tableOfSymbols.cpp"

unsigned int counterID = 1;
int preType = NONE;
unsigned int isReference = nReference;
unsigned int scopeControl = 1;
string tempName = "";
unsigned int returnParameters = NONE;
FILE * outputFile;
FILE * inputFile;
char name[100];

extern FILE * yyin;
extern char * yytext;

int yylex();
int yyerror(char *s);
%}

%union {
  int intval;
  double realval;
  char * stringval;
}

%token <stringval> B_ID
%token <intval> B_INTNUM
%token <realval> B_REALNUM

%token B_PROGRAM
%token B_BEGIN
%token B_END
%token B_REPEAT
%token B_UNTIL
%token B_NOT
%token B_ASSIGN
%token B_JW
%token B_JM
%token B_WR
%token B_MR
%token B_WHILE
%token B_DO
%token B_DIV
%token B_MOD
%token B_FUNCTION
%token B_PROCEDURE
%token B_VAR
%token B_INTEGER
%token B_REAL
%token B_ARRAY
%token B_OF
%token B_IF
%token B_THEN
%token B_ELSE
%token B_AND
%token B_OR
%token B_NR
%token B_RW
%token B_DOTS

%%
program:    	
				B_PROGRAM {tableOfSymbols.init(); printf("start\n");}
                                B_ID {printf("Program find: %s", yylval.stringval);}
                                '(' B_ID ',' {printf(" (%s,", yylval.stringval);}
                                B_ID ')' ';' {printf(" %s)\n\n", yylval.stringval); printf("Declaration: \n");}
                                declare_section {printf("\nFunction: \n");}
                                subprograms
                                code_section {printf("Code section: \n");}
                                '.' {printf("end."); tableOfSymbols.printSymbol();}

;
id_list:			B_ID {tableOfSymbols.addSymbol(yytext); tableOfSymbols.setReference(isReference); printf("Find indetifier: %s \n", yylval.stringval);}
                                | id_list ',' {counterID++;} B_ID {tableOfSymbols.addSymbol(yytext); tableOfSymbols.setReference(isReference); printf("Find idetifier: %s\n", yylval.stringval);}
;                
declare_section:		declare_section B_VAR {printf("keyword VAR\n");} 
                                id_list ':' type ';' {tableOfSymbols.setType(counterID, preType); counterID = 1; preType = 0;}
                                |
;
type:				base_type
			        | B_ARRAY '[' B_INTNUM	{tableOfSymbols.setBeginningTable(counterID, yylval.intval);}
			        B_DOTS B_INTNUM	{tableOfSymbols.setEndTable(counterID, yylval.intval);}
                                ']' B_OF base_type {tableOfSymbols.setType(counterID, preType); preType = tTable;}
;
base_type:			B_INTEGER {preType = tInt; printf("keyword integer\n");}
                                | B_REAL {preType = tReal; printf("keyword real\n");}
;
subprograms:			subprograms sub_declaration ';'
				|
;
sub_declaration:		sub_start declare_section code_section
;
sub_start:			B_FUNCTION {isReference = Reference; printf("keyword function\n");}
                                B_ID {printf("Function %s\n", yylval.stringval);}
                                {tableOfSymbols.addSymbol(yytext);tempName = yytext;tableOfSymbols.setType(counterID, tFunction);tableOfSymbols.setReference(isReference);}
                                arguments ':' base_type
                                {tableOfSymbols.setReturnType(tempName, preType);preType = NONE;}
                                ';'
                                | B_PROCEDURE {isReference = Reference;}
                                B_ID 
                                {tableOfSymbols.addSymbol(yytext);tempName = yytext;tableOfSymbols.setType(counterID, tProcedure);tableOfSymbols.setReference(isReference);}
                                arguments ';'
;
arguments:			'(' param_list ')' { tableOfSymbols.setParameters(tempName, returnParameters); returnParameters=0;tempName="";}
;
param_list:			id_list ':' type
                                {tableOfSymbols.setType(counterID, preType); returnParameters += counterID; counterID = 1; preType = NONE;isReference = nReference;}
                                | param_list ';' id_list ':' type
                                {tableOfSymbols.setType(counterID, preType); returnParameters += counterID; counterID = 1; preType = NONE;isReference = nReference;}
;
code_section:			B_BEGIN code_body B_END
;
code_body:			statements
				| statements ';'
				|
;
statements:			statement
				| statements ';' statement
;
statement:
				variable B_ASSIGN expr
				| procedure_statement
				| code_section
				| B_IF {printf("IF\n");} expr B_THEN {printf("THEN\n");}statement
				| B_WHILE expr B_DO statement
;
variable:			B_ID 
				| B_ID '[' expr ']'
;
procedure_statement: 
				B_ID
				| B_ID '(' expr_list ')'
				;
expr_list:			expr
				| expr_list ',' expr
				|
				;
expr:				simple_expr
				| simple_expr B_JW simple_expr
				| simple_expr B_WR simple_expr
				| simple_expr B_MR simple_expr
				| simple_expr B_NR  simple_expr
				| simple_expr B_RW simple_expr
				| simple_expr B_JM  simple_expr
;
simple_expr:			term
				| sign term
				| simple_expr '+' term
				| simple_expr '-' term
				| simple_expr B_OR term
;
term:				factor
				| term '*' factor
				| term '/' factor
				| term B_DIV factor
				| term B_MOD factor
				| term B_AND factor
;
factor:				variable
				| B_ID '('expr_list')'
				| B_INTNUM
				| B_REALNUM
				| '(' expr ')'
				| B_NOT factor
;
sign:				'-'
				| '+'
;                                                                                                                                                                                                                                                                                                                                                                                                
%%
int main(int argc, char * argv[]) {
  if(argc != 2) {
    printf("\n No input file PAS \n\n");
    return 0;
  }
  
  if((inputFile = fopen(argv[1], "r")) == NULL) {
    printf("\n Error on open file OUTPUT \n\n");
    return 0;
  }
  
  yyin = inputFile;
    
  yyparse();
  fclose(inputFile);
  return 0;
}
