package com.example.signaturepad;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Base64;
import android.view.Gravity;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.*;

import java.io.ByteArrayOutputStream;

public class SignaturePadActivity extends Activity {

    private SignatureView signatureView;
    private EditText nameInput;
    private boolean showNameInput = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Detect if name field should be shown
        showNameInput = checkLocalStorageFlag();

        LinearLayout rootLayout = new LinearLayout(this);
        rootLayout.setOrientation(LinearLayout.VERTICAL);
        rootLayout.setBackgroundColor(Color.parseColor("#2d2d2d"));
        rootLayout.setPadding(30, 30, 30, 30);
        rootLayout.setGravity(Gravity.CENTER_HORIZONTAL);

        // Signature Area
        FrameLayout signatureWrapper = new FrameLayout(this);
        int size = (int) (getResources().getDisplayMetrics().widthPixels * 0.9);
        FrameLayout.LayoutParams signatureParams = new FrameLayout.LayoutParams(size, size);
        signatureParams.gravity = Gravity.CENTER;

        signatureView = new SignatureView(this);
        signatureView.setBackgroundColor(Color.WHITE);
        signatureWrapper.setLayoutParams(signatureParams);
        signatureWrapper.addView(signatureView);

        // Trash Button (🗑)
        Button clearBtn = new Button(this);
        clearBtn.setText("🗑");
        clearBtn.setBackgroundColor(Color.parseColor("#da116d"));
        clearBtn.setTextColor(Color.WHITE);
        FrameLayout.LayoutParams clearParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
        );
        clearParams.gravity = Gravity.BOTTOM | Gravity.START;
        clearParams.setMargins(20, 20, 20, 20);
        clearBtn.setLayoutParams(clearParams);
        clearBtn.setOnClickListener(v -> signatureView.clear());

        signatureWrapper.addView(clearBtn);

        rootLayout.addView(signatureWrapper);

        // Name input if enabled
        if (showNameInput) {
            nameInput = new EditText(this);
            nameInput.setHint("Full Name");
            nameInput.setTextColor(Color.WHITE);
            nameInput.setBackgroundColor(Color.parseColor("#444444"));
            nameInput.setPadding(20, 10, 20, 10);
            LinearLayout.LayoutParams nameParams = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT
            );
            nameParams.setMargins(0, 30, 0, 30);
            rootLayout.addView(nameInput, nameParams);
        }

        // Capture button (✔)
        Button captureBtn = new Button(this);
        captureBtn.setText("✔");
        captureBtn.setBackgroundColor(Color.parseColor("#da116d"));
        captureBtn.setTextColor(Color.WHITE);
        LinearLayout.LayoutParams captureParams = new LinearLayout.LayoutParams(
                (int) (getResources().getDisplayMetrics().widthPixels * 0.9),
                LinearLayout.LayoutParams.WRAP_CONTENT
        );
        captureParams.setMargins(0, 40, 0, 0);
        captureBtn.setLayoutParams(captureParams);

        captureBtn.setOnClickListener(v -> {
            Bitmap bmp = signatureView.getSignatureBitmap();
            String base64 = bitmapToBase64(bmp);
            String name = (showNameInput && nameInput != null) ? nameInput.getText().toString() : "";

            String combined = "{\"signature\":\"" + base64 + "\",\"name\":\"" + name + "\"}";
            getIntent().putExtra("signature", combined);
            setResult(RESULT_OK, getIntent());
            finish();
        });

        rootLayout.addView(captureBtn);
        setContentView(rootLayout);
    }

    private String bitmapToBase64(Bitmap bmp) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        return Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP);
    }

    private boolean checkLocalStorageFlag() {
        try {
            // Get WebView user agent to access shared localStorage (Cordova/Monaca uses WebView under the hood)
            WebView webView = new WebView(this);
            WebSettings settings = webView.getSettings();
            String userAgent = settings.getUserAgentString();
            return userAgent.contains("cansignwithname=true"); // This is a workaround hint
        } catch (Exception e) {
            return false;
        }
    }
}
