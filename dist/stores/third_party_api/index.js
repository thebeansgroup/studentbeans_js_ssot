// Generated by CoffeeScript 1.9.2
var AppDispatcher, Assign, CHANGE_EVENT, Constants, EventEmitter, ExternalScriptStore, Globals, _loadScript, _scripts, _setLoadState;

AppDispatcher = require('../../dispatcher/');

EventEmitter = require('events').EventEmitter;

Assign = require('object-assign');

Constants = require('../../constants/');

CHANGE_EVENT = 'change';

Globals = window.Scripts = {};

_scripts = {
  'google_maps': {
    loaded: false,
    src: 'https://maps.googleapis.com/maps/api/js?v=3.exp&callback=Scripts.initializeGoogleMaps'
  }
};

Globals.initializeGoogleMaps = function() {
  Globals.initializeGoogleMaps = null;
  return _setLoadState('google_maps', true);
};

_setLoadState = function(type, value) {
  _scripts[type].loaded = value;
  return ExternalScriptStore.emitChange();
};

_loadScript = function(type) {
  var script;
  if (!_scripts[type].loaded) {
    script = document.createElement('script');
    script.async = 'async';
    script.src = _scripts[type].src;
    document.getElementsByTagName('head')[0].appendChild(script);
    return script.onload = function() {};
  }
};

ExternalScriptStore = Assign({}, EventEmitter.prototype, {
  getAll: function() {
    return _scripts;
  },
  hasScriptLoaded: function(type) {
    return _scripts[type].loaded;
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
      case Constants.LOAD_SCRIPT:
        _loadScript(action.data);
        break;
    }
    return true;
  })
});

module.exports = ExternalScriptStore;
