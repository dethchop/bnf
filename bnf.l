%{
#include "y.tab.h"
%}
%%
[a-zA-Z][a-zA-Z0-9]* { return ID; }
"+" { return '+'; }
"*" { return '*'; }
"(" { return '('; }
")" { return ')'; }
[ \t] ;
\n { return '\n'; }
. { return yytext[0]; }
%%
int yywrap()
{
return 1;
}
