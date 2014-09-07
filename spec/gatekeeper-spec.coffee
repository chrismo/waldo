GateKeeper = require('../js/waldo/gatekeeper')

describe 'GateKeeper', ->
  beforeEach ->
    @keeper = new GateKeeper

  it 'should store a new user entering a room', ->
    @keeper.addUserToRoom('chrismo', 1)
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms[0]).toBe 1

  it 'should add a room for an existing user', ->
    @keeper.addUserToRoom('chrismo', 1)
    @keeper.addUserToRoom('chrismo', 2)
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms[0]).toBe 1
    expect(rooms[1]).toBe 2

  it 'should remove a room from an existing user', ->
    @keeper.addUserToRoom('chrismo', 1)
    @keeper.addUserToRoom('chrismo', 2)
    @keeper.removeUserFromRoom('chrismo', 1)
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms[0]).toBe 2

  it 'should not explode if removing an unlisted user', ->
    @keeper.removeUserFromRoom('chrismo', 1)
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms.length).toBe 0

  it 'should return empty array for unlisted user', ->
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms.length).toBe 0

  it 'should not explode if removing a known user from a room not already in', ->
    @keeper.addUserToRoom('chrismo', 1)
    @keeper.removeUserFromRoom('chrismo', 2)
    rooms = @keeper.getRoomsForUser('chrismo')
    expect(rooms[0]).toBe 1

  it 'should accept an external store', ->
    store = {}
    keeper = new GateKeeper(store)
    keeper.addUserToRoom('chrismo', 1)
    keeper = new GateKeeper(store)
    rooms = keeper.getRoomsForUser('chrismo')
    expect(rooms.length).toBe 1
    expect(rooms[0]).toBe 1
