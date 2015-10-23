exports.getMainPage = (page, model) ->
  userId = model.get '_session.userId'
  user = model.at('users.' + userId)
  model.subscribe 'games', 'users', user, ->
    model.at('games').filter().ref '_page.games'
    model.set 'users.' + userId + '.isProfessor', false
    model.ref '_page.user', user
    page.render 'page:Home'

exports.getGamePage = (page, model, params) ->
  userId = model.get '_session.userId'
  game = model.at('games.' + params.gameId)
  user = model.at('users.' + userId)
  model.subscribe game, ->
    model.ref '_page.game', game
    model.ref '_page.game.currentRound', 'games.' + params.gameId + '.currentRound'
    usersInGame = model.query 'users', 'games.' + params.gameId + '.userIds'
    playersInGame = model.query 'players', { 'gameId': params.gameId }
    model.subscribe usersInGame, user, playersInGame, ->
      model.ref '_page.user', user
      model.ref '_page.players', playersInGame
      page.render 'page:Game'