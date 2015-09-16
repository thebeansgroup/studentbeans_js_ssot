// Generated by CoffeeScript 1.9.2
var AppDispatcher, Assign, CHANGE_EVENT, Constants, EventEmitter, UserStore, Yaks, _fetchDetails, _fetchStatus, _user, details_url, ref, ref1, status_url;

AppDispatcher = require('../../dispatcher/');

EventEmitter = require('events').EventEmitter;

Assign = require('object-assign');

Yaks = require('yaks');

Constants = require('../../constants/');

CHANGE_EVENT = 'change';

_user = {
  role: "unregistered_users",
  status: "not_logged_in",
  details: {}
};

window._user = _user;

status_url = (ref = window._stb) != null ? ref.url_manifest.verge_status_path : void 0;

details_url = (ref1 = window._stb) != null ? ref1.url_manifest.join_simple_details_path : void 0;

_fetchStatus = function() {
  var req;
  req = Yaks.UTILS.request({
    url: status_url,
    type: 'json',
    contentType: 'application/json'
  });
  return req.then(function(resp) {
    _user.role = resp.role;
    _user.status = resp.status;
    return UserStore.emitChange();
  });
};

_fetchDetails = function() {
  var req;
  req = Yaks.UTILS.request({
    url: details_url,
    type: 'json',
    contentType: 'application/json'
  });
  return req.then(function(resp) {
    _user.details = resp;
    return UserStore.emitChange();
  });
};

UserStore = Assign({}, EventEmitter.prototype, {
  getAll: function() {
    return _user;
  },
  getRole: function() {
    return _user.role;
  },
  getStatus: function() {
    return _user.status;
  },
  getDetails: function() {
    return _user.details;
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
  dispatcherIndex: AppDispatcher.register(function(payload) {
    var action;
    action = payload.action;
    switch (action.actionType) {
      case Constants.USER_FETCH_STATUS:
        _fetchStatus(action.data);
        break;
      case Constants.USER_FETCH_DETAILS:
        _fetchDetails(action.data);
        break;
    }
    return true;
  })
});

module.exports = UserStore;
