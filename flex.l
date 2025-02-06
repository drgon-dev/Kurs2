%{
#include <stdlib.h>
#include <string.h>
#include "file_b.h"
%}
digit [0-9]
letter [A-Z]
func [a-z]
%%
">"|"<"|">="|"<="|"=="  { strcpy(yylval.var, yytext); return(OP); }
function { return(FUNCTION); }
int { return(INT); }
plus { return(PLUS); }
minus { return(MINUS); }
if { return(IF); }
back { return(BACK); }
spam { return(SPAM); }
turnoff { return(TURNOFF); }
for { return(FOR); }
start { return (START); }

{letter}+ { strcpy( yylval.var, yytext ) ; return( VAR ); }
{digit}+ { sscanf( yytext, "%d", &yylval.val ) ; return( VAL ); }
{func}+ { strcpy( yylval.var, yytext ) ; return( FUN ); }

[ \n] {}
. {}
%%
