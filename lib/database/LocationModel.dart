import 'package:autosilentflutter/Constants.dart';
import 'package:autosilentflutter/Utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_photon/flutter_photon.dart';

// ignore: must_be_immutable
class LocationModel extends Equatable {
  final double latitude, longitude;
  String title, subtitle, uuid;
  final int id;
  int radius;
  bool justOnce;

  LocationModel({
    this.justOnce = false,
    this.radius = Constants.GEOFENCE_RADIUS,
    this.id,
    this.latitude,
    this.longitude,
    this.title,
    this.subtitle,
    this.uuid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
      'subtitle': subtitle,
      'uuid': uuid,
      'radius': radius,
      'justOnce': justOnce == true ? 1 : 0,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        latitude: json['geometry']['coordinates'][0],
        longitude: json['geometry']['coordinates'][1],
        title: json['properties']['name'],
        subtitle:
            '${json['properties']['district'] ??= 'Unknown Road'}, ${json['properties']['state'] ??= 'Unknown State'}, ${json['properties']['country']}',
      );
  factory LocationModel.fromJson2(dynamic json) {
    return LocationModel(
        latitude: json['position']['lat'],
        longitude: json['position']['lon'],
        title: json['address']['municipality'] ??= 'Unknown Street',
        subtitle:
            '${json['address']['streetName'] ??= 'Unknown Road'}, ${json['address']['localName'] ??= 'Unknown State'}, ${json['address']['country']}',
        uuid: Utils.generateuuid());
  }
  factory LocationModel.fromMap(Map map) {
    return LocationModel(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      subtitle: map['subtitle'],
      title: map['title'],
      uuid: map['uuid'],
      radius: map['radius'] == null ? 500 : map['radius'],
      justOnce: map['justOnce'] == 1 ? true : false,
    );
  }
  factory LocationModel.clone(LocationModel model) {
    return LocationModel(
      id: model.id,
      title: model.title,
      subtitle: model.subtitle,
      latitude: model.latitude,
      longitude: model.longitude,
      uuid: model.uuid,
      justOnce: model.justOnce,
      radius: model.radius,
    );
  }
  factory LocationModel.fromPhoton(PhotonFeature photon) {
    String street = photon.street;
    street ??= 'Unknown Street';
    String state = photon.state;
    state ??= 'Unknown State';
    String city = photon.city;
    city ??= 'Unknown City';
    String country = photon.country;
    state ??= 'Unknown Country';
    return LocationModel(
        title: photon.name,
        subtitle: '$street, $state, $city, $country',
        latitude: photon.coordinates.latitude,
        longitude: photon.coordinates.longitude,
        uuid: Utils.generateuuid());
  }

  @override
  List<Object> get props => [
        justOnce,
        radius,
        latitude,
        longitude,
        title,
        subtitle,
        uuid,
      ];
}
