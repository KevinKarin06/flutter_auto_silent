class Constants {
  static const String CHANNEL_NAME = 'app.geofeonce.channel';
  static const String TABLE_NAME = 'geofeonce';
  static const String DATABASE_NAME = 'geofeonce_database.db';
  static const String MAP_BOX_API =
      'pk.eyJ1Ijoia2V2aW5rYWluIiwiYSI6ImNrcHA3azJqejR2bzAzMW54M3BmaG5vZDYifQ.8J1jJ6cB1nBqCtOq01dB9w';
  static const int ANDROID_10 = 29;
  static const int ANDROID_NOUGAT = 24;
  static const String APP_NAME = 'Auto Silent';
  static const String DC_CORP = 'Powered By Dc Corp';
  static const String SETTINGS_DB = 'auto_silent';
  static const int GEOFENCE_RADIUS = 500;
  static const double BORDER_RADIUS = 4.0;
  static const int MILLI_SECONDS = 60000;
  //
  static const String NOTIFY_ON_ENTRY = 'notify_on_entry';
  static const String NOTIFY_ON_EXIT = 'notify_on_exit';
  //
  static const Map<String, int> GEO_RADIUS = {
    '200meters': 200,
    '300meters': 300,
    '400meters': 400,
    '500meters': 500,
    '600meters': 600,
    '700meters': 700,
    '800meters': 800,
    '900meters': 900,
    '1000meters': 1000,
  };
  //
  static const Map<String, int> GEO_DELAY_TIME = {
    '0minutes': 1 * MILLI_SECONDS,
    '10minutes': 10 * MILLI_SECONDS,
    '20minutes': 20 * MILLI_SECONDS,
    '30minutes': 30 * MILLI_SECONDS,
    '40minutes': 40 * MILLI_SECONDS,
    '50minutes': 50 * MILLI_SECONDS,
    '60minutes': 60 * MILLI_SECONDS,
  };
}
