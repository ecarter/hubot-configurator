# Description:
#   Get and set environment variables via hubot

# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot config - show environment variables
#   hubot config <variable>=<value> - set environment variables
#
# Author:
#   ecarter

module.exports = (robot) ->

  robot.respond /config? (.*)=(.*)/i, (msg) ->
    process.env[msg.match[1]] = msg.match[2]
    msg.send "variable set: #{msg.match[1]} = #{msg.match[2]}"

  robot.respond /config$/i, (msg) ->
    config = []
    for own attr, value of process.env
      config.push "#{attr}: #{value}"
    console.log 'config', config
    msg.send config.join("\n")

