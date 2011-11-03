%{
#include <stdio.h>
#include <stdlib.h>
#include "def.h"

struct Tnode* TreeCreate_(int TYPE, int NODETYPE, int VALUE, char* NAME, struct Tnode *Ptr1, struct Tnode *Ptr2, struct Tnode *Ptr3) {
	struct Tnode* temp=malloc(sizeof(struct Tnode));
	temp->TYPE		=	TYPE;
	temp->NODETYPE	=	NODETYPE;
	temp->VALUE		=	VALUE;
	temp->Ptr1		=	Ptr1; // unk
	temp->Ptr2		=	Ptr2; // left
	temp->Ptr2		=	Ptr3; // right
	return temp;
}

int ch;
Gsymbol *gList=NULL, *gt = NULL;
Lsymbol *llist=NULL, *lt = NULL;

void prefix(struct Tnode*);
void postfix(struct Tnode*);
Gsymbol *Glookup(char*);
Lsymbol *Llookup(char*);
void Ginsert(char*, int, int);
void Linsert(char*, int);

%}

%union {
	struct Tnode *n;
}

%token LP RP SC CM INTEGER BOOLEAN DECL ENDDECL BEG END MAIN
%token READ WRITE VAR EQ
%token OP1 OP2 OP3 OP4
%left OP1 OP2 //'+' '-'
%left OP3 OP4 //'*' '/'
%right EQ


%type <n> VAR sList stmt READ WRITE expr EQ OP1 OP2 OP3 OP4 INTEGER


%%

program:		GdeclBlock MainBlock;

GdeclBlock:		DECL GdeclList ENDDECL;

GdeclList:		GdeclList Gdecl | Gdecl;

Gdecl:		Type GvarList SC;

GvarList:		GvarList CM Gvar | Gvar;

Gvar:		VAR {
				Ginsert($1 - > NAME, $1 - > TYPE, 1);
			}
			| VAR '[' INTEGER ']' {
				Ginsert($1 - > NAME, $1 - > TYPE, $3 - > VALUE);
			};

MainBlock:		INTEGER MAIN LP RP LdeclBlock sBlock | INTEGER MAIN LP RP sBlock;

LdeclBlock:		DECL LdeclList ENDDECL;

LdeclList:		LdeclList Ldecl | Ldecl;

Ldecl:			Type LvarList SC;

LvarList:		LvarList CM VAR {
					Linsert($3 - > NAME, $3 - > TYPE);
				}
				| VAR {
					Linsert($1 - > NAME, $1 - > TYPE);
				};

Type:		INTEGER | BOOLEAN;

sBlock:		BEG sList END {
	eval($2);
};

sList:		sList stmt SC {
				$$ = TreeCreate_(3, 0, 0, NULL, $1, $2, NULL); /* Fix this */
			}
			| stmt SC {
				$$ = TreeCreate_(3, 0, 0, NULL, NULL, $1, NULL);
			};

stmt:		READ LP VAR RP {
				$1 - > Ptr1 = $3;
				$$ = $1;
			}
			| READ LP VAR '[' INTEGER ']' RP {
				$1 - > Ptr1 = $3;
				$3 - > Ptr1 = $5;
				$$ = $1;
			}
			| WRITE LP expr RP {
				$1 - > Ptr1 = $3;
				$$ = $1;
			}
			| VAR EQ expr {
				$2 - > Ptr1 = $1;
				$2 - > Ptr2 = $3;
				$$ = $2;
			}
			| VAR '[' INTEGER ']' EQ expr {
				$5 - > Ptr1 = $1;
				$5 - > Ptr2 = $6;
				$1 - > Ptr1 = $3;
				$$ = $5;
			};

expr:		expr OP4 expr {
				$$ = $2;
				$$ - > Ptr2 = $1;
				$$ - > Ptr3 = $3;
			}
			| expr OP3 expr {
				$$ = $2;
				$$ - > Ptr2 = $1;
				$$ - > Ptr3 = $3;
			}
			| expr OP2 expr {
				$$ = $2;
				$$ - > Ptr2 = $1;
				$$ - > Ptr3 = $3;
			}
			| expr OP1 expr {
				$$ = $2;
				$$ - > Ptr2 = $1;
				$$ - > Ptr3 = $3;
			}
			| LP expr RP {
				$$ = $2;
			}
			| INTEGER {
				$$ = $1;
			};
%%

int main (void) {
	printf("Enter the Calculation :");
	return yyparse();
}

void prefix(struct Tnode* root) {
	if(root==NULL) {
		return;
	} else {
		switch(root->NODETYPE ) {
			case 0 :	printf("%d",root->VALUE);break;
			case 1 :	printf("%c",'+'); break;
			case 2 :	printf("%c",'-'); break;
			case 3 :	printf("%c",'*'); break;
			case 4 :	printf("%c",'/'); break;
		}
		prefix(root->Ptr2);
		prefix(root->Ptr3);
	}
}

void postfix(struct Tnode* root) {
	if(root==NULL) {
		return;
	} else {
		postfix(root->Ptr2);
		postfix(root->Ptr3);
		switch(root->NODETYPE ) {
			case 0 :	printf("%d",root->VALUE); break;
			case 1 :	printf("%c",'+'); break;
			case 2 :	printf("%c",'-'); break;
			case 3 :	printf("%c",'*'); break;
			case 4 :	printf("%c",'/'); break;
		}
	}
}

int	eval(struct Tnode* root) {
	if (root == NULL ) {
		printf("\nTree root is NULL");
		return;
	} else {
		if(root->TYPE==0	&&	root->NODETYPE==0)	/* if INTEGER/variable */ {
			if(root->NAME)	{
				lt = Llookup(root->NAME);
				gt = Glookup(root->NAME);
				if(lt)	{
					return	*(lt->BINDING);
				}
				if(gt)	{
					if(root->Ptr1)	{//if there is an array index
						return	*(gt->BINDING+sizeof(int)*root->Ptr1->VALUE);
					}
					else {
						return	*(gt->BINDING);
					}
				} else	{
					printf("Wrong identifier '%s' used\n", root->NAME);
					exit(0);
				}
			} else
				return	root->VALUE;
		}

		switch(root->NODETYPE)	{
			case 0 :	return(root->VALUE); break;
			case 1 :	return (eval(root->Ptr2) + eval(root->Ptr3)); break;
			case 2 :	return (eval(root->Ptr2) - eval(root->Ptr3)); break;
			case 3 :	return (eval(root->Ptr2) * eval(root->Ptr3)); break;
			case 4 :	return (eval(root->Ptr2) / eval(root->Ptr3)); break;
		}
	}
}


Gsymbol *Glookup(char *NAME) {			// Look up for a global identifier
	Gsymbol *temp = gList;
	do {
		if(strcmp(temp->NAME, NAME)==0) {
			return temp;
		}
	} while(temp = temp->NEXT);
	return NULL;
}

void Ginsert(char *NAME, int TYPE, int SIZE) {	// Installation
	Gsymbol *temp;
	temp = (Gsymbol *)malloc(sizeof(Gsymbol));
	temp->NAME = NAME;
	temp->TYPE = TYPE;
	temp->BINDING = malloc(sizeof(int)*SIZE);
	temp->NEXT = gList;
	gList = temp;
}

Lsymbol *Llookup(char *NAME)	{	// Look up for a local identifier
	Lsymbol *temp = llist;
	do	{
		if(strcmp(temp->NAME,	NAME)==0) {
			return	temp;
		}
	} while(temp = temp->NEXT);
	return	NULL;
}

void Linsert(char *NAME, int TYPE) { // Installation
	Lsymbol *temp = (Lsymbol *)malloc(sizeof(Lsymbol));
	temp->NAME = NAME;
	temp->TYPE = TYPE;
	temp->BINDING = malloc(sizeof(int));
	temp->NEXT = llist;
	llist = temp;
}


int yyerror (char *msg) {
	return fprintf (stderr, "YACC:	%s\n", msg);
}

