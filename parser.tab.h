
/* A Bison parser, made by GNU Bison 2.4.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     B_ID = 258,
     B_INTNUM = 259,
     B_REALNUM = 260,
     B_PROGRAM = 261,
     B_BEGIN = 262,
     B_END = 263,
     B_REPEAT = 264,
     B_UNTIL = 265,
     B_NOT = 266,
     B_ASSIGN = 267,
     B_JW = 268,
     B_JM = 269,
     B_WR = 270,
     B_MR = 271,
     B_WHILE = 272,
     B_DO = 273,
     B_DIV = 274,
     B_MOD = 275,
     B_FUNCTION = 276,
     B_PROCEDURE = 277,
     B_VAR = 278,
     B_INTEGER = 279,
     B_REAL = 280,
     B_ARRAY = 281,
     B_OF = 282,
     B_IF = 283,
     B_THEN = 284,
     B_ELSE = 285,
     B_AND = 286,
     B_OR = 287,
     B_NR = 288,
     B_RW = 289,
     B_DOTS = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 24 "parser.y"

  int intval;
  double realval;
  char * stringval;



/* Line 1676 of yacc.c  */
#line 95 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


