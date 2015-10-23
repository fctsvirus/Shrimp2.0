derby = require 'derby'

app = module.exports = derby.createApp 'shrimp', __filename

global.app = app

app.use require 'derby-router'
app.use require 'derby-debug'
app.serverUse module, 'derby-jade'
app.serverUse module, 'derby-stylus'

app.component require './pages/Home'
app.component require './pages/Game'
app.component require '../../components/User'
app.component require '../../components/CreateGame'
app.component require '../../components/GamesList'
app.component require '../../components/GameInfo'
app.component require '../../components/Professor'
app.component require '../../components/SubmitForm'
app.component require '../../components/Table'

app.loadViews __dirname + '/views'
app.loadStyles __dirname + '/styles'

BaseController = require './Controller/BaseController'

app.get '/', (page, model) ->
  BaseController.getMainPage(page, model)

app.get '/game/:gameId', (page, model, params) ->
  BaseController.getGamePage(page, model, params)
