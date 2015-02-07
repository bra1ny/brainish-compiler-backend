/* description: Brainish Programming Language's Parser */

/* components */
%{

var ast = require('./ast');

%}


/* lexical grammar */
%lex
%x bash

%%
["]                      this.begin('bash')
<bash>[^"]*               return 'BASH'
<bash>["]                 this.popState()




(\n|\s|\t)+               /* ignore */

"("                       return 'LPARENTHESIS'
")"                       return 'RPARENTHESIS'
"{"                       return 'LBRACE'
"}"                       return 'RBRACE'
":"                       return 'COLON'
","                       return 'COMMA'
";"                       return 'SEMICOLON'
[a-z]+[0-9]*              return 'ID'
\"[0-9a-zA-Z]*\"          return 'STRING'
[A-Z]+                    return 'TYPE'
<<EOF>>                   return 'EOF'
.                         return 'DOT'


/lex


%start program

%%

program
  : definitionList useList EOF
    { $$ = (function(para1, para2){return para1 + para2;})($1, $2); return $$; }
  ;

definitionList
  : definition definitionList
    { $$ = [$1].concat($2); }
  |
    { $$ = []; }
  ;

definition
  : TYPE LPARENTHESIS IOList RPARENTHESIS COLON IOList LBRACE BASH RBRACE
    { $$ = new ast.Definition($1, $3, $6, $8); }
  ;
IOList
  : ID IOList
    { $$ = [$1].concat($2); }
  | COMMA ID IOList
    { $$ = [$2].concat($3); }
  |
    { $$ = [] }
  ; 

useList
  : use useList
    { $$ = [$1].concat($2); }
  | 
    { $$ = []; }
  ;

use
  : ID COLON TYPE LPARENTHESIS inputList RPARENTHESIS LBRACE useList RBRACE
    { $$ = new ast.Use($1, $3, $5, $8); } 
  | ID COLON TYPE LPARENTHESIS inputList RPARENTHESIS
    { $$ = new ast.Use($1, $3, $5, []); }
  ;



inputList
  : input inputList
    { $$ = [$1].concat($2); }
  | COMMA input inputList
    { $$ = [$2].concat($3); }
  |
    { $$ = []; }
  ;

input
  : ID DOT ID
    { $$ = (function(para1, para2){return para1+'.'+para2;})($1, $3); }
  ;
