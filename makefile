all :
	yacc -d sym.y
	lex sym.l
	cc y.tab.c lex.yy.c  -o compiler.out
	./compiler.out # Run the compiled code.

