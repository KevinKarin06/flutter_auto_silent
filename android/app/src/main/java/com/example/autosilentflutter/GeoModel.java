package com.example.autosilentflutter;

public class GeoModel {
    private double latitude, longitude;
    private String uuid;
    private  int delayTime;
    private float radius;

    public GeoModel(double latitude, double longitude, String uuid, int delayTime, float radius) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.uuid = uuid;
        this.delayTime = delayTime;
        this.radius = radius;
    }

    public float getRadius() {
        return radius;
    }

    public void setRadius(float radius) {
        this.radius = radius;
    }

    public int getDelayTime() {
        return delayTime;
    }

    public void setDelayTime(int delayTime) {
        this.delayTime = delayTime;
    }

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

}
