package com.example.autosilentflutter.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.provider.Settings;
import android.util.Log;

import com.example.autosilentflutter.Constants;
import com.example.autosilentflutter.Utils;
import com.example.autosilentflutter.helpers.NotificationHelper;
import com.example.autosilentflutter.helpers.PermissionHelper;
import com.google.android.gms.location.Geofence;
import com.google.android.gms.location.GeofenceStatusCodes;
import com.google.android.gms.location.GeofencingEvent;

import java.util.List;

public class GeofenceBroadcastReceiver extends BroadcastReceiver {
    private static final String TAG = "GeofenceBroadcastReceiv";

    @Override
    public void onReceive(Context context, Intent intent) {
        NotificationHelper notificationHelper = new NotificationHelper(context);
        Utils utils = new Utils(context);
        GeofencingEvent geofencingEvent = GeofencingEvent.fromIntent(intent);
        PermissionHelper permissionHelper = new PermissionHelper(context);
        SharedPreferences sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
        Intent notificationIntent = new Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS);
        if (geofencingEvent.hasError()) {
            String errorMessage = GeofenceStatusCodes.getStatusCodeString(geofencingEvent.getErrorCode());
            notificationHelper.showNotification("Geofence Error", errorMessage, null);
            Log.d(TAG, "onReceive: " + errorMessage);
        } else {
            int transition = geofencingEvent.getGeofenceTransition();
            List<Geofence> triggeringGeofences = geofencingEvent.getTriggeringGeofences();
            String geofenceId = "";
            if (triggeringGeofences.size() > 0) {
                Geofence geofence = triggeringGeofences.get(0);
                geofenceId = geofence.getRequestId();
            }
            if (transition == Geofence.GEOFENCE_TRANSITION_ENTER) {
                if (permissionHelper.checkMutePermission()) {
                    Log.d(TAG, "onReceive: GEO_ENTER");
                    utils.muteDevice();
                    if (sharedPreferences.getBoolean(Constants.NOTIFY_ON_ENTRY, true)) {
                        notificationHelper.showNotification("Geofence Event" + geofenceId, "TRANSITION_ENTER_TRUE", null);
                    } else {
                        notificationHelper.showNotification("Geofence Event" + geofenceId, "TRANSITION_ENTER_FALSE", null);
                    }
                } else {
                    Log.d(TAG, "onReceive: NO PERM");
                    notificationHelper.showNotification("Action Required", "You need to grant permission", notificationIntent);
                }
            } else if (transition == Geofence.GEOFENCE_TRANSITION_EXIT) {
                if (permissionHelper.checkMutePermission()) {
                    utils.unMuteDevice();
                    notificationHelper.showNotification("Geofence Event" + geofenceId, "TRANSITION_EXIT", null);
                } else {
                    notificationHelper.showNotification("Action Required", "You need to grant permission", notificationIntent);
                }
            }
        }
    }
}