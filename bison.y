%{
#include <stdio.h>
%}

%union {
int val;
char var[2048];
char func[2048];
char op[1];
}

%token <val> VAL
%token <var> VAR
%token <op> OP
%token <func> FUN
%token INT SPAM MINUS PLUS BACK IF FOR TURNOFF FUNCTION START
%type <var> str
%type <var> oper

%%
prog: str {printf ("#include <stdio.h>\n\n%s", $1);}

str: oper {
sprintf($$, "%s", $1);
}
| oper str {
sprintf($$, "%s\n%s", $1, $2);
};

oper: INT VAR {
sprintf($$, "int %s;", $<var>2);
}
| INT VAR VAL {
sprintf($$, "int %s=%d;", $<var>2, $<val>3);
}
| SPAM VAR {
sprintf($$, "printf(\"%s\\n\", %s);", "%d", $<var>2);
}
| FUNCTION FUN str BACK {
sprintf($$, "int %s() {\n%s}", $<func>2, $<var>3);
} 
| TURNOFF VAL {
sprintf($$, "return %d;\n", $<val>2);
}
| START FUN {
sprintf($$, "%s();", $<func>2);
}
| PLUS VAR VAL {
sprintf($$, "%s += %d;", $<var>2, $<val>3);
}
| PLUS VAR VAR {
sprintf($$, "%s += %s;", $<var>2, $<var>3);
}
| MINUS VAR VAL {
sprintf($$, "%s -= %d;", $<var>2, $<val>3);
}
| MINUS VAR VAR {
sprintf($$, "%s -= %s;", $<var>2, $<var>3);
}
| IF VAR OP VAR str BACK {
sprintf($$, "while(%s %s %s) {%s}", $<var>2, $<op>3, $<var>4, $<var>5);
}
| IF VAR OP VAL str BACK {
sprintf($$, "while(%s %s %d) {%s}", $<var>2, $<op>3, $<val>4, $<var>5);
}
| FOR VAR OP VAR str BACK {
sprintf($$, "if(%s %s %s) {%s}", $<var>2, $<op>3, $<var>4, $<var>5);
}
| FOR VAR OP VAL str BACK {
sprintf($$, "if(%s %s %d) {%s}", $<var>2, $<op>3, $<val>4, $<var>5);
}
;
%%
yyerror (s)
char *s;
{
	printf ("err:%s\n", s);
}
main()
{
	yyparse();
}
