package com.example.signaturepad;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Base64;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.io.ByteArrayOutputStream;

public class SignaturePadActivity extends Activity {
    private SignatureView signatureView;
    private EditText nameInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        RelativeLayout rootLayout = new RelativeLayout(this);
        rootLayout.setBackgroundColor(Color.parseColor("#2d2d2d"));

        FrameLayout.LayoutParams rootParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT);
        rootLayout.setLayoutParams(rootParams);

        // Cancel Button
        TextView cancelBtn = new TextView(this);
        cancelBtn.setText("\u274C"); // ❌
        cancelBtn.setTextSize(24);
        cancelBtn.setTextColor(Color.WHITE);
        cancelBtn.setBackgroundColor(Color.TRANSPARENT);
        cancelBtn.setPadding(25, 25, 25, 25);
        cancelBtn.setOnClickListener(v -> cancel());

        RelativeLayout.LayoutParams cancelParams = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);
        cancelParams.addRule(RelativeLayout.ALIGN_PARENT_START);
        cancelParams.setMargins(25, 25, 0, 0);
        cancelBtn.setLayoutParams(cancelParams);
        rootLayout.addView(cancelBtn);

        // Center area
        LinearLayout container = new LinearLayout(this);
        container.setOrientation(LinearLayout.VERTICAL);
        container.setGravity(Gravity.CENTER_HORIZONTAL);

        RelativeLayout.LayoutParams containerParams = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);
        containerParams.addRule(RelativeLayout.CENTER_IN_PARENT);
        container.setLayoutParams(containerParams);

        // Signature View
        signatureView = new SignatureView(this);
        signatureView.setBackgroundColor(Color.WHITE);
        int size = (int)(getResources().getDisplayMetrics().widthPixels * 0.9);
        LinearLayout.LayoutParams signatureParams = new LinearLayout.LayoutParams(size, size);
        signatureParams.setMargins(0, 20, 0, 20);
        signatureView.setLayoutParams(signatureParams);

        // Trash Button
        ImageButton trashBtn = new ImageButton(this);
        trashBtn.setImageResource(android.R.drawable.ic_menu_delete);
        trashBtn.setBackgroundColor(Color.parseColor("#da116d"));
        trashBtn.setColorFilter(Color.WHITE);
        trashBtn.setPadding(20, 20, 20, 20);
        trashBtn.setScaleType(ImageButton.ScaleType.CENTER_INSIDE);
        trashBtn.setOnClickListener(v -> signatureView.clear());
        trashBtn.setBackground(getResources().getDrawable(android.R.drawable.btn_default));
        trashBtn.setBackgroundColor(Color.parseColor("#da116d"));
        trashBtn.setClipToOutline(true);
        trashBtn.setElevation(4);

        LinearLayout.LayoutParams trashParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        trashParams.gravity = Gravity.START;
        trashParams.setMargins(20, -100, 0, 20);
        trashBtn.setLayoutParams(trashParams);

        // Add signatureView and trash
        FrameLayout signatureWrapper = new FrameLayout(this);
        signatureWrapper.addView(signatureView);
        signatureWrapper.addView(trashBtn);
        container.addView(signatureWrapper);

        // Name input (conditionally)
        nameInput = new EditText(this);
        nameInput.setHint("Full Name");
        nameInput.setTextColor(Color.BLACK);
        nameInput.setBackgroundColor(Color.WHITE);
        nameInput.setPadding(20, 20, 20, 20);
        LinearLayout.LayoutParams nameParams = new LinearLayout.LayoutParams(
                size, LinearLayout.LayoutParams.WRAP_CONTENT);
        nameParams.setMargins(0, 10, 0, 10);
        nameInput.setLayoutParams(nameParams);

        if ("true".equals(getIntent().getStringExtra("withName"))) {
            container.addView(nameInput);
        }

        // Submit button
        Button submitBtn = new Button(this);
        submitBtn.setText("\u2714"); // ✔
        submitBtn.setTextSize(22);
        submitBtn.setTextColor(Color.WHITE);
        submitBtn.setBackgroundColor(Color.parseColor("#da116d"));
        submitBtn.setPadding(20, 20, 20, 20);
        submitBtn.setLayoutParams(nameParams); // Same width as input
        submitBtn.setOnClickListener(v -> submit());

        container.addView(submitBtn);
        rootLayout.addView(container);
        setContentView(rootLayout);
    }

    private void submit() {
        Bitmap signatureBitmap = signatureView.getSignatureBitmap();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        signatureBitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        String base64 = Base64.encodeToString(outputStream.toByteArray(), Base64.NO_WRAP);

        String name = (nameInput != null) ? nameInput.getText().toString() : "";
        String result = "{\"signature\":\"data:image/png;base64," + base64 + "\",\"name\":\"" + name + "\"}";

        Intent data = new Intent();
        data.putExtra("signature", result);
        setResult(RESULT_OK, data);
        finish();
    }

    private void cancel() {
        setResult(RESULT_CANCELED);
        finish();
    }
}
