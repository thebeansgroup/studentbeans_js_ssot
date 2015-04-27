// Generated by CoffeeScript 1.9.2
(function() {
  var AppDispatcher, Assign, CHANGE_EVENT, Constants, EventEmitter, UserStore, _user;

  AppDispatcher = require('../../dispatcher/');

  EventEmitter = require('events').EventEmitter;

  Assign = require('object-assign');

  Constants = require('../../constants/');

  CHANGE_EVENT = 'change';

  _user = {};

  UserStore = Assign({}, EventEmitter.prototype, {
    getAll: function() {
      return _user;
    },
    emitChange: function() {
      return this.emit(CHANGE_EVENT);
    },
    addChangeListener: function(callback) {
      return this.on(CHANGE_EVENT, callback);
    },
    removeChangeListener: function(callback) {
      return this.removeListener(CHANGE_EVENT, callback);
    },
    dispatcherIndex: AppDispatcher.register(function() {
      var action;
      action = payload.action;
      return true;
    })
  });

  module.exports = UserStore;

}).call(this);
