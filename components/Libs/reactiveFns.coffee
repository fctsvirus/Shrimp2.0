_ = require 'lodash'

exports.getGamesList = (games, user) ->
  list = []
  for game in games
    object =
      name: game.name
      id: game.id
      userIds: game.userIds
      canJoin: !!(game.userIds.length < game.maxPlayers || user.isProfessor)
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
    profits[player.playerId] = []
    for i in [0..currentRound - 1]
      if player.quantities[i]? and prices[i]?
        profits[player.playerId].push player.quantities[i] * (prices[i] - costPerShrimp)
  profits

exports.calculateTotalProfits = (players, profits, currentRound) ->
  totalProfits = {}
  if currentRound > 1
    for player in players
      totalProfit = 0
      for i in [0..currentRound - 2]
        totalProfit += profits[player.playerId][i] if profits[player.playerId]?[i]?
      totalProfits[player.playerId] = totalProfit
  totalProfits

exports.getTheWinner = (totalProfits, players, isFinished) ->
  if isFinished
    for player in players
      if totalProfits[player.playerId] is _.max(totalProfits)
        winnerId = player.playerId
        break
  winnerId