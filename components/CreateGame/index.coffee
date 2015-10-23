module.exports = class CreateGame
  name: 'CreateGame'
  view: __dirname
  style: __dirname

  createGame: ->
    gameName = @model.del 'gameName'
    unless gameName? and gameName.trim().length > 0
      return alert 'You need to set the name of the game'
    @model.root.add 'games',
      name: gameName
      userIds: []
      rounds: [1..8]
      maxPlayers: 2
      currentRound: 1
      started: false
      finished: false