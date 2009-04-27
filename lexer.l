%{
  #include "parser.tab.h";
  int lineno = 1;
  extern int yyerror(char *);
%}
delim [ \t]
delimplus	[\n] 
ws {delim}+ 
newline	{delimplus}
letter [A-Za-z] 
digit [0-9] 
integer {digit}+
id {letter}({letter}|{digit})* 
real {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?
%option nounput
%%
program		{return B_PROGRAM;}
begin		{return B_BEGIN;}
end		{return B_END;}
function 	{return B_FUNCTION;}
procedure 	{return B_PROCEDURE;}
var		{return B_VAR;}
integer 	{return B_INTEGER;}
real		{return B_REAL;}
array		{return B_ARRAY;}
of		{return B_OF;}
if		{return B_IF;}
then		{return B_THEN;}
else		{return B_ELSE;}
repeat		{return B_REPEAT;}
until		{return B_UNTIL;}
while		{return B_WHILE;}
do		{return B_DO;}
div		{return B_DIV;}
mod		{return B_MOD;}
and		{return B_AND;}
or		{return B_OR;}
not		{return B_NOT;}
":="		{return B_ASSIGN;}
"="		{return B_RW;}
"<>"		{return B_NR;}
">="		{return B_WR;}
">"		{return B_JW;}
"<="		{return B_MR;}
"<"		{return B_JM;}
".."		{return B_DOTS;}
{integer}	{yylval.intval = atoi(yytext); return B_INTNUM;}
{real}		{yylval.realval = (float)atof(yytext); return B_REALNUM;}
{id}		{yylval.stringval = strdup(yytext); return B_ID;}
{newline}	{lineno++;}
{ws}		{/* no action and no return */}
"-"|"*"|"/"|":"|";"|","|"."|"("|")"|"["|"]"|"+" {return *yytext;}
.		{return 0;}
%%
int yyerror(char * s) {
  printf("%i : %s \n", lineno, s);
  return 0;
}
    