%{ 
	/*  New Lexer build October 27, 2022 - add definitions ..*/

%}

%union {
    int num;
    char sym;
}

%token EOL
%token<num> NUMBER
%type<num> exp
%token MULTIPLY DIVIDE ADDITION SUBTRACTION POWEROF

   /*  rules go below */ 
%%
input:
|    line input
;

line: 
    exp EOL {printf("%d\n", $1);}
|    EOL;

exp: 
    NUMBER {$$ = $1;}
|    exp MULTIPLY exp {$$ = $1 * $3;}
|    exp DIVIDE exp {$$ = $1 / $3;}
|    exp ADDITION exp {$$ = $1 + $3;}
|    exp SUBTRACTION exp {$$ = $1 - $3;}
|    exp POWEROF exp {$$ = $1 ** $3;}
;


%%

int main() 
{
	yyparse();

	return 0;
}
yyerror(char* s)
{
    printf("ERROR: %d\n", s);
    return 0;
}