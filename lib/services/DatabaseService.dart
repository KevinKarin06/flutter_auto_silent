import 'package:autosilentflutter/Constants.dart';
import 'package:autosilentflutter/database/Database.dart';
import 'package:autosilentflutter/database/LocationModel.dart';

class DatabaseService {
  Future<int> createLocation(LocationModel model) async {
    final database = await LocationDatabase().getDatabase();
    print(model.toMap());
    return await database.insert(Constants.TABLE_NAME, model.toMap());
  }

  Future<int> deleteLocation(int id) async {
    final database = await LocationDatabase().getDatabase();
    return await database.delete(
      Constants.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateLocation(LocationModel model) async {
    final database = await LocationDatabase().getDatabase();
    return await database.update(
      Constants.TABLE_NAME,
      model.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [model.id],
    );
  }

  Future<List<LocationModel>> getLocations() async {
    final database = await LocationDatabase().getDatabase();
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await database.query(Constants.TABLE_NAME);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return LocationModel.fromMap(maps[i]);
    });
  }

  Future<LocationModel> getLocation(int id) async {
    final database = await LocationDatabase().getDatabase();
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await database.query(
      Constants.TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? LocationModel.fromMap(maps.first) : -1;
  }
}
