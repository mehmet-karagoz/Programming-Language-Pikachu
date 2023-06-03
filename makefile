pikachu: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o pikachu

lex.yy.c: y.tab.c pikachu.l
	lex pikachu.l

y.tab.c: pikachu.y
	yacc -d pikachu.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h pikachu pikachu.dSYM

