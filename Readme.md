# hubot-configurator
A [hubot](https://github.com/github/hubot) script for getting and setting environment variables via hubot.

_Useful for quickly changing env vars when testing [hubot-scripts](https://github.com/github/hubot-scripts)_

## Commands

    hubot config - show environment variables
    hubot config <key> - get environment variable value
    hubot config <key>=<value> - set environment variable

## Configuration

* `HUBOT_CONFIG_PREFIX` - force variable setting with prefix eg. `HUBOT_`
* `HUBOT_CONFIG_IGNORE` - hide variables regexp: `(PATH|PS1)`
* `HUBOT_CONFIG_HASH` - hash values like passwords regexp: `_PASSWORD$`

# Installation

Copy `configurator.coffee` to your `hubot/scripts` directory

# Author

[Erin Carter](http://github.com/ecarter)

# License

MIT

