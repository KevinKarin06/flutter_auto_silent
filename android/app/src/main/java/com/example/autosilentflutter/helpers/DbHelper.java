package com.example.autosilentflutter.helpers;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.example.autosilentflutter.GeoModel;

import java.util.ArrayList;
import java.util.List;

public class DbHelper {
    private static final String TAG = "DbHelper";
    private static DbHelper instance;
    //    private final String dbPath = PathUtils.getDataDirectory(context) + "/" + DATABASE_NAME;
    private final String dbPath = "/data/data/com.example.autosilentflutter/databases/geofeonce_database.db";
    private Context context;
    private SQLiteDatabase sqLiteDatabase;

    public DbHelper(Context context) {
        this.context = context;
    }

    private SQLiteDatabase init() {
        sqLiteDatabase = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.CREATE_IF_NECESSARY);
        return sqLiteDatabase;
    }

    public void close() {
        Log.d(TAG, "Close method called ");
        sqLiteDatabase.close();
    }

    public void syncGeofences() {
        List<GeoModel> modelList = new ArrayList<GeoModel>();
        new Thread(new Runnable() {
            @Override
            public void run() {
                Cursor cursor = init()
                        .query("geofeonce", null, null, null, null, null, null);
                while (cursor.moveToNext()) {
                    int latitude, longitude, uuid, delayTime, radius;
                    latitude = cursor.getColumnIndex("latitude");
                    longitude = cursor.getColumnIndex("longitude");
                    uuid = cursor.getColumnIndex("uuid");
                    delayTime = cursor.getColumnIndex("delayTime");
                    radius = cursor.getColumnIndex("radius");
                    GeoModel model = new GeoModel(cursor.getDouble(latitude), cursor.getDouble(longitude),
                            cursor.getString(uuid), cursor.getInt(delayTime),  (float) cursor.getInt(radius));
                    modelList.add(model);
                }
                GeofenceHelper geofenceHelper = new GeofenceHelper(context);
                for (GeoModel model : modelList) {
                    geofenceHelper.addGeofence(model);
                    Log.d(TAG, "list: " + " " + model.getUuid());
                }
                close();
            }
        }).start();
    }

    public void deleteTriggered(String uuid) {
        String[] selectionArgs = {uuid, "1"};
        String selection = "uuid = ? AND justOnce = ?";
        new Thread(new Runnable() {
            @Override
            public void run() {
                SQLiteDatabase db = init();
                int deleted = db.delete("geofeonce", selection, selectionArgs);
                close();
            }
        }).start();
    }

}
