import 'package:geocoder/geocoder.dart';

class GeocoderHelper {
  Future<Address> getAdresseFromLatLon(double lat, double lon) async {
    final Coordinates coordinate = Coordinates(lat, lon);
    List<Address> adresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinate);
    print(adresses.first);
    return adresses.first;
  }
}
