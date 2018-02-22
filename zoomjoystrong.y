%{
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
	//int num_contacts = 0;
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
statement_list:	statement END
	|	statement statement_list
;

statement: something something END_STATEMENT

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

contact:	name SEPARATOR address SEPARATOR PHONE SEPARATOR email
		{ printf("\n----------\n"); ++num_contacts; }
;

name:		SALUTATION STRING STRING 
		{ printf("%s %s %s\n", $1, $2, $3);	}
;

address:	NUMBER STRING ROAD_TYPE STRING STRING NUMBER 
		{ printf("%d %s %s\n%s, %s %d\n", $1, $2, $3, $4, $5, $6); }
;

email:		STRING AT_SYMBOL STRING DOMAIN
		{ printf("%s@%s%s", $1, $3, $4); }
%%
int main(int argc, char** argv){
	yyparse();
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}