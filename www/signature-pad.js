var exec = require('cordova/exec');

var SignaturePadModal = {
  open: function(successCallback, errorCallback) {
    const canSignWithName = localStorage.getItem('cansignwithname') === 'true';
    exec(successCallback, errorCallback, 'SignaturePadPlugin', 'open', [canSignWithName]);
  }
};

module.exports = SignaturePadModal;
