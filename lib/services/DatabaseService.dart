import 'package:autosilentflutter/Constants.dart';
import 'package:autosilentflutter/database/Database.dart';
import 'package:autosilentflutter/database/LocationModel.dart';

class DatabaseService {
  //
  Future<int> createLocation(LocationModel model) async {
    try {
      final database = await LocationDatabase().getDatabase();
      return await database.insert(Constants.TABLE_NAME, model.toMap());
    } catch (e) {
      return Future.error('geofence_add_to_db_falied');
    }
  }

  Future<int> deleteLocation(int id) async {
    try {
      final database = await LocationDatabase().getDatabase();
      return await database.delete(
        Constants.TABLE_NAME,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      return Future.error('geofence_delete_to_db_falied');
    }
  }

  Future<int> updateLocation(LocationModel model) async {
    try {
      final database = await LocationDatabase().getDatabase();
      return await database.update(
        Constants.TABLE_NAME,
        model.toMap(),
        // Ensure that the LocationModel has a matching id.
        where: 'id = ?',
        // Pass the Model id as a whereArg to prevent SQL injection.
        whereArgs: [model.id],
      );
    } catch (e) {
      return Future.error('geofence_update_failes');
    }
  }

  Future<List<LocationModel>> getLocations() async {
    try {
      final database = await LocationDatabase().getDatabase();
      // Query the table for all Models
      final List<Map<String, dynamic>> maps =
          await database.query(Constants.TABLE_NAME, orderBy: 'id desc');

      // Convert the List<Map<String, dynamic> into a List<Locations>.
      return List.generate(maps.length, (i) {
        // Logger().d('Locations $i', maps[i]);
        return LocationModel.fromMap(maps[i]);
      });
    } catch (e) {
      return Future.error('geofence_load_from_db_falied');
    }
  }

  Future<LocationModel> getLocation(int id) async {
    try {
      final database = await LocationDatabase().getDatabase();
      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await database.query(
        Constants.TABLE_NAME,
        where: 'id = ?',
        whereArgs: [id],
      );
      return maps.isNotEmpty ? LocationModel.fromMap(maps.first) : -1;
    } catch (e) {
      return Future.error('geofence_get_from_db_falied');
    }
  }
}
