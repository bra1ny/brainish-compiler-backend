class Expression
  constructor: () ->

  apply: () ->

class Use extends Expression
  constructor: (@id, @type, @inputs, @subs) ->

  apply: () ->
    ret = {
      "id": @id
      "type": @type
      "inputs": []
      "subs": []
    }
    if @inputs?
      for input in @inputs
        ret.inputs.push input.toString()

    if @subs?
      for sub in @subs
        ret.subs.push sub.apply()
    return ret

module.exports = {
  Use: Use
}
