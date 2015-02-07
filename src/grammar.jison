/* description: Brainish Programming Language's Parser */

/* components */
%{

var ast = require('./ast');
var anonymousBase = Math.floor((Math.random() * 1000000000) + 1);

%}


/* lexical grammar */
%lex

esc \\\\

%%

(\n|\s|\t)+               /* ignore */

"("                       return 'LPARENTHESIS'
")"                       return 'RPARENTHESIS'
"{"                       return 'LBRACE'
"}"                       return 'RBRACE'
":"                       return 'COLON'
"."                       return 'DOT'
","                       return 'COMMA'
";"                       return 'SEMICOLON'
[a-z][a-zA-Z_0-9]*        return 'ID'
[A-Z][A-Z_0-9]+           return 'TYPE'
\"(?:{esc}[\"bfnrt/{esc}]|{esc}u[a-fA-F0-9]{4}|[^\"{esc}])*\"    { yytext = yytext.substr(1,yyleng-2); return 'STRING'; }
<<EOF>>                   return 'EOF'


/lex


%start program

%%

program
  : defineList codeList EOF
    { $$ = new ast.Program($1, $2); return $$; }
  ;

codeList
  : code codeList
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

defineList
  : define defineList
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

code
  : ID COLON TYPE LPARENTHESIS paramList RPARENTHESIS LBRACE codeList RBRACE
    { $$ = new ast.Code($1, $3, $5, $8); }
  | ID COLON TYPE LPARENTHESIS paramList RPARENTHESIS SEMICOLON
    { $$ = new ast.Code($1, $3, $5, []); }
  | COLON TYPE LPARENTHESIS paramList RPARENTHESIS LBRACE codeList RBRACE
    { anonymousBase++; $$ = new ast.Code("t" + anonymousBase, $2, $4, $7); }
  | COLON TYPE LPARENTHESIS paramList RPARENTHESIS SEMICOLON
    { anonymousBase++; $$ = new ast.Code("t" + anonymousBase, $2, $4, []); }
  ;

define
  : TYPE LPARENTHESIS defParamList RPARENTHESIS COLON defParamList LBRACE STRING RBRACE
    { $$ = new ast.Def($1, $3, $6, $8); }
  | TYPE LPARENTHESIS defParamList RPARENTHESIS LBRACE STRING RBRACE
    { $$ = new ast.Def($1, $3, [], $6); }
  ;

paramList
  : param paramListTail
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

paramListTail
  : COMMA param paramListTail
    { $$ = [$2].concat($3); }
  |
    { $$ = []; }
  ;

param
  : STRING
    { $$ = $1 }
  | ID DOT ID
    { $$ = (function(para1, para2){return para1+'.'+para2;})($1, $3); }
  ;

defParamList
  : defParam defParamTail
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

defParamTail
  : COMMA defParam defParamTail
    { $$ = [$2].concat($3); }
  |
    { $$ = []; }
  ;

defParam
  : ID
    { $$ = $1; }
  ;
