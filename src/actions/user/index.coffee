# Required
AppDispatcher     = require('../../dispatcher/')

# Constants
Constants         = require('../../constants/')

Actions =
  exampleAction: (data) ->
    AppDispatcher.handleViewAction
      actionType  : Constants.EXAMPLE
      data        : data
