# Description:
#   User tracker
#
# Dependencies:
#   underscore
#
# Configuration:
#
# Commands:
#
# Authors:
#   chrismo

module.exports = (robot) ->
  robot.enter (msg) ->
    robot.logger.info "User #{msg.message.user.name} entered #{msg.message.user.room}"

  robot.leave (msg) ->
    robot.logger.info "User #{msg.message.user.name} left #{msg.message.user.room}"
