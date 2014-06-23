%option noyywrap
%{
#include "minipseud.h"
#include <stdlib.h>
#include "minipseudtree.h"

int lineNumber;
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


"="		{yylval.node = createNode(NTEGAL); return(NTEGAL);}
"("		{ return(OP_PAR); }
")"		{ return(CL_PAR); }
"+"		{ yylval.node = createNode(NTPLUS); return(NTPLUS);}
"-"		{ yylval.node = createNode(NTMIN); return(NTMIN);}
"*"		{ yylval.node = createNode(NTMULT); return(NTMULT);}
"/"		{ yylval.node = createNode(NTDIV); return(NTDIV);}
"^"		{ yylval.node = createNode(NTPOW); return(NTPOW);}
";"		{ return(COLON);}
"\n"	{ lineNumber++; return(EOL);}
