_ = require('underscore')

module.exports = class GateKeeper
  constructor: (store) ->
    store ||= {}
    @userRooms = (store.waldo ||= {})

  addUserToRoom: (user, roomNumber) ->
    @userRooms[user] ||= []
    @userRooms[user].push(roomNumber)

  removeUserFromRoom: (user, roomNumber) ->
    @userRooms[user] = _.without(@userRooms[user], roomNumber)

  getRoomsForUser: (user, roomNumber) ->
    @userRooms[user] || []
