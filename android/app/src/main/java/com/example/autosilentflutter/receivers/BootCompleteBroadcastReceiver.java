package com.example.autosilentflutter.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.example.autosilentflutter.helpers.DbHelper;

import com.example.autosilentflutter.helpers.NotificationHelper;

public class BootCompleteBroadcastReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        NotificationHelper notificationHelper = new NotificationHelper(context);
        DbHelper databaseHelper = new DbHelper(context);
        String action = intent.getAction();
        if (action != null) {
            if (action.equals(Intent.ACTION_BOOT_COMPLETED)) {
//                notificationHelper.showNotification("BootComplete Event","Reboot Completed",null);
                  databaseHelper.syncGeofences();
            }
        }
    }
}