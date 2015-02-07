{Use} = require '../jsh/ast'

exports.testLS = (test) ->
  _ls = new Use "ls", "ListFile", ["."]
  compile = _ls.apply()
  test.equal "ls", compile.id
  test.equal "ListFile", compile.type
  test.equal ".", compile.inputs[0]
  test.equal 0, compile.subs.length
  test.done()

exports.testFOR = (test) ->
  _ls = new Use "ls", "LS", ["."]
  _for = new Use "for", "FOR", ["ls.fileList"], [
    new Use "echo", "ECHO", ["for.itertor"]
  ]
  compile = _for.apply()
  test.equal 1, compile.subs.length
  test.equal "echo", compile.subs[0].id
  test.equal "ECHO", compile.subs[0].type
  test.done()
