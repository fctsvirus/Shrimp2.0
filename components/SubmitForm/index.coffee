consts = require '../../apps/consts/consts.json'

module.exports = class SubmitForm
  name: 'SubmitForm'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'game', @model.scope '_page.game'
    @userId = @model.scope().get '_session.userId'
    @model.ref 'players', @model.scope '_page.players'
    @model.ref 'userIds', @model.scope '_page.userIds'

  setQuantity: ->
    quantity = @model.del 'quantity'
    currentRound = @model.get 'game.currentRound'
    maxPlayers = @model.get 'game.maxPlayers'
    rounds = @model.get 'game.rounds'
    if isNaN(parseFloat(quantity)) or not(consts.MIN_QUANTITY <= parseFloat(quantity) <= consts.MAX_QUANTITY)
      return alert 'Wrong input!(should be a number between 0 and 75)'
    count = 0
    index = 0
    for id, i in @model.get 'userIds'
      if id is @userId
        index = i
        @model.set "players.#{index}.quantities.#{currentRound - 1}", quantity
        break
    for player in @model.get 'players'
      unless player.quantities[currentRound - 1]
        break
      count++
    if count is parseFloat(maxPlayers)
      @model.increment 'game.currentRound'
    if @model.get('game.currentRound') > rounds.length
      @model.set 'game.finished', true
