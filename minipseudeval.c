#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <setjmp.h>
#include "minipseudtree.h"


int printDepth = 0;
int funcDepth = 0;
double sysm[26] = {0.0};

double evalExpr(Node *node) {
	switch ( node->type ) {
	case NTEMPTY:  return 0.0;
	case NTNUM: return node->val;
	case NTVAR: //printf("%c",sysm[node->var[0]-'a']);
			return sysm[node->var[0]-'a'];
	case NTPLUS: return evalExpr(node->children[0])
			+ evalExpr(node->children[1]);
	case NTMIN: return evalExpr(node->children[0])
			- evalExpr(node->children[1]);
	case NTMULT: return evalExpr(node->children[0])
			* evalExpr(node->children[1]);
	case NTDIV: return evalExpr(node->children[0])
			/ evalExpr(node->children[1]);
	case NTPOW: return pow(evalExpr(node->children[0]),
			evalExpr(node->children[1]));
	case NTEGAL: sysm[node->children[0]->var[0] - 'a'] = evalExpr(node->children[1]);
			return sysm[node->children[0]->var[0] - 'a'];
	case NTAFFICHE: printf("Affichage de %f \n",evalExpr(node->children[0]));
			return evalExpr(node->children[0]);
	default: 
		printf("Error in evalExpr ... Wrong node type: %s\n", node2String(node));
		exit(1);
	};
}


void evalInst(Node* node) {
	double val;
	char var;
	switch ( node->type ) {
	case NTEMPTY: return;
	case NTINSTLIST:
		evalInst(node->children[0]);
		evalInst(node->children[1]);
		return; 
	case NTPLUS:
	case NTMIN:
	case NTMULT:
	case NTDIV:
	case NTEGAL:
	case NTAFFICHE:
	case NTVAR:
		printf("%f \n", evalExpr(node));
		printf("%c <- %f \n", node->var[0],evalExpr(node));
		return;
	case NTPOW:
		printf("%f\n", evalExpr(node));
		return;
	 
	default:
		printf("Error in evalInst ... Wrong node type: %s\n", node2String(node));
		exit (1);
	};
}

void eval(Node *node) {
	 
	evalInst(node);
}
