module.exports = class Game
  name: 'page:Game'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'game', @model.scope '_page.game'
    @model.ref 'players', @model.scope '_page.players'
    @model.ref 'user', @model.scope '_page.user'

  startGame: ->
    @model.set 'game.started', true
