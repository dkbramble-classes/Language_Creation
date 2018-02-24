%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <string.h>
%}

%option noyywrap

%%

[0-9]+					{ yylval.d = atoi(yytext); return INT; }
[0-9]+\.[0-9]+			{ yylval.i = atoi(yytext); return FLOAT; }
(point)				    { yylval.str = strdup(yytext); return POINT; }
(line)					{ yylval.str = strdup(yytext); return LINE; }
(circle)				{ yylval.str = strdup(yytext); return CIRCLE; }
(rectangle) 			{ yylval.str = strdup(yytext); return RECTANGLE; }
(set_color)  			{ yylval.str = strdup(yytext); return SET_COLOR; }
\;						{ return END_STATEMENT; }
\*						{ return END;}
[ \t\n]					;

%%