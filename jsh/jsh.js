(function() {
  var compile, compileBash, compileJSON, compile_jsh, decompile, grammar;

  grammar = require('../jsh/grammar');

  compile = require("./compile");

  compile_jsh = require("./compile_jsh");

  decompile = require("./decompile");

  compileJSON = function(brainish) {
    return JSON.stringify(compile(grammar.parse(brainish)), null, 2);
  };

  compileBash = function(brainish) {
    return compile_jsh(compile(grammar.parse(brainish)));
  };

  module.exports = {
    "parse": grammar.parse,
    "compile": compile,
    "decompile": decompile,
    "compileJSON": compileJSON,
    "compileBash": compileBash
  };

}).call(this);
