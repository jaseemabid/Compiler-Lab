%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char *);
%}

%token INTEGER

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

program:
		program expr '\n' { printf("%d\n", $2); }
		|
		;
expr:
		INTEGER { $$ = $1; }
		| '(' expr ')' { $$ = $2; }
		| expr '+' expr { $$ = $1 + $3; }
		| expr '-' expr { $$ = $1 - $3; }
		| expr '*' expr { $$ = $1 * $3; }
		| expr '/' expr { $$ = $1 / $3; }
		;

%%

void yyerror( char *s) {
	printf("\t%s\n" , s);
}

int main () {
	return yyparse();
	return 1;
}

