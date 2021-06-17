package com.example.autosilentflutter;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.AudioManager;
import android.os.Build;
import android.provider.Settings;

import com.example.autosilentflutter.helpers.NotificationHelper;


public class Utils {
    NotificationHelper notificationHelper;
    SharedPreferences sharedPreferences;
    AudioManager audioManager;
    NotificationManager notificationManager;
    Context context;
    public Utils(Context context) {
        this.context = context;
        notificationHelper = new NotificationHelper(context);
        sharedPreferences = context.getSharedPreferences("com.example.autosilentnative",Context.MODE_PRIVATE);
        audioManager = (AudioManager)context.getSystemService(Context.AUDIO_SERVICE);
        notificationManager = (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
    }

    public  void muteDevice(){
        saveCurrentMode();
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
            notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_NONE);
        }else{
            audioManager.setRingerMode(AudioManager.RINGER_MODE_SILENT);
        }
    }
    public  void unMuteDevice(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
            notificationManager.setInterruptionFilter(sharedPreferences.getInt("interrupt",NotificationManager.INTERRUPTION_FILTER_ALL));
        }else{
            audioManager.setRingerMode(sharedPreferences.getInt("ringerMode",AudioManager.RINGER_MODE_NORMAL));
        }
    }
    private void saveCurrentMode(){
        int ringerMode = audioManager.getRingerMode();
        int interrupt = notificationManager.getCurrentInterruptionFilter();
        sharedPreferences.edit().putInt("ringerMode",ringerMode).apply();
        sharedPreferences.edit().putInt("interrupt",interrupt).apply();
    }
}
