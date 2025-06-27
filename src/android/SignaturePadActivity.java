package com.example.signaturepad;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;

import java.io.ByteArrayOutputStream;

public class SignaturePadActivity extends Activity {

    SignatureView signatureView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FrameLayout layout = new FrameLayout(this);
        layout.setBackgroundColor(Color.WHITE);

        signatureView = new SignatureView(this);
        FrameLayout.LayoutParams canvasParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
        );
        signatureView.setLayoutParams(canvasParams);
        layout.addView(signatureView);

        Button saveBtn = new Button(this);
        saveBtn.setText("Capture");
        saveBtn.setBackgroundColor(Color.parseColor("#4CAF50"));
        saveBtn.setTextColor(Color.WHITE);
        FrameLayout.LayoutParams btnParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
        );
        btnParams.topMargin = 50;
        btnParams.leftMargin = 50;
        saveBtn.setLayoutParams(btnParams);
        saveBtn.setOnClickListener(v -> {
            Bitmap bmp = signatureView.getSignatureBitmap();
            String base64 = bitmapToBase64(bmp);
            getIntent().putExtra("signature", base64);
            setResult(RESULT_OK, getIntent());
            finish();
        });
        layout.addView(saveBtn);

        Button cancelBtn = new Button(this);
        cancelBtn.setText("Cancel");
        cancelBtn.setBackgroundColor(Color.RED);
        cancelBtn.setTextColor(Color.WHITE);
        FrameLayout.LayoutParams cancelParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT
        );
        cancelParams.topMargin = 50;
        cancelParams.rightMargin = 50;
        cancelParams.gravity = android.view.Gravity.END;
        cancelBtn.setLayoutParams(cancelParams);
        cancelBtn.setOnClickListener(v -> {
            setResult(RESULT_CANCELED);
            finish();
        });
        layout.addView(cancelBtn);

        setContentView(layout);
    }

    private String bitmapToBase64(Bitmap bmp) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        return Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP);
    }
}
