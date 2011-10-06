%{

#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include "def.h"

struct Tnode* TreeCreate(int TYPE, int NODETYPE, int VALUE, char* NAME, struct Tnode *left, struct Tnode *right) {
	struct Tnode* temp=malloc(sizeof(struct Tnode));

	temp->TYPE		=	TYPE;
	temp->NODETYPE	=	NODETYPE;
	temp->VALUE		=	VALUE;
	temp->left		=	left;
	temp->right		=	right;

	return temp;
}


int yywrap(void) {
	return 1;
}


%}


%%
[0-9]+	{	yylval.n =	TreeCreate(1, 0, atoi(yytext), NULL, NULL,NULL);
			return NUM;
		}

[+]		{	yylval.n = TreeCreate(1, 1,555, NULL, NULL,NULL);
			return OP1;}

[-]		{	yylval.n = TreeCreate(1, 2,555, NULL, NULL,NULL);
			return OP2;}

[*]		{	yylval.n = TreeCreate(1, 3,555, NULL, NULL,NULL);
			return OP3;}

[/]		{	yylval.n = TreeCreate(1, 4,555, NULL, NULL,NULL);
			return OP4;}

[\n()]		{	return *yytext;}
.	{}
%%

