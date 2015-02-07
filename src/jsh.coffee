fs = require 'fs'
grammar = require '../jsh/grammar'
compile = require "./compile"
compile_jsh = require "./compile_jsh"
decompile = require "./decompile"

compileJSON = (path, argv) ->
  fs.readFile path, "utf8", (err, data) =>
    throw err if err
    console.log JSON.stringify(compile(grammar.parse(data)), null, 2)

compileBash = (path, argv) ->
  fs.readFile path, "utf8", (err, data) =>
    throw err if err
    console.log compile_jsh(compile(grammar.parse(data)))

module.exports = {
  "compile": compile
  "decompile": decompile
  "compileJSON": compileJSON
  "compileBash": compileBash
}
