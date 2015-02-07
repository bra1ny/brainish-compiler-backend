module.exports = {
  "ECHO": {
    "input": ["content"]
    "sub": null
    "output": []
    "bash": "echo _input(content)"
  }
  "PRINTF": {
    "input": ["content"]
    "sub": "null"
    "output": []
    "bash": "printf _input(content)"
  }
  "LS": {
    "input": ["path"]
    "sub": null
    "output": ["fileList"]
    "bash": "_var(fileList)=$(ls _input(path))"
  }
  "CAT": {
    "input": ["file"]
    "sub": null
    "output": ["content"]
    "bash": "_var(content)=`cat _input(file)`"
  }
  "FOR_EACH": {
    "input": ["list"]
    "sub": {
      "body": "iterator"
    }
    "bash": "for _var(iterator) in _input(list); do\n    _sub(body)done;"
  }
}
