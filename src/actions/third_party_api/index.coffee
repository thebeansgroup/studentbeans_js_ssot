# Required
AppDispatcher     = require('../../dispatcher/')

# Constants
Constants         = require('../../constants/')

Actions =

  loadScript: (name, callback) ->
    AppDispatcher.handleViewAction
      actionType: Constants.LOAD_SCRIPT
      data: {
        name: name
        callback: callback
      }

module.exports = Actions
