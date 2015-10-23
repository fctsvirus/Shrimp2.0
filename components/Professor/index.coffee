module.exports = class Professor
  name: 'Professor'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'game', @model.scope '_page.game'
    @model.ref 'players', @model.scope '_page.players'

  goToTheNextRound: ->
    players = @model.get 'players'
    currentRound = @model.get 'game.currentRound'
    for player, i in players
      @model.set "players.#{i}.quantities.#{currentRound - 1}", 0 unless player.quantities[currentRound - 1]?
    @model.increment 'game.currentRound'