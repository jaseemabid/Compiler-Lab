all :
	clear
	yacc -d sil.y
	lex sil.l
	cc y.tab.c lex.yy.c  -o compiler.out
	./compiler.out < test.sil # Run the compiled code.
	echo
	cat sim.S


