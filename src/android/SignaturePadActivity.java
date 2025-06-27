package com.example.signaturepad;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Color;
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
        root.setGravity(Gravity.CENTER_HORIZONTAL);
        root.setPadding(20, 20, 20, 20);

        FrameLayout canvasHolder = new FrameLayout(this);
        int canvasSize = (int)(getResources().getDisplayMetrics().widthPixels * 0.9);

        signatureView = new SignatureView(this);
        FrameLayout.LayoutParams canvasParams = new FrameLayout.LayoutParams(canvasSize, canvasSize);
        signatureView.setLayoutParams(canvasParams);
        canvasHolder.addView(signatureView);

        // Trash button (🗑)
        Button trash = new Button(this);
        trash.setText("🗑");
        trash.setBackgroundColor(Color.parseColor("#da116d"));
        trash.setTextColor(Color.WHITE);
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
            nameInput.setBackgroundColor(Color.parseColor("#444444"));
            nameInput.setTextColor(Color.WHITE);
            nameInput.setPadding(20, 10, 20, 10);
            LinearLayout.LayoutParams nameParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            nameParams.setMargins(0, 30, 0, 10);
            root.addView(nameInput, nameParams);
        }

        // Capture button (✔)
        Button capture = new Button(this);
        capture.setText("✔");
        capture.setTextColor(Color.WHITE);
        capture.setBackgroundColor(Color.parseColor("#da116d"));
        LinearLayout.LayoutParams btnParams = new LinearLayout.LayoutParams(
            (int)(getResources().getDisplayMetrics().widthPixels * 0.9),
            LinearLayout.LayoutParams.WRAP_CONTENT);
        btnParams.setMargins(0, 30, 0, 0);
        capture.setLayoutParams(btnParams);

        capture.setOnClickListener(v -> {
            Bitmap bmp = signatureView.getSignatureBitmap();
            String base64 = bitmapToBase64(bmp);
            String name = showNameInput && nameInput != null ? nameInput.getText().toString() : "";
            String combined = "{\"signature\":\"" + base64 + "\",\"name\":\"" + name + "\"}";
            getIntent().putExtra("signature", combined);
            setResult(RESULT_OK, getIntent());
            finish();
        });

        root.addView(capture);
        setContentView(root);
    }

    private String bitmapToBase64(Bitmap bmp) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        return Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP);
    }
}
