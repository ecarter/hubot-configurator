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
    return attr: attr, value: value

  robot.respond /config (\w+)(=(.*))?/i, (msg) ->
    name =  msg.match[1]
    value = msg.match[3]
    if value
      cnf = check name, value
      if cnf
        process.env[name] = value
        message = "variable set: #{name} = #{value}"
      else
        message = "Sorry, cannot set #{name}"
    else
      cnf = check name, process.env[name]
      message = if cnf then "#{name}: #{cnf.value}" else "Sorry, couldn't find #{name}"
    msg.send message

  robot.respond /config$/i, (msg) ->
    config = []
    for own attr, value of process.env
      cnf = check attr, value
      if cnf
        config.push "#{attr}: #{value}"
    msg.send config.join("\n")

