# Required
AppDispatcher     = require('../../dispatcher/')
EventEmitter      = require('events').EventEmitter
Assign            = require('object-assign')
Yaks              = require('yaks')

# Constants
Constants         = require('../../constants/')


# Local Constants
CHANGE_EVENT      = 'change'

# Collections
_user             = {
                      status: "not_logged_in",
                      details: {}
                    } 

status_url  = "http://studentbeans.dev/verge/status.json"
details_url = "http://studentbeans.dev/verge/status.json"

# Getters

_fetchStatus = ->
  req = Yaks.UTILS.request
    url: status_url
    type: 'json'
    contentType: 'application/json'
  req.then (resp)->
    _user.status = resp.status
    UserStore.emitChange()


# Store
UserStore = Assign({}, EventEmitter::,

  # Get the full User object
  #
  # @return [Object]
  #
  getAll: ->
    _user

  getStatus: ->
    _user.status

  getDetails: ->
    _user.details

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

  dispatcherIndex: AppDispatcher.register( (payload) ->
      action = payload.action
      
      switch action.actionType
        when Constants.USER_FETCH_STATUS
          _fetchStatus(action.data)
          break

        when Constants.USER_FETCH_DETAILS
          _fetchDetails(action.data)
          break

      return true
    )
)

module.exports = UserStore
