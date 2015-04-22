librato = require 'librato-node'

class Metrics

  @namespace: (name) ->
    if process.env.REALM
      realm = process.env.REALM.toLowerCase()
    else
      realm = 'local'
    return "#{realm}.#{name}"

  @increment: (name, value = 1) ->
    try
      librato.increment Metrics.namespace(name), value
    catch err
      console.log err

  @measure: (name, value) ->
    try
      librato.measure Metrics.namespace(name), value
    catch err
      console.log err

  # Time a given endpoint.
  #
  # startTime: A Unix timestamp in milliseconds (usually from Date.now())
  @timing: (name, startTime) ->
    try
      elapsedTime = Date.now() - startTime
      librato.measure Metrics.namespace(name), elapsedTime
    catch err
      console.log err

module.exports = Metrics
