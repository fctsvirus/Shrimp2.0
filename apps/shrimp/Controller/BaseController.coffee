_ = require 'lodash'

exports.getMainPage = (page, model) ->
  userId = model.get '_session.userId'
  user = model.at('users.' + userId)
  model.subscribe 'games', user, ->
    model.at('games').filter().ref '_page.games'
    model.ref '_page.user', user
    page.render 'page:Home'

exports.getGamePage = (page, model, params) ->
  userId = model.get '_session.userId'
  game = model.at('games.' + params.gameId)
  user = model.at('users.' + userId)
  model.subscribe game, ->
    model.ref '_page.game', game
    model.ref '_page.game.currentRound', 'games.' + params.gameId + '.currentRound'
    usersInGame = model.query 'users', '_page.userIds'
    playersInGame = model.query 'players', { 'gameId': params.gameId }
    model.subscribe usersInGame, user, playersInGame, ->
      model.ref '_page.user', user
      isProfessor = model.get '_page.user.isProfessor'
      if not isProfessor and not(userId in _.pluck(model.get('players'), 'userId'))
        model.add 'players',
          gameId: params.gameId
          userId: userId
          quantities: []
        model.increment '_page.game.playerCounter'
      else if isProfessor and not(userId in model.get('_page.game.professorIds'))
        model.push '_page.game.professorIds', userId
      model.start '_page.userIds', 'players', 'getUserIds'
      model.start '_page.playerIds', 'players', 'getPlayerIds'
      model.ref '_page.players', playersInGame
      page.render 'page:Game'