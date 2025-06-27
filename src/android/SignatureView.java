package com.example.signaturepad;

import android.content.Context;
import android.graphics.*;
import android.view.MotionEvent;
import android.view.View;

public class SignatureView extends View {

    private Path path = new Path();
    private Paint paint = new Paint();
    private Bitmap bitmap;
    private Canvas canvas;

    public SignatureView(Context context) {
        super(context);
        paint.setAntiAlias(true);
        paint.setColor(Color.BLACK);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeJoin(Paint.Join.ROUND);
        paint.setStrokeWidth(5f);
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        canvas = new Canvas(bitmap);
        canvas.drawColor(Color.WHITE); // white background
    }

    @Override
    protected void onDraw(Canvas c) {
        c.drawBitmap(bitmap, 0, 0, null);
        c.drawPath(path, paint);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        float x = event.getX(), y = event.getY();
        if (x < 0 || y < 0 || x > getWidth() || y > getHeight()) return false;

        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                path.moveTo(x, y);
                break;
            case MotionEvent.ACTION_MOVE:
                path.lineTo(x, y);
                break;
            case MotionEvent.ACTION_UP:
                canvas.drawPath(path, paint);
                path.reset();
                break;
        }
        invalidate();
        return true;
    }

    public Bitmap getSignatureBitmap() {
        return bitmap;
    }

    public void clear() {
        canvas.drawColor(Color.WHITE);
        invalidate();
    }
}
