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
window._user = _user

status_url  = window._stb?.url_manifest.verge_status_path
details_url = window._stb?.url_manifest.join_simple_details_path 

# Getters

_fetchStatus = ->
  req = Yaks.UTILS.request
    url: status_url
    type: 'json'
    contentType: 'application/json'
  req.then (resp)->
    _user.status = resp.status
    UserStore.emitChange()

_fetchDetails = ->
  req = Yaks.UTILS.request
    url: details_url
    type: 'json'
    contentType: 'application/json'
  req.then (resp)->
    _user.details = resp
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
