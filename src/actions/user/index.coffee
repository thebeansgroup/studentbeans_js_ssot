# Required
AppDispatcher     = require('../../dispatcher/')

# Constants
Constants         = require('../../constants/')

Actions =
  fetchStatus: (data) ->
    AppDispatcher.handleViewAction
      actionType  : Constants.USER_FETCH_STATUS
      data        : data

module.exports = Actions
