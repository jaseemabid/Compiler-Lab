/* Simple calculator v1.2 */

%{
	#include <stdlib.h>
	#include <stdio.h>
	int yylex(void);
	void yyerror(char *);
%}

%token INTEGER

%left '+' '-'
%left '*' '/'

%%

program:
		program expr '\n' { printf("%d\n", $2); }
		|
		;
expr:
		INTEGER
		| expr '+' expr { $$ = $1 + $3; }
		| expr '-' expr { $$ = $1 - $3; }
		| expr '*' expr { $$ = $1 * $3; }
		| expr '/' expr { $$ = $1 / $3; }
		| '(' expr ')' { $$ = $2; }
		| '-' expr { $$ = -1 * $2; }
		;

%%

void yyerror( char *s) {
	printf("\t%s\n" , s);
}

int main () {
	return yyparse();
	return 0;
}

