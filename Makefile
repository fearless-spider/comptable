OBJ = lexer.o parser.o
FLEX = lexer.c lexer.h
BISON = parser.tab.c parser.tab.h
FLAGS = -Wall
OUTPUT = parser

result : $(OBJ)
	g++ -o $(OUTPUT) $(OBJ) -lfl $(FLAGS) 
lexer.c lexer.h : lexer.l
	flex -o lexer.c --header-file=lexer.h lexer.l
parser.tab.c parser.tab.h : parser.y tableOfSymbols.h tableOfSymbols.cpp
	bison -d parser.y
lexer.o : parser.tab.h lexer.c
	g++ -c -o lexer.o lexer.c $(FLAGS) 
parser.o : lexer.h parser.tab.c
	g++ -c -o parser.o parser.tab.c $(FLAGS) 
clean :
	rm -f tableOfSymbols.o
	rm -f lexer.o
	rm -f parser.o
	rm -f parser.tab.c
	rm -f lexer.c
	rm -f parser.tab.h
	rm -f lexer.h
	rm -f tableOfSymbols

