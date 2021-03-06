import 'dart:convert';
import 'package:autosilentflutter/utils/Utils.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_photon/flutter_photon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  String _url = 'https://photon.komoot.io/api/?lang=en&q=';
  final String key = dotenv.env['PHOTON_KEY'];
  Future<List<LocationModel>> autoComplete(String query) async {
    print('Api Helper Function called');
    http.Client client = http.Client();
    _url += query.trim().toLowerCase();
    List<LocationModel> models = List.empty(growable: true);
    if (await Utils.isConnected()) {
      try {
        var response = await client.get(Uri.parse(_url));
        var parsed = json.decode(response.body);
        List<dynamic> list = parsed['features'];
        list.forEach((element) {
          LocationModel model = LocationModel.fromJson(element);
          models.add(model);
          print(model.toMap());
        });
      } catch (exception) {
        return Future.error(exception);
      }
    } else {
      return Future.error('No Internet Connection');
    }
    return models;
  }

  Future<List<LocationModel>> autoSuggest(String query) async {
    query = query.trim().toLowerCase();
    final String url =
        'https://api.tomtom.com/search/2/search/$query.json?key=$key&typeahead=true&limit=100';

    List<LocationModel> locations = List.empty(growable: true);
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map jResponse = jsonDecode(response.body);
        if (jResponse['summary']['numResults'] > 0) {
          for (var res in jResponse['results']) {
            LocationModel location = LocationModel.fromJson2(res);
            locations.add(location);
          }
        }
      }
    } catch (Exception) {
      return Future.error(Exception);
    }
    return locations;
  }

  Future<List<LocationModel>> photonSearch(String q) async {
    List<LocationModel> list = List.empty(growable: true);
    try {
      if (await DataConnectionChecker().hasConnection) {
        final PhotonApi api = PhotonApi();
        List<PhotonFeature> res = await api.forwardSearch(q);
        res.forEach((element) {
          list.add(LocationModel.fromPhoton(element));
        });
      } else {
        print('No Internet Conection');
        return Future.error('No Internet Connection');
      }
    } catch (e) {
      return Future.error(e);
    }
    return list;
  }
}
