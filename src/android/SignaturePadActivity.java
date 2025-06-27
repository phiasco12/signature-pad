package com.example.signaturepad;

import android.app.Activity;
import android.graphics.*;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.util.Base64;
import android.view.Gravity;
import android.view.View;
import android.widget.*;

import java.io.ByteArrayOutputStream;

public class SignaturePadActivity extends Activity {

    SignatureView signatureView;
    EditText nameInput;
    boolean showNameInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        showNameInput = getIntent().getBooleanExtra("showNameField", false);

        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setBackgroundColor(Color.parseColor("#2d2d2d"));
        root.setPadding(20, 80, 20, 20); // top padding
        root.setGravity(Gravity.CENTER_HORIZONTAL);

        // Cancel ❌
        Button cancelBtn = new Button(this);
        cancelBtn.setText("❌");
        cancelBtn.setBackgroundColor(Color.TRANSPARENT);
        cancelBtn.setTextColor(Color.WHITE);
        cancelBtn.setTextSize(20);
        cancelBtn.setAllCaps(false);
        cancelBtn.setPadding(0, 0, 0, 0);
        cancelBtn.setGravity(Gravity.START);
        LinearLayout.LayoutParams cancelParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        );
        cancelParams.gravity = Gravity.START;
        cancelParams.setMargins(0, -60, 0, 20);
        root.addView(cancelBtn, cancelParams);
        cancelBtn.setOnClickListener(v -> {
            setResult(RESULT_CANCELED);
            finish();
        });

        // Signature Pad
        FrameLayout canvasHolder = new FrameLayout(this);
        int canvasSize = (int)(getResources().getDisplayMetrics().widthPixels * 0.9);

        signatureView = new SignatureView(this);
        FrameLayout.LayoutParams canvasParams = new FrameLayout.LayoutParams(canvasSize, canvasSize);
        signatureView.setLayoutParams(canvasParams);
        canvasHolder.addView(signatureView);

        // Trash button 🗑
        Button trash = new Button(this);
        trash.setText("🗑");
        trash.setTextColor(Color.WHITE);
        trash.setBackground(makeRoundedDrawable("#da116d"));
        FrameLayout.LayoutParams trashParams = new FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        trashParams.gravity = Gravity.BOTTOM | Gravity.START;
        trashParams.setMargins(30, 30, 30, 30);
        trash.setLayoutParams(trashParams);
        trash.setOnClickListener(v -> signatureView.clear());
        canvasHolder.addView(trash);

        root.addView(canvasHolder);

        if (showNameInput) {
            nameInput = new EditText(this);
            nameInput.setHint("Full Name");
            nameInput.setBackgroundColor(Color.WHITE);
            nameInput.setTextColor(Color.BLACK);
            nameInput.setTextSize(16);
            LinearLayout.LayoutParams nameParams = new LinearLayout.LayoutParams(
                canvasSize, LinearLayout.LayoutParams.WRAP_CONTENT);
            nameParams.setMargins(0, 30, 0, 10);
            root.addView(nameInput, nameParams);
        }

        // Capture ✔
        Button capture = new Button(this);
        capture.setText("✔");
        capture.setTextColor(Color.WHITE);
        capture.setTextSize(20);
        capture.setBackground(makeRoundedDrawable("#da116d"));
        LinearLayout.LayoutParams btnParams = new LinearLayout.LayoutParams(
            canvasSize, LinearLayout.LayoutParams.WRAP_CONTENT);
        btnParams.setMargins(0, 30, 0, 0);
        root.addView(capture, btnParams);

        capture.setOnClickListener(v -> {
            Bitmap bmp = signatureView.getSignatureBitmap();
            String base64 = bitmapToBase64(bmp);
            String name = showNameInput && nameInput != null ? nameInput.getText().toString() : "";
            String combined = "{\"signature\":\"" + base64 + "\",\"name\":\"" + name + "\"}";
            getIntent().putExtra("signature", combined);
            setResult(RESULT_OK, getIntent());
            finish();
        });

        setContentView(root);
    }

    private String bitmapToBase64(Bitmap bmp) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        return Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP);
    }

    private GradientDrawable makeRoundedDrawable(String colorHex) {
        GradientDrawable drawable = new GradientDrawable();
        drawable.setColor(Color.parseColor(colorHex));
        drawable.setCornerRadius(5 * getResources().getDisplayMetrics().density);
        return drawable;
    }
}
