package com.example.autosilentflutter.helpers;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;


import com.example.autosilentflutter.MainActivity;
import com.example.autosilentflutter.R;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
public class NotificationHelper {
    private final String NOTIFICATION_ID = "auto_silent";
    Context context = null;
    public NotificationHelper(Context context){
        this.context = context;
    }

    public void showNotification(String title, String text, @Nullable Intent intent){
        createNotificationChannel();
        if(intent == null){
            intent = new Intent(context, MainActivity.class);
        }
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        PendingIntent pendingIntent = PendingIntent.getActivity(context,0,intent,0);
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context,NOTIFICATION_ID)
                .setSmallIcon(R.drawable.common_google_signin_btn_icon_dark)
                .setContentTitle(title)
                .setContentText(text)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .setContentIntent(pendingIntent)
                .setAutoCancel(true);
        NotificationManagerCompat notificationManagerCompat = NotificationManagerCompat.from(context);
        notificationManagerCompat.notify(2,builder.build());
    }
    private void createNotificationChannel(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            int importance = NotificationManager.IMPORTANCE_DEFAULT;
            String CHANNEL_NAME = "geofence";
            NotificationChannel channel = new NotificationChannel(NOTIFICATION_ID, CHANNEL_NAME,importance);
            String notificationDescription = "Goefence Notification";
            channel.setDescription(notificationDescription);
            NotificationManager manager = context.getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }
    }
}
