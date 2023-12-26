import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// defining object
class Place {
  int id;
  double lat;
  double lon;
  bool found;
  DateTime dateRegistered; // string
  DateTime dateFound; // string
  double startingLat;
  double startingLon;
  String firebaseID;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.found,
    required this.dateRegistered,
    required this.dateFound,
    required this.startingLat,
    required this.startingLon,
    required this.firebaseID,
  });
}

// default way to get database
Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  // open the database
  Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      // version 2 - "PlacesV2"
      await db.execute(
        'CREATE TABLE PlacesV2 ('
            'id INTEGER PRIMARY KEY, '
            'lat REAL, '
            'lon REAL, '
            'found INTEGER, '
            'dateRegistered TEXT, '
            'dateFound TEXT, '
            'startingLat REAL, '
            'startingLon REAL, '
            'firebaseID TEXT)',
      );
    },
  );
  return database;
}

Future<List<Place>> getAllPlaces() async {
  Database db = await getDatabase();
  List<Map> placesRaw = await db.rawQuery('SELECT * FROM PlacesV2');
  await db.close();
  // mapping data
  List<Place> placesToReturn = [];
  for (Map l in placesRaw) {
    Place place = Place(
      id: l["id"],
      lat: l["lat"],
      lon: l["lon"],
      found: l["found"] == 1 ? true : false,
      dateRegistered: DateTime.parse(l["dateRegistered"]),
      dateFound: DateTime.parse(l["dateFound"]),
      startingLat: l["startingLat"],
      startingLon: l["startingLon"],
      firebaseID: l["firebaseID"],
    );
    placesToReturn.add(place);
  }
  return placesToReturn;
}

Future<int> addPlaceToDatabase(
    double lat, double lon, double startLat, double startLon, String firebaseID) async {
  // create command
  String executableString = 'INSERT INTO PlacesV2(lat, lon, found, '
      'dateRegistered, dateFound, startingLat, startingLon, firebaseID) '
      'VALUES($lat, $lon, 0, "${DateTime.now().toString()}", '
      '"${DateTime.now().toString()}", $startLat, $startLon, "$firebaseID")'; // should be now?
  // Insert some records in a transaction
  int id = -1;
  Database db = await getDatabase();
  await db.transaction((txn) async {
    id = await txn.rawInsert(executableString);
  });
  await db.close();
  return id;
}

Future<void> markAsFound(int id) async {
  Database db = await getDatabase();
  await db.rawUpdate(
      'UPDATE PlacesV2 SET found = ? WHERE id = ?',
      [1 , id]);
  await db.close();
}

Future<void> deletePlaceFromDatabase(int id) async {
  Database db = await getDatabase();
  await db.rawDelete("DELETE FROM PlacesV2 WHERE id = ?", [id]);
  await db.close();
}

Future<void> changeFirebaseID(int id, String newFirebaseID) async {
  Database db = await getDatabase();
  await db.rawUpdate(
      'UPDATE PlacesV2 SET firebaseID = ? WHERE id = ?',
      [newFirebaseID , id]);
  await db.close();
}