fs = require 'fs'
path = require 'path'
librato = require 'librato-node'

module.exports = (robot, scripts) ->
  scriptsPath = path.resolve(__dirname, 'src', 'scripts')
  fs.exists scriptsPath, (exists) ->
    if exists
      for script in fs.readdirSync(scriptsPath)
        if scripts? and '*' not in scripts
          robot.loadFile(scriptsPath, script) if script in scripts
        else
          robot.loadFile(scriptsPath, script)
      librato.configure
        email:  process.env.LIBRATO_EMAIL
        token:  process.env.LIBRATO_TOKEN
      librato.on 'error', (err) ->
        console.log 'error publishing librato metric:'
        console.log err
      librato.start()
