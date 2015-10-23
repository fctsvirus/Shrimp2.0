module.exports = class GameInfo
  name: 'GameInfo'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'game', @model.scope '_page.game'
    @model.ref 'players', @model.scope '_page.players'
