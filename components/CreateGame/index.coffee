consts = require '../../apps/consts/consts.json'

module.exports = class CreateGame
  name: 'CreateGame'
  view: __dirname
  style: __dirname

  createGame: ->
    gameName = @model.del 'gameName'
    unless gameName? and gameName.trim().length > 0
      return alert 'You need to set the name of the game'
    @model.scope('games').add
      name: gameName
      userIds: []
      rounds: [1..consts.MAX_ROUNDS]
      maxPlayers: consts.MAX_PLAYERS
      currentRound: consts.CURRENT_ROUND
      started: false
      finished: false