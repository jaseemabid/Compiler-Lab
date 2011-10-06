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
			return OP1;
		}

[-]		{	yylval.n = TreeCreate(1, 2,555, NULL, NULL,NULL);
			return OP2;
		}

[*]		{	yylval.n = TreeCreate(1, 3,555, NULL, NULL,NULL);
			return OP3;
		}

[/]		{	yylval.n = TreeCreate(1, 4,555, NULL, NULL,NULL);
			return OP4;
		}

"read"			{	yylval.node = TreeCreate(3, 'r', 555, NULL,NULL, NULL);
					return READ;
				}

"write"			{	yylval.node = TreeCreate(3, 'w', 555, NULL,NULL, NULL);
					return WRITE;
				}

"decl"			{	return DECL;}

"enddecl"		{	return ENDDECL;}

"integer"		{	return INTEGER;}

"boolean"		{	return BOOLEAN;}

"main"			{	return MAIN;}

"begin"			{	return BEG;}

"end"			{	return END;}

=				{
					yylval.node = TreeCreate(3, '=', 555,NULL, NULL, NULL);
					return EQ;
				}

[a-zA-Z][a-zA-Z0-9]*	{
					char *s = malloc(yyleng);
					strcpy(s, yytext);
					yylval.node = TreeCreate(3, 0, 555, s,NULL, NULL);
					return VAR;
				}

"["			{
				return *yytext;
			}

"]"			{
				return *yytext;
			}

\(			{
				return LP; 
			}

\)			{
				return RP;
			}

\;			{
				return SC;
			}

,			{
				return CM;
			}

[\n]		{
				return *yytext;
			}

.		{
			yyerror("Invalid character"); exit(0); 
		}

%%
