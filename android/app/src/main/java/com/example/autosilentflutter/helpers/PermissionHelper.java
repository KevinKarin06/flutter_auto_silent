package com.example.autosilentflutter.helpers;

import android.Manifest;
import android.app.Activity;
//import androidx.appcompat.app.AlertDialog;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.provider.Settings;

import java.util.function.Function;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
public class PermissionHelper {
    Context context;
    Activity activity;
    NotificationManager notificationManager;
    final private int LOCATION_REQUEST_CODE = 200;
    final private int NOTIFICATION_REQUEST_CODE = 201;
    public PermissionHelper(Context context){
        this.context = context;
        if(context instanceof Activity){
            activity = (Activity) context;
        }
        notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
    }

    public void requestLocationPermissions(){
        if(Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1){
            if(!checkPermissions()) {
                if(ActivityCompat.shouldShowRequestPermissionRationale(activity,Manifest.permission.ACCESS_FINE_LOCATION)){
                    //show dialog then request for permission
//                    buildDialog().show();
                }else{
                    request();
                }
            }
        }
    }
//    private AlertDialog buildDialog(){
//        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
//        builder.setTitle("Action Required");
//        builder.setCancelable(true);
//        builder.setMessage("You will need to grant acess to donnot disturb for this app to work properly");
//        builder.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface dialogInterface, int i) {
//                dialogInterface.dismiss();
//                request();
//            }
//        });
//        builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface dialogInterface, int i) {
//                dialogInterface.dismiss();
//            }
//        });
//        AlertDialog dialog = builder.create();
//        return  dialog;
//    }
    private void request(){
        ActivityCompat.requestPermissions(activity,new String[]{Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION}, LOCATION_REQUEST_CODE);
    }
    public boolean checkPermissions(){
        return  (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED
                &&
                ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED );
    }
    public boolean checkMutePermission(){
        return notificationManager.isNotificationPolicyAccessGranted();
    }
    public void askMutePermission(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N){
            if(!checkMutePermission()){
//                AlertDialog.Builder builder = new AlertDialog.Builder(activity);
//                builder.setTitle("Action Required");
//                builder.setCancelable(true);
//                builder.setMessage("You will need to grant access to donnot disturb permission for this app to work properly");
//                builder.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialogInterface, int i) {
//                        dialogInterface.dismiss();
//                        Intent intent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
//                        activity.startActivityForResult(intent,NOTIFICATION_REQUEST_CODE);
//                    }
//                });
//                builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialogInterface, int i) {
//                        dialogInterface.dismiss();
//                    }
//                });
//                AlertDialog dialog = builder.create();
//                dialog.show();
            }
        }
    }}

