
%{
#include "ast.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

[a-zA-Z][a-zA-Z0-9]* {
    yylval.str = strdup(yytext);
    return ID;
}

[-+*/()] {
    return yytext[0];
}

\n {
    return 0;
}

[ \t]+ ;

. {
    return yytext[0];
}

%%

int yywrap(void)
{
    return 1;
}

