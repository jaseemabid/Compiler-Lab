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


struct Tnode* NodeCreate(int TYPE, int NODETYPE, int VALUE) {
	/*
		This function to be used while matching variables and operators
	*/
	struct Tnode* temp = TreeCreate(TYPE, NODETYPE, VALUE, NULL, NULL,NULL);
	return temp;
}




int yywrap(void) {
	return 1;
}


%}



%%
[0-9]+	{	yylval.n =	NodeCreate(1, 0, atoi(yytext));
			return NUM;
		}

[+]		{	yylval.n = NodeCreate(1, 1,555);
			return OP1;}

[-]		{	yylval.n = NodeCreate(1, 2,555);
			return OP2;}

[*]		{	yylval.n = NodeCreate(1, 3,555);
			return OP3;}

[/]		{	yylval.n = NodeCreate(1, 4,555);
			return OP4;}

[\n()]		{	return *yytext;}
.	{}
%%

