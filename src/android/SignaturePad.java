package com.example.signaturepad;

import android.app.Activity;
import android.content.Intent;

import org.apache.cordova.*;
import org.json.JSONArray;

public class SignaturePad extends CordovaPlugin {

    private CallbackContext savedCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        if (action.equals("open")) {
            this.savedCallback = callbackContext;

            boolean showName = args.optBoolean(0, false);

            Intent intent = new Intent(cordova.getActivity(), SignaturePadActivity.class);
            intent.putExtra("showNameField", showName);

            cordova.setActivityResultCallback(this);
            cordova.getActivity().startActivityForResult(intent, 1001);

            return true;
        }
        return false;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (requestCode == 1001) {
            if (resultCode == Activity.RESULT_OK && intent != null) {
                String base64 = intent.getStringExtra("signature");
                savedCallback.success(base64);
            } else {
                savedCallback.error("cancelled");
            }
        }
    }
}
