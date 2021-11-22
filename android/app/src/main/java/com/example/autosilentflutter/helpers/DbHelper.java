package com.example.autosilentflutter.helpers;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.List;
import java.util.ArrayList;

import com.example.autosilentflutter.GeoModel;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.util.PathUtils;

public class DbHelper {
    private static final String TAG = "DbHelper";
    private Context context;
    private static final String DATABASE_NAME = "geofeonce_database.db";
    private SQLiteDatabase sqLiteDatabase;
    private static DbHelper instance;
    //    private final String dbPath = PathUtils.getDataDirectory(context) + "/" + DATABASE_NAME;
    private final String dbPath = "/data/data/com.example.autosilentflutter/databases/geofeonce_database.db";

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
//    public static synchronized DbHelper getInstance(){
//        if(instance == null) {
//            instance = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.CREATE_IF_NECESSARY);
//        }
//        return instance;
//    }

    public void syncGeofences() {
        List<GeoModel> modelList = new ArrayList<GeoModel>();
        new Thread(new Runnable() {
            @Override
            public void run() {
                Cursor cursor = init()
                        .query("geofeonce", null, null, null, null, null, null);
                while (cursor.moveToNext()) {
                    int latitude, longitude, uuid;
                    latitude = cursor.getColumnIndex("latitude");
                    longitude = cursor.getColumnIndex("longitude");
                    uuid = cursor.getColumnIndex("uuid");
                    GeoModel model = new GeoModel(cursor.getDouble(latitude), cursor.getDouble(longitude), cursor.getString(uuid));
                    modelList.add(model);
                }
                GeofenceHelper geofenceHelper = new GeofenceHelper(context, new MethodChannel.Result() {
                    @Override
                    public void success(@Nullable Object result) {

                    }

                    @Override
                    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {

                    }

                    @Override
                    public void notImplemented() {

                    }
                });
                for (GeoModel model : modelList) {
                    geofenceHelper.addGeofence(model);
                    Log.d(TAG, "list: " + " " + model.getUuid());
                }
                close();
            }
        }).start();
    }

}
