# Required
AppDispatcher     = require('../../dispatcher/')
EventEmitter      = require('events').EventEmitter
Assign            = require('object-assign')

# Constants
Constants         = require('../../constants/')


# Local Constants
CHANGE_EVENT      = 'change'

# Collections
_user             = {}

# Store
UserStore = Assign({}, EventEmitter::,

  # Get the full User object
  #
  # @return [Object]
  #
  getAll: ->
    _user

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

  dispatcherIndex: AppDispatcher.register( (payload) ->
      action = payload.action

      return true
    )
)

module.exports = UserStore
