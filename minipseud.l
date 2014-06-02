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

{empty}  { /* Nothing */ }

"("   return(OP_PAR);
")"   return(CL_PAR);

{real}    {
    yylval.node = createNode(NTNUM);
    yylval.node->val = atof(yytext);
    return(NUM);
    }

{variable}	{
	yyval.node = createNode(NTVAR);
	yyval.node->val = yytext;
	return(NTVAR);
}

"AFFICHE"	{yylval.node = createNode(NTAFFICHE); retuen(AFFICHE)}
"SI"		{yylval.node = createNode(NTSI); return(SI)}
"ALORS"		{yylval.node =  createNode(NTALORS); return(ALORS)}
"SINON"		{yylval.node = createNode(NTSINON); return(SINON)}


"+"   { yylval.node = createNode(NTPLUS); return(PLUS); }
"-"   { yylval.node = createNode(NTMIN); return(MIN); }
"*"   { yylval.node = createNode(NTMULT); return(MULT); }
"/"   { yylval.node = createNode(NTDIV); return(DIV); }
"^"   { yylval.node = createNode(NTPOW); return(POW); }

";"    { return(COLON); }
"\n"   { return(EOL); }


