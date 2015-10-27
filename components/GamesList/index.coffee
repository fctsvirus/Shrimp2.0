reactiveFns = require '../Libs/reactiveFns'

module.exports = class GamesList
  name: 'GamesList'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'games', @model.scope '_page.games'
    @model.ref 'user', @model.scope '_page.user'
    @userId = @model.scope().get '_session.userId'
    @model.start 'gamesList', 'games', 'user.isProfessor', reactiveFns.getGamesList

  join: (game) ->
    isProfessor = @model.get 'user.isProfessor'
    userName = @model.get 'user.userName'
    unless userName? and userName.trim().length > 0
      return alert 'You do not have a name'
    @app.history.push '/game/' + game.id
