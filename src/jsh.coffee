grammar = require '../jsh/grammar'
compile = require "./compile"
compile_jsh = require "./compile_jsh"
{decompile, simple2full} = require "./decompile"

compileJSON = (brainish) ->
  return JSON.stringify(compile(grammar.parse(brainish)), null, 2)

compileBash = (brainish) ->
  return compile_jsh(compile(grammar.parse(brainish)))

module.exports = {
  "parse": grammar.parse
  "compile": compile
  "decompile": decompile
  "simple2full": simple2full
  "compileJSH": compile_jsh
  "compileJSON": compileJSON
  "compileBash": compileBash
}
