%option noyywrap
%{
#include "minipseud.h"
#include <stdlib.h>
#include "minipseudtree.h"
%}

empty    [ \t]+
num  [0-9]
int  {num}+
exp  [eE][+-]?{int}
real {int}("."{int})?{exp}?
booleanFaux {"0"|"False"}{1}
booleanVrai {"1"|"True"}{1}
boolean = {booleanVrai|booleanFaux}{1}
lettre [a-zA-Z]
variable {lettre}(_|{lettre}|{num})*
%%

{empty}  { }
{real}   {
    yylval.node = createNode(NTNUM);
    yylval.node->val = atof(yytext);
    return(NUM);
}
{variable}	{
	yylval.node = createNode(NTVAR);
	yylval.node->val = atof(yytext);
	return(NTVAR);
}
":="  
"("		return(OP_PAR);
")"		return(CL_PAR);
"AFFICHE"	{yylval.node = createNode(NTAFFICHE); return(NTAFFICHE);}
"SI"	{yylval.node = createNode(NTSI); return(NTSI);}
"ALORS"	{yylval.node =  createNode(NTALORS); return(NTALORS);}
"SINON" {yylval.node = createNode(NTSINON); return(NTSINON);}
"+"		{ yylval.node = createNode(NTPLUS); return(NTPLUS); }
"-"		{ yylval.node = createNode(NTMIN); return(NTMIN); }
"*"		{ yylval.node = createNode(NTMULT); return(NTMULT); }
"/"		{ yylval.node = createNode(NTDIV); return(NTDIV); }
"^"		{ yylval.node = createNode(NTPOW); return(NTPOW); }
";"		{ return(COLON); }
"\n"	{ return(EOL); }
