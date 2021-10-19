import 'package:geocoder/geocoder.dart';

class GeocoderService {
  Future<Address> getAdresseFromLatLon(double lat, double lon) async {
    final Coordinates coordinate = Coordinates(lat, lon);
    List<Address> adresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinate);
    return adresses.first;
  }
}
