%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token ID

%left '+'
%left '*'

%%

input
: expr '\n'
{
printf("Valid Expression\n");
}
;

expr
: expr '+' term
{
printf("Create + Node\n");
}
| term
;

term
: term '*' factor
{
printf("Create * Node\n");
}
| factor
;

factor
: ID
{
printf("Create ID Node\n");
}
| '(' expr ')'
;

%%

int main()
{
printf("Enter Expression: ");
yyparse();
return 0;
}

void yyerror(const char *s)
{
printf("Invalid Expression\n");
}
