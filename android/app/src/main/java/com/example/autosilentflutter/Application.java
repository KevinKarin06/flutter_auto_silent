package com.example.autosilentflutter;

import android.os.Bundle;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.geofencing.GeofencingService;

public class Application extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeofencingService.setPluginRegistrant((PluginRegistry.PluginRegistrantCallback) this);
    }
}
