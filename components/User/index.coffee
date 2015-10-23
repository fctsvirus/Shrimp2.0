module.exports = class User
  name: 'User'
  view: __dirname
  style: __dirname

  init: ->
    @model.ref 'user', @model.scope '_page.user'
    @userId = @model.scope().get '_session.userId'

  setUserName: ->
    userName = @model.del 'userName'
    unless userName? and userName.trim().length > 0
      return alert 'You need to set a name!'
    @model.root.set 'users.' + @userId + '.userName', userName

  setProfessor: ->
    isProfessor = @model.get 'user.isProfessor'
    @model.root.set 'users.' + @userId + '.isProfessor', isProfessor
