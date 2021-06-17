package com.example.autosilentflutter.helpers;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;
import java.util.List;

import io.flutter.util.PathUtils;

public class DbHelper {
    private static final String TAG = "DbHelper";
    private Context context;
    private static final String DATABASE_NAME   = "geofeonce_database.db";
    private SQLiteDatabase sqLiteDatabase;
    private static DbHelper instance;
//    private final String dbPath = PathUtils.getDataDirectory(context) + "/" + DATABASE_NAME;
   private final String dbPath = "/data/data/com.example.autosilentflutter/databases/geofeonce_database.db";

    public DbHelper(Context context) {
        this.context = context;
    }
    private  SQLiteDatabase init() {
        sqLiteDatabase = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.CREATE_IF_NECESSARY);
        return sqLiteDatabase;
    }
    public void close(){
        sqLiteDatabase.close();
    }
//    public static synchronized DbHelper getInstance(){
//        if(instance == null) {
//            instance = SQLiteDatabase.openDatabase(dbPath,null,SQLiteDatabase.CREATE_IF_NECESSARY);
//        }
//        return instance;
//    }

    public void getAll(){
        new Thread(new Runnable() {
            @Override
            public void run() {
                Cursor cursor = init()
                        .query("geofeonce",null,null,null,null,null,null);
                while (cursor.moveToNext()){
                   String[] columns = cursor.getColumnNames();
                    for (int i = 0; i < columns.length; i++) {
                        int latitude,longitude;
                        latitude = cursor.getColumnIndex("latitude");
                        longitude = cursor.getColumnIndex("longitude");
                        Log.d(TAG, "run: " + " " + cursor.getDouble(latitude));
                        Log.d(TAG, "run: " + " " + cursor.getDouble(longitude));
                    }
                }
            }
        }).start();
    }

}
