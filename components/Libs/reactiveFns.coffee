_ = require 'lodash'

exports.getGamesList = (games, isProfessor) ->
  list = []
  for game in games
    object =
      name: game.name
      id: game.id
      playerCounter: game.playerCounter
      professorIds: game.professorIds
      canJoin: !!(game.playerCounter < game.maxPlayers || isProfessor)
    list.push object
  list

exports.calculatePrices = (players, currentRound) ->
  prices = []
  if currentRound > 1
    for i in [0..currentRound - 2]
      sum = 0
      for player in players
        sum += parseFloat(player.quantities[i]) if player.quantities[i]?
      prices[i] = 45 - 0.2 * sum
  prices

exports.calculateProfits = (players, prices, currentRound) ->
  costPerShrimp = 5
  profits = {}
  for player in players
    profits[player.userId] = []
    for i in [0..currentRound - 1]
      if player.quantities[i]? and prices[i]?
        profits[player.userId].push player.quantities[i] * (prices[i] - costPerShrimp)
  profits

exports.calculateTotalProfits = (players, profits, currentRound) ->
  totalProfits = {}
  if currentRound > 1
    for player in players
      totalProfit = 0
      for i in [0..currentRound - 2]
        totalProfit += profits[player.userId][i] if profits[player.userId]?[i]?
      totalProfits[player.userId] = totalProfit
  totalProfits

exports.getTheWinner = (totalProfits, players, isFinished) ->
  if isFinished
    for player in players
      if totalProfits[player.userId] is _.max(totalProfits)
        winnerId = player.userId
        break
  winnerId