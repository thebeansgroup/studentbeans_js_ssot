// Generated by CoffeeScript 1.9.2
var Actions, AppDispatcher, Constants;

AppDispatcher = require('../../dispatcher/');

Constants = require('../../constants/');

Actions = {
  loadScript: function(data) {
    return AppDispatcher.handleViewAction({
      actionType: Constants.LOAD_SCRIPT,
      data: data
    });
  }
};

module.exports = Actions;
