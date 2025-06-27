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
        bitmap = Bitmap.createBitmap(w, w, Bitmap.Config.ARGB_8888); // Square canvas
        canvas = new Canvas(bitmap);
    }

    @Override
    protected void onDraw(Canvas c) {
        c.drawBitmap(bitmap, 0, 0, paint);
        c.drawPath(path, paint);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        float x = event.getX(), y = event.getY();

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
}
