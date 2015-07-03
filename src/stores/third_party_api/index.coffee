# Required
AppDispatcher     = require('../../dispatcher/')
EventEmitter      = require('events').EventEmitter
Assign            = require('object-assign')

# Constants
Constants         = require('../../constants/')

# Local Constants
CHANGE_EVENT      = 'change'

# Global Window Object
Globals     = window.Scripts = {}

# Private Collections
_scripts          = {
                      'google_maps': {
                        loaded    : false,
                        src       : '//maps.googleapis.com/maps/api/js?v=3.exp&callback=Scripts.initializeGoogleMaps'
                        callback  : true
                      }
                      'gapi_client_plus': {
                        loaded    : false,
                        src       : '//apis.google.com/js/client:plus.js'
                        callback  : false
                      }
                      'facebook-jssdk': {
                        loaded    : false,
                        src       : '//connect.facebook.net/en_GB/all.js'
                        callback  : false
                      }
                    }

_timeouts          = []

# Global Definitions
Globals.initializeGoogleMaps = ->
  Globals.initializeGoogleMaps = null
  _setLoadState('google_maps', true)


# Private Definitions
_setLoadState = (type, value) ->
  _scripts[ type ].loaded = value
  ExternalScriptStore.emitChange()


_loadScript = (type, callback) ->
  if !_scripts[ type ].loaded
    script         = document.createElement('script')
    script.async   = 'async'
    script.src     = _scripts[ type ].src

    document.getElementsByTagName('head')[0].appendChild(script)
    script.onload  = ->
      return if _scripts[ type ].callback
      _setLoadState(type, true)


# Store
ExternalScriptStore = Assign({}, EventEmitter::,

  # Get the full User object
  #
  # @return [Object]
  #
  getAll: ->
    _scripts

  # Check if script has loaded
  #
  # @param [String] type of script
  #
  # @return [Bool]
  #
  hasScriptLoaded: (type) ->
    _scripts[ type ].loaded

  fbEnsureInit: (callback) ->
    if !window.fbAPIInit
      _timeouts[ 'fb_init' ] = setTimeout =>
        @fbEnsureInit(callback)
      , 50
    else
      clearTimeout _timeouts[ 'fb_init' ]
      callback()    if(callback)



  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)


  dispatcherIndex: AppDispatcher.register( (payload) ->
    action = payload.action

    switch action.actionType

      when Constants.LOAD_SCRIPT
        _loadScript(action.data.name, action.data.callback)
        break

    true
  )
)

module.exports = ExternalScriptStore
