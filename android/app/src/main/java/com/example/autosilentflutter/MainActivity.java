package com.example.autosilentflutter;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;

import com.example.autosilentflutter.helpers.DbHelper;
import com.example.autosilentflutter.helpers.GeofenceHelper;
import com.example.autosilentflutter.helpers.NotificationHelper;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;

import java.util.ArrayList;
import java.util.List;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "app.geofeonce.channel";
    private static final String TAG = "MainActivity";
    NotificationHelper notificationHelper = new NotificationHelper(this);


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_NAME)
                .setMethodCallHandler((call, result) -> {
                    GeofenceHelper geofenceHelper = new GeofenceHelper(getApplicationContext());
                    OnFailureListener onFailureListener = new OnFailureListener() {
                        @Override
                        public void onFailure(@NonNull Exception e) {
                            Log.d(TAG, "onSuccess: Failure");
                            result.error("-1","Failed",false);
                        }
                    };
                    OnSuccessListener onSuccessListener = new OnSuccessListener() {
                        @Override
                        public void onSuccess(Object o) {
                            Log.d(TAG, "onSuccess: Success");
                            result.success(true);
                        }
                    };
                    if (call.method.equals("addGeofence")) {
                        double latitude = call.argument("latitude");
                        double longitude = call.argument("longitude");
                        String uuid = call.argument("uuid");
                        GeoModel model = new GeoModel(latitude, longitude, uuid);
                        geofenceHelper.getGeofencingClient().addGeofences(geofenceHelper.getGeofencingRequest(model),
                                geofenceHelper.getGeofencePendingIntent())
                                .addOnSuccessListener(onSuccessListener)
                                .addOnFailureListener(onFailureListener);

                    } else if(call.method.equals("removeGeofence")) {
                        String id = call.argument("uuid");
                        List<String> list = new ArrayList<String>();
                        list.add(id);
                        Log.d(TAG, "configureFlutterEngine: "+list);
                       geofenceHelper.getGeofencingClient().removeGeofences(list)
                       .addOnSuccessListener(onSuccessListener)
                       .addOnFailureListener(onFailureListener);
                    } else if(call.method.equals("loaddb")){
                        new DbHelper(MainActivity.this).getAll();
                    }else{
                        result.notImplemented();
                    }
                });
    }

    public String hello() {
        return "hello from native";
    }

    public void init() {

    }




}
