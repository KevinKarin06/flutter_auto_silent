package com.example.autosilentflutter.helpers;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.widget.Toast;

import com.example.autosilentflutter.GeoModel;
import com.example.autosilentflutter.receivers.GeofenceBroadcastReceiver;
import com.google.android.gms.location.Geofence;
import com.google.android.gms.location.GeofencingClient;
import com.google.android.gms.location.GeofencingRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel;

public class GeofenceHelper {

    private final GeofencingClient geofencingClient;
    private final PermissionHelper permissionHelper;
    Context context;
    private PendingIntent goefencePendingIntent;
    private float GEOFENCE_RADIUS = 500;
    private NotificationHelper notificationHelper;

    public GeofenceHelper(Context context) {
        this.context = context;
        geofencingClient = LocationServices.getGeofencingClient(context);
        permissionHelper = new PermissionHelper(context);
        notificationHelper = new NotificationHelper(context);

    }
    public GeofencingClient getGeofencingClient() {
        return geofencingClient;
    }

    private Geofence getGeofence(GeoModel model) {
        return new Geofence.Builder()
                .setRequestId(model.getUuid())
                .setCircularRegion(model.getLatitude(), model.getLongitude(), GEOFENCE_RADIUS)
                .setExpirationDuration(Geofence.NEVER_EXPIRE)
                .setTransitionTypes(Geofence.GEOFENCE_TRANSITION_ENTER | Geofence.GEOFENCE_TRANSITION_EXIT)
                .build();

    }

    public GeofencingRequest getGeofencingRequest(GeoModel model) {
        GeofencingRequest.Builder geofenceRequest = new GeofencingRequest.Builder();
        geofenceRequest.setInitialTrigger(GeofencingRequest.INITIAL_TRIGGER_ENTER);
        geofenceRequest.addGeofence(getGeofence(model));
        return geofenceRequest.build();
    }

    public PendingIntent getGeofencePendingIntent() {
        if (goefencePendingIntent != null) {
            return goefencePendingIntent;
        }
        Intent intent = new Intent(context, GeofenceBroadcastReceiver.class);
        goefencePendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        return goefencePendingIntent;
    }

    public void addGeofence(GeoModel model) {
        if (permissionHelper.checkPermissions()) {
            geofencingClient.addGeofences(getGeofencingRequest(model), getGeofencePendingIntent())
                    .addOnSuccessListener(new OnSuccessListener<Void>() {
                        @Override
                        public void onSuccess(Void aVoid) {
//                            Toast.makeText(context, "added successfully",
//                                    Toast.LENGTH_SHORT).show();
                            notificationHelper.showNotification("AddGeofence Event","Added Succeeded",null);

                        }
                    })
                    .addOnFailureListener(new OnFailureListener() {
                        @Override
                        public void onFailure(@NonNull Exception e) {
//                            Toast.makeText(context, "failed to add geofence" + e.getMessage(),
//                                    Toast.LENGTH_SHORT).show();
                            notificationHelper.showNotification("AddGeofence Event","Add Geofence Failed",null);
                        }
                    });
        } else {
            permissionHelper.requestLocationPermissions();
        }

    }

    public void removeGeoFence() {
        geofencingClient.removeGeofences(getGeofencePendingIntent())
                .addOnSuccessListener(new OnSuccessListener<Void>() {
                    @Override
                    public void onSuccess(Void aVoid) {
                        Toast.makeText(context, "removed", Toast.LENGTH_SHORT).show();
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        Toast.makeText(context, e.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
