# Required
AppDispatcher     = require('../../dispatcher/')

# Constants
Constants         = require('../../constants/')

Actions =

  loadScript: (data) ->
    AppDispatcher.handleViewAction
      actionType  : Constants.LOAD_SCRIPT
      data        : data

module.exports = Actions
