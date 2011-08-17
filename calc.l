/* Simple calculator v1.0 */

%{
	#include "y.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
	void yyerror(char *);
%}

%%

[0-9]+		{
				yylval = atoi(yytext);
				return INTEGER;
			}

[-+*/\n]	{
				return *yytext;
			}

[' \t']		;

[^()\t]	{
				yyerror("Unknown character");
			}

%%

int yywrap(void) {
	return 1;
}

