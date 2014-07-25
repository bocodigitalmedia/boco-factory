CustomError = require('boco-error').CustomError

class CommandNotRegistered extends CustomError
  constructPayload: (params = {}) ->
    name: params.name

module.exports = CommandNotRegistered
