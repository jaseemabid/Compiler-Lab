%{
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
#include "sil.h"

void yyerror(char *);

typedef struct Tnode tnode;
typedef struct Lsymbol lsymbol;
typedef struct Gsymbol gsymbol;
tnode *TreeCreate(int ,int ,char *,int ,tnode *, tnode *, tnode *,lsymbol *,gsymbol *) ;

%}
%%

"\n"		{}

"["			{
				return *yytext;
			}

"]"			{
				return *yytext;
			}
"-"			{	yylval.ptr=TreeCreate(INT_TYPE,MINUS_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return *yytext;

			}

[;}{,)(]			{
				return *yytext;
			}

		
[0-9]+			{	
				yylval.ptr = TreeCreate(INT_TYPE,NUMBER_NODETYPE,NULL,atoi(yytext),NULL,NULL,NULL,NULL,NULL);
				return CONST;
			}
				
"read"			{	
				yylval.ptr = TreeCreate(VOID_TYPE,READ_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return READ;
			}
				
"write"			{	
				yylval.ptr = TreeCreate(VOID_TYPE,WRITE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return WRITE;
			}

			
"if"			{	
				yylval.ptr = TreeCreate(VOID_TYPE,IF_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return IF;
			}

"while"			{	
				yylval.ptr = TreeCreate(VOID_TYPE,WHILE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return WHILE;
			}

"return"		{	yylval.ptr = TreeCreate(VOID_TYPE,RETURN_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return RETURN;		
			}

"main"			{	return MAIN;		}

"do"			{	return DO; 		}

"endwhile"		{	return ENDWHILE; 	}
			
"then"			{	return THEN; 		}

"else"			{	return ELSE; 		}

"endif"			{	return ENDIF; 		}

"integer"		{	return INTEGER;		}

"boolean"  		{	return BOOLEAN;		}

"end"			{	return END;		}

"decl"			{	return DECL;		}

"enddecl"		{	return ENDDECL;		}

"begin"			{	return BEGINING;	}

"true"			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,TRUE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return TRUE;
			}

"false"			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,FALSE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return FALSE;
			}

[a-z]+			{	
				char *name =  (char *)malloc(sizeof(yytext));
				strcpy(name,yytext);
				yylval.ptr = TreeCreate(VOID_TYPE,ID_NODETYPE,name,0,NULL,NULL,NULL,NULL,NULL);
				return ID;
			}

"<"			{	yylval.ptr = TreeCreate(BOOLEAN_TYPE,LT_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return LT;
			}

"<="			{	
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,LE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return LE;
			}

">"			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,GT_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return GT;
			}

">="			{	
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,GE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return GE;
			}

"=="			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,EQ_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return EQ;
			}

"!="			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,NE_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return NE;
			}

"&&"			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,AND_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return AND;
			}

"||"			{
				yylval.ptr = TreeCreate(BOOLEAN_TYPE,OR_NODETYPE,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return OR;
			}	

[+%*/=]			{	
				int temp;
				switch(*yytext) {
					case '+' : temp=PLUS_NODETYPE;	break;
					case '*' : temp=MULT_NODETYPE;	break;
					case '/' : temp=DIV_NODETYPE;	break;
					case '=' : temp=ASSIGN_NODETYPE;break;
					case '%' : temp=MODULO_NODETYPE;break;
				}
				yylval.ptr=TreeCreate(INT_TYPE,temp,NULL,0,NULL,NULL,NULL,NULL,NULL);
				return *yytext;
			}

.			{}	

%%

int yywrap(void) {
	return(1);
}

tnode *TreeCreate(int type,int nodetype,char *name,int value,tnode *ptr1, tnode *ptr2, tnode *ptr3,lsymbol *lentry,gsymbol *gentry) {
	tnode *temp=(tnode *)malloc(sizeof(tnode));
	temp->TYPE=type;
	temp->NODETYPE=nodetype;
	temp->NAME=name;
	temp->VALUE=value;
	temp->Ptr1=ptr1;
	temp->Ptr2=ptr2;
	temp->Ptr3=ptr3;
	temp->Lentry=lentry;
	temp->Gentry=gentry;
	return(temp);
 }
