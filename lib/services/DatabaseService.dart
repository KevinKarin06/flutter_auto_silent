import 'package:autosilentflutter/constants/constants.dart';
import 'package:autosilentflutter/constants/errors.dart';
import 'package:autosilentflutter/database/Database.dart';
import 'package:autosilentflutter/database/LocationModel.dart';

class DatabaseService {
  //
  Future<int> createLocation(LocationModel model) async {
    try {
      final database = await LocationDatabase().getDatabase();
      return await database.insert(Constants.TABLE_NAME, model.toMap());
    } catch (e) {
      return Future.error(AppError.DB_ADD_FAILED);
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
      return Future.error(AppError.DB_DELETE_FAILED);
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
      return Future.error(AppError.DB_UPDATE_FAILED);
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
        return LocationModel.fromMap(maps[i]);
      });
    } catch (e) {
      return Future.error(AppError.DB_LOAD_FAILED);
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
      return Future.error(AppError.DB_GET_FAILED);
    }
  }
}
