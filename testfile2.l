/*this tells flex to read only one input file*/
%option noyywrap 

/* Definition section */
%{

/* Header in the C standard library */
#include <stdio.h>  
#include <string.h>

#define YY_DECL int yylex()

int words = 0;
int chars = 0;
int lines = 0;

%}

letter      [a-zA-Z]
digit       [0-9]
ID          {letter}({letter}|{digit})*
delim       [ \t\n]
NUMBER         {digit}+(\.{digit}+)?(E[+\-]?(digit)+)?
ws          {delim}+ 

/*rules*/
%%
"/*"    				{
							int c;
							while((c = input()) != 0) {
								if(c == '*') {
									if((c = input()) == '/')
										break;
									else
										unput(c);
								}
							}
						}
						
"int"   {words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}

"char"  {words++; chars += strlen(yytext);  //increase the number of words and chars(the length of words) by getting an input
		 printf("%s : TYPE\n", yytext);
        }   //token for "char" which is a type

"write" {words++; chars += strlen(yytext);  //Have to write those rules for KEYWORDs first than ID identifier rule and increase the number of words and chars(the length of words) by getting an input
         printf("%s : KEYWORD\n", yytext);
        }   //token for "write" which is a keyword

"return"    {words++; chars += strlen(yytext);  //Have to write those rules for KEYWORDs first than ID identifier rule and increase the number of words and chars(the length of words) by getting an input
             printf("%s : KEYWORD\n", yytext);
            }   //token for "return" which is a keyword

";" {words++; chars += strlen(yytext);
     printf("%s : SEMICOLON\n", yytext);
    }   //token for ";" which is a operator

"=" {words++; chars += strlen(yytext);
     printf("%s : EQUAL\n", yytext);
    }   //token for "=" which is a operator

"," {words++; chars += strlen(yytext);
     printf("%s : COMMA\n", yytext);
    }   //token for "," which is a operator


{ID}	{words++; chars += strlen(yytext);
		 printf("%s : IDENTIFIER\n",yytext);
		}  
		
{NUMBER}    {words++; chars += strlen(yytext);
             printf("%s : NUMBER\n", yytext);
            }   //token for "NUMBER" which is a identifier

\n  {lines++; chars = 0;}  //find new lines

[ \t] {chars++;}

.   {
     printf("Please enter valid input\n");
    }   //Generates lexical errors when there are errors in the code with a simple print statement

%%

int main(int argc, char**argv)
{
    /* debugging statement */
	#ifdef YYDEBUG
		yydebug = 1;
	#endif

	printf("Compiler started. \n\n");
   
	if (argc > 1){  //check that there is at least two arguments
	  if(!(yyin = fopen(argv[1], "r"))) //if it fails to open file 
          {
		perror(argv[1]);    //the 'fopen' returns Null
		return(1);
	  }
	}
    /*call the lexer, then quit*/
	yylex(); 
}