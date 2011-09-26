%{
#include<stdio.h>
#include<stdlib.h>

int ch;

struct Tnode
{
	int TYPE;
	int NODETYPE;
	int VALUE;
	struct Tnode *left,*right;
};

void prefix(struct Tnode*);
void postfix(struct Tnode*);
%}

%union
{
	struct Tnode *n;
}

%token NUM OP1 OP2 OP3 OP4
%type<n> start expr OP1 OP2 OP3 OP4 NUM
%left OP1 OP2//'+' '-'
%left OP3 OP4 //'*' '/'
%left '('

%%

start: expr'\n'		{
					printf("\n1.Prefix expression\t2.Postfix expression.\t3. Eval Enter (1/2/3) : ");
					scanf("%d",&ch);
					switch(ch) {
						case 1:printf("\nPrefix expression : \t");prefix($1); printf("\n\n"); break;
						case 2:printf("\nPostfix expression : \t");postfix($1); printf("\n\n"); break;
						case 3:printf("\nEval expression : %d\t",eval($1)); printf("\n\n"); break;
					}
					return(0);
				};

expr: expr OP4 expr		{
					$$=$2;
					$$->left=$1;
					$$->right=$3;
				}
	|expr OP3 expr		{
					$$=$2;
					$$->left=$1;
					$$->right=$3;
				}
	|expr OP2 expr		{
					$$=$2;
					$$->left=$1;
					$$->right=$3;
				}
	|expr OP1 expr		{
					$$=$2;
					$$->left=$1;
					$$->right=$3;
				}
	|'('expr')'		{	$$=$2; }
	|NUM			{	$$=$1; }
	;
%%

int main (void)
{
	printf("Enter the Calculation :");
	return yyparse();
}

void prefix(struct Tnode* root)
{
	if(root==NULL) {
		return;
	} else {
		switch(root->NODETYPE ) {
			case 0 :
				printf("%d",root->VALUE);
				break;
			case 1 :
				printf("%c",'+');
				break;
			case 2 :
				printf("%c",'-');
				break;
			case 3 :
				printf("%c",'*');
				break;
			case 4 :
				printf("%c",'/');
				break;
		}
		prefix(root->left);
		prefix(root->right);
	}
}


void postfix(struct Tnode* root)
{
	if(root==NULL) {
		return;
	} else {
		postfix(root->left);
		postfix(root->right);
		switch(root->NODETYPE ) {
			case 0 :
				printf("%d",root->VALUE);
				break;
			case 1 :
				printf("%c",'+');
				break;
			case 2 :
				printf("%c",'-');
				break;
			case 3 :
				printf("%c",'*');
				break;
			case 4 :
				printf("%c",'/');
				break;
		}
	}
}

int eval(struct Tnode* root)
{
	if(root==NULL) {
		return;
	} else {
		switch(root->NODETYPE ) {
			case 0 :
				return(root->VALUE);
				break;
			case 1 :
				return (eval(root->left) + eval(root->right));
				break;
			case 2 :
				return (eval(root->left) - eval(root->right));
				break;
			case 3 :
				return (eval(root->left) * eval(root->right));
				break;
			case 4 :
				return (eval(root->left) / eval(root->right));
				break;
		}
		
		
	}
}

int yyerror (char *msg)
{
	return fprintf (stderr, "YACC: %s\n", msg);
}

