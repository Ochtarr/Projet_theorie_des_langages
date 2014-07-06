%option noyywrap
%{

#include "minipseud.h"
#include <stdlib.h>
#include "minipseudtree.h"

%}

empty    [ \t]+

num   [0-9]
int    {num}+
exp  [eE][+-]?{int}

real    {int}("."{int})?{exp}?
lettre  [a-z]
affiche ["affiche"]


%%

{empty}  { /* Nothing */ }


"("   return(OP_PAR);
")"   return(CL_PAR);


{real}    {
    yylval.node = createNode(NTNUM);
    yylval.node->val = atof(yytext);
    return(NUM);
    }

{lettre}    {
	yylval.node = createNode(NTVAR);
	yylval.node->var = (char*)_strdup(yytext);
	return(VARIABLE);
    }

	
"+"   { yylval.node = createNode(NTPLUS); return(PLUS); }
"-"   { yylval.node = createNode(NTMIN); return(MIN); }
"*"   { yylval.node = createNode(NTMULT); return(MULT); }
"/"   { yylval.node = createNode(NTDIV); return(DIV); }
"^"   { yylval.node = createNode(NTPOW); return(POW); } 
"="   { yylval.node = createNode(NTEGAL); return(EGAL); }
affiche { yylval.node = createNode(NTAFFICHE); return(AFFICHE); }

";"    { return(COLON); }

"\n"   { return(EOL); }
