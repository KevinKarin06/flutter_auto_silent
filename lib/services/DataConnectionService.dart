import 'package:data_connection_checker/data_connection_checker.dart';

class DataConnectionService {
  Future<bool> internetAvalaible() async {
    return await DataConnectionChecker().hasConnection;
  }
}
