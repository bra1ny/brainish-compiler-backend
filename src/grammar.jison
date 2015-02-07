/* description: Brainish Programming Language's Parser */

/* components */
%{

var ast = require('./ast');

%}


/* lexical grammar */
%lex
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
\"[0-9a-zA-Z]*\"          return 'STRING'
[A-Z][A-Z_0-9]+           return 'TYPE'
<<EOF>>                   return 'EOF'


/lex


%start program

%%

program
  : codeList EOF
    { $$ = new ast.Program([], $1); return $$; }
  ;

codeList
  : code codeList
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

code
  : ID COLON TYPE LPARENTHESIS paramList RPARENTHESIS LBRACE codeList RBRACE
    { $$ = new ast.Code($1, $3, $5, $8); }
  | ID COLON TYPE LPARENTHESIS paramList RPARENTHESIS SEMICOLON
    { $$ = new ast.Code($1, $3, $5, []); }
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
