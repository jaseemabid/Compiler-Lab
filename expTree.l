%{
#include "y.tab.h"
#include<stdio.h>
#include<stdlib.h>

struct Tnode
{
	int TYPE;
	int NODETYPE;
	int VALUE;
	struct node *left,*right;
};

struct Tnode* treecreate(int nodetype1,int value1)
{
	struct Tnode* temp=malloc(sizeof(struct Tnode));
	if(nodetype1==0)
	{
		temp->TYPE=1;
		temp->NODETYPE=nodetype1;
		temp->VALUE=value1;
		temp->left=NULL;
		temp->right=NULL;

	}
	else if(nodetype1==1||nodetype1==2||nodetype1==3||nodetype1==4)
	{
		temp->TYPE=1;
		temp->NODETYPE=nodetype1;
		temp->left=NULL;
		temp->right=NULL;
	}
	return temp;
}


int yywrap(void) {
	return 1;
}


%}



%%
[0-9]+	{	yylval.n=treecreate(0,atoi(yytext));
			return NUM;
		}

[+]		{	yylval.n=treecreate(1,0);
			return OP1;}

[-]		{	yylval.n=treecreate(2,0);
			return OP2;}

[*]		{	yylval.n=treecreate(3,0);
			return OP3;}

[/]		{	yylval.n=treecreate(4,0);
			return OP4;}

[\n()]		{	return *yytext;}
.	{}
%%

