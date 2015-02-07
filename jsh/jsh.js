(function() {
  var compile, compileBash, compileJSON, compile_jsh, decompile, grammar, simple2full, _ref;

  grammar = require('../jsh/grammar');

  compile = require("./compile");

  compile_jsh = require("./compile_jsh");

  _ref = require("./decompile"), decompile = _ref.decompile, simple2full = _ref.simple2full;

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
    "simple2full": simple2full,
    "compileJSH": compile_jsh,
    "compileJSON": compileJSON,
    "compileBash": compileBash
  };

}).call(this);
