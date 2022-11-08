%{
    /* definitions */
    #include "parser.tab.h" 
%}
    /* rules below */
%%


[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
"*" {return MULTIPLY;}
"/" {return DIVIDE;}
"+" {return ADDITION;}
"-" {return SUBTRACTION;}
"**" {return POWEROF;}
\n {return EOL;}
. {}

%%

yywrap() {}

