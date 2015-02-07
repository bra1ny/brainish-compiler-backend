{Use} = require '../jsh/ast'

exports.testUse = (test) ->
  use = new Use "ls", "ListFile", "."
  compile = use.apply()
  test.equal "ls", compile.id, "ID"
  test.equal "ListFile", compile.type, "type"
  test.equal ".", compile.inputs[0], "input"
  test.equal 0, compile.subs.length, "sub"
  test.done()
