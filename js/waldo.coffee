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

GateKeeper = require('./waldo/gatekeeper')

module.exports = (robot) ->
  robot.enter (msg) ->
    keeper = new GateKeeper(robot.brain.data)
    keeper.addUserToRoom(msg.message.user.name, msg.message.user.room)

  robot.leave (msg) ->
    keeper = new GateKeeper(robot.brain.data)
    keeper.removeUserFromRoom(msg.message.user.name, msg.message.user.room)

  robot.respond /where('s| is) @?([\w .\-]+)\?*$/i, (msg) ->
    try
      name = msg.match[2].trim()

      users = robot.brain.usersForFuzzyName(name)
      if users.length is 1
        user = users[0]
        keeper = new GateKeeper(robot.brain.data)
        rooms = keeper.getRoomsForUser(user.name)

        if rooms.length is 0
          msg.send "I don't know where #{user.name} is"
        else
          msg.send "#{user.name} is in #{rooms.join(', ')}"
      else if users.length > 1
        names = _map(users, (user) -> user.name)
        msg.send "Which #{name} do you want: #{names}"
      else
        msg.send "Nobody has a name like #{name}"
    catch error
      msg.send error

