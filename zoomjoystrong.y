%{
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start statement_list

%union { int i; char* str; float d;}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<str> END
%type<str> CIRCLE
%type<str> LINE
%type<str> RECTANGLE
%type<str> SET_COLOR
%type<str> POINT
%type<d> FLOAT

%%
statement_list:	statement
	|	statement statement_list
;

statement: circle_command END_STATEMENT
	|	line_command END_STATEMENT
	|	point_command END_STATEMENT
	|	rectangle_command END_STATEMENT
	|	setcolor_command END_STATEMENT
	|	end_command

;

circle_command: CIRCLE INT INT INT
	{circle($2,$3,$4);}
;

line_command: LINE INT INT INT INT
	{line($2, $3, $4, $5);}
;

point_command: POINT INT INT
	{point($2, $3);}
;

rectangle_command: RECTANGLE INT INT INT INT
	{rectangle($2, $3, $4, $5);}
;

setcolor_command: SET_COLOR INT INT INT
	{set_color($2, $3, $4);}
;

end_command: END
	{finish();}
;

%%
int main(int argc, char** argv){
	setup();
	yyparse();
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}