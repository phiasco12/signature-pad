var exec = require('cordova/exec');

var SignaturePadModal = {
  open: function(successCallback, errorCallback) {
    if (typeof successCallback !== "function") {
      console.error("SignaturePadModal: successCallback must be a function");
      return;
    }
    if (typeof errorCallback !== "function") {
      console.error("SignaturePadModal: errorCallback must be a function");
      return;
    }

    exec(successCallback, errorCallback, 'SignaturePadPlugin', 'open', []);
  }
};

module.exports = SignaturePadModal;
