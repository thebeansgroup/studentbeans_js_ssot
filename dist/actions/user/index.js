// Generated by CoffeeScript 1.10.0
var Actions, AppDispatcher, Constants;

AppDispatcher = require('../../dispatcher/');

Constants = require('../../constants/');

Actions = {
  fetchStatus: function(data) {
    return AppDispatcher.handleViewAction({
      actionType: Constants.USER_FETCH_STATUS,
      data: data
    });
  },
  fetchDetails: function(data) {
    return AppDispatcher.handleViewAction({
      actionType: Constants.USER_FETCH_DETAILS,
      data: data
    });
  }
};

module.exports = Actions;
