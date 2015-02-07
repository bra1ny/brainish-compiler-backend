stdlib = require './corelib/stdlib'

visit = (node, defs) ->
  ret = {
    "id": node.id
    "illusion": node.type
    "input": {}
  }
  type = null
  type = defs[node.type] if defs[node.type]?
  type = stdlib[node.type] if stdlib[node.type]?
  for i in [0..node.inputs.length]
    ret.input[type.input[i]] = node.inputs[i]
  return {"type": type, "ret": ret}

compile = (program) ->
  ret = {
    "illusion": {}
    "janish": []
  }

  defs = {}

  for node in program.apply().defs
    defs[node.type] = {
      "input": node.inputs
      "sub": null
      "output": node.outputs
      "bash": node.bash
    }

  for node in program.apply().codes
    obj = visit(node, defs)
    ret.illusion[node.type] = obj.type
    ret.janish.push obj.ret

  return ret

module.exports = compile
