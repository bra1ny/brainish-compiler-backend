fs = require 'fs'
grammar = require '../jsh/grammar'
compile = require "./compile"
compile_jsh = require "./compile_jsh"
decompile = require "./decompile"

compileFile = (path, argv) ->
  fs.readFile path, "utf8", (err, data) =>
    throw err if err
    console.log compile_jsh(compile(grammar.parse(data)))

module.exports = {
  "compile": compile
  "decompile": decompile
  "compileFile": compileFile
}
