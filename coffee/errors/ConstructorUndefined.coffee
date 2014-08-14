FactoryError = require './FactoryError'

class ConstructorUndefined extends FactoryError
  setDefaults: ->
    @message ?= "Constructor is undefined."
    super()

module.exports = ConstructorUndefined
