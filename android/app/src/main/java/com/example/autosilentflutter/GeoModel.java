package com.example.autosilentflutter;

public class GeoModel {
    private double latitude, longitude;
    private String uuid;

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public GeoModel(double latitude, double longitude, String uuid) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.uuid = uuid;
    }
}
