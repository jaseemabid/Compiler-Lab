/* Simple calculator v1.2 */

%{
	#include "y.tab.h"
	void yyerror(char *);
%}

%%

[\t ]+ ;

[0-9]+		{
				yylval = atoi(yytext);
				return INTEGER;
			}

[-+*\/\(\)\n]	{
				return (int) yytext[0];
				}

. { yyerror("Unknown input"); }

%%

int yywrap(void) {
	return 1;
}

