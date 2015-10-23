_ = require 'lodash'
reactiveFns = require '../Libs/reactiveFns'

module.exports = class Table
  name: 'Table'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'game', @model.scope '_page.game'
    @model.ref 'players', @model.scope '_page.players'
    @model.ref 'currentRound', @model.scope '_page.game.currentRound'
    @model.ref 'user', @model.scope '_page.user'
    @model.start 'prices', 'players', 'currentRound', reactiveFns.calculatePrices
    @model.start 'profits', 'players', 'prices', 'currentRound', reactiveFns.calculateProfits
    @model.start 'totalProfits', 'players', 'profits', 'currentRound', reactiveFns.calculateTotalProfits
    @model.start 'winnerId', 'totalProfits', 'players', 'game.finished', reactiveFns.getTheWinner

  roundValues: (value) ->
    _.floor(value, 2)
