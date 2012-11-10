# Description:
#   Get and set hubot-scripts environment variables via hubot
# 
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_CONFIG_PREFIX - force variable setting with prefix eg. HUBOT_
#   HUBOT_CONFIG_IGNORE - hide variables regexp: (PATH|PS1)
#   HUBOT_CONFIG_HASH - hash values like passwords regexp: _PASSWORD$
#
# Commands:
#   hubot config - show environment variables
#   hubot config <key> - get environment variable value
#   hubot config <key>=<value> - set environment variable
#
# Author:
#   ecarter

module.exports = (robot) ->

  prefix = process.env.HUBOT_CONFIG_PREFIX
  ignore = process.env.HUBOT_CONFIG_IGNORE
  hash =   process.env.HUBOT_CONFIG_HASH
  config = []

  check = (attr, value) ->
    if prefix
      pattern = new RegExp "^#{prefix}"
      unless pattern.test attr
        return false
    if ignore
      pattern = new RegExp ignore
      unless pattern.test attr
        return false
    if hash
      pattern = new RegExp hash
      if pattern.test attr
        value = "********"
    config.push "#{attr}: #{value}"

  robot.respond /config? (.*)=(.*)/i, (msg) ->
    name = if prefix then "#{prefix}_#{msg.match[1]}" else msg.match[1]
    process.env[name] = msg.match[2]
    msg.send "variable set: #{name} = #{msg.match[2]}"

  robot.respond /config$/i, (msg) ->
    for own attr, value of process.env
      check attr, value
    msg.send config.join("\n")

