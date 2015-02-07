module.exports = {
  "ECHO": {
    "input": ["in"]
    "sub": null
    "output": ["string"]
    "bash": "_var(in)=$(echo _input(a))"
  }
  "LS": {
    "input": ["path"]
    "sub": null
    "output": ["fileList"]
    "bash": "_var(fileList)=$(ls _input(path))\n"
  }
  "FOR_EACH": {
    "input": ["list"]
    "sub": {
      "body": "iterator"
    }
    "bash": "for _var(iterator) in $_input(list); do\n    _sub(body)done;\n"
  }
}
