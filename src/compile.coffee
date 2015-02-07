stdlib = require './corelib/stdlib'

visit = (node) ->
  ret = {
    "id": node.id
    "illusion": node.type
    "input": {}
  }
  type = null
  type = stdlib[node.type] if stdlib[node.type]?
  for i in [0..node.inputs.length]
    ret.input[type.input[i]] = node.inputs[i]
  return {"type": type, "ret": ret}

compile = (program) ->
  ret = {
    "illusion": {}
    "janish": []
  }

  for node in program.apply().codes
    obj = visit(node)
    ret.illusion[node.type] = obj.type
    ret.janish.push obj.ret

  return ret

module.exports = compile
