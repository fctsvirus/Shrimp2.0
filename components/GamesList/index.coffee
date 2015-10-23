reactiveFns = require '../Libs/reactiveFns'

module.exports = class GamesList
  name: 'GamesList'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'games', @model.scope '_page.games'
    @model.ref 'user', @model.scope '_page.user'
    @userId = @model.scope().get '_session.userId'
    @model.start 'gamesList', 'games', 'user', reactiveFns.getGamesList

  join: (game, e) ->
    e.preventDefault()
    isProfessor = @model.get 'user.isProfessor'
    userName = @model.get 'user.userName'
    unless userName? and userName.trim().length > 0
      return alert 'You do not have a name'
    if not(@userId in game.userIds)
      if not isProfessor
        @model.root.add 'players', {
          gameId: game.id
          playerId: @userId
          quantities: []
        }
      @model.root.push 'games.' + game.id + '.userIds', @userId
      @app.history.push '/game/' + game.id
