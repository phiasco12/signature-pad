package com.example.signaturepad;

import android.app.Activity;
import android.content.Intent;
import android.util.Base64;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.os.Bundle;
import android.provider.MediaStore;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

public class SignaturePad extends CordovaPlugin {

    private CallbackContext savedCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        if (action.equals("open")) {
            this.savedCallback = callbackContext;

            Intent intent = new Intent(cordova.getActivity(), SignaturePadActivity.class);
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
