import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared_prefs_database.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocator.dart';

var db = FirebaseFirestore.instance;

class FirebaseDocument {
  String id;
  double lat;
  double lon;
  String name;
  String creatorID;
  DateTime dateCreated;
  // dateTime lastVisited ?
  int upVotes;
  int downVotes;
  bool isPublic;
  bool isEnlisted;

  FirebaseDocument({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.creatorID,
    required this.dateCreated,
    required this.upVotes,
    required this.downVotes,
    required this.isPublic,
    required this.isEnlisted,
  });
}

Future<FirebaseDocument> getOneFirebaseDocumentById(String id) async {
  final docRef = db.collection("public").doc(id);
  return await docRef.get().then((DocumentSnapshot doc) async {
      var v = (doc.data() as Map<String, dynamic>);

      return FirebaseDocument(
        id: id,
        lat: v["lat"],
        lon: v["lon"],
        name: v["name"],
        creatorID: v["creatorID"],
        dateCreated: DateTime.fromMillisecondsSinceEpoch((v["dateCreated"])),
        upVotes: v["upVotes"],
        downVotes: v["downVotes"],
        isPublic: v["isPublic"] == 1,
        isEnlisted: await isEnlisted(id),
      );
    },
    onError: (e) {
      return FirebaseDocument(
        id: "NaN",
        lat: 0,
        lon: 0,
        name: "error",
        creatorID: "",
        dateCreated: DateTime.now(),
        upVotes: 0,
        downVotes: 0,
        isPublic: false,
        isEnlisted: false,
      );
    }
  );
}

Future<List<FirebaseDocument>> getAllFirebaseDocuments(bool admin) async {
  List<FirebaseDocument> toReturn = [];
  var querySnapshot = await db.collection("public").get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> v = queryDocumentSnapshot.data();
    if ((v["isPublic"] == 1 && !admin) || (v["isPublic"] == 0 && admin)) {
      toReturn.add(FirebaseDocument(
        id: queryDocumentSnapshot.id,
        lat: v["lat"],
        lon: v["lon"],
        name: v["name"],
        creatorID: v["creatorID"],
        dateCreated: DateTime.fromMillisecondsSinceEpoch((v["dateCreated"])),
        upVotes: v["upVotes"],
        downVotes: v["downVotes"],
        isPublic: v["isPublic"] == 1,
        isEnlisted: await isEnlisted(queryDocumentSnapshot.id),
      ));
    }
  }
  Position p = await determinePosition();
  toReturn.sort((a, b) =>calculateDistance(p.latitude, p.longitude, a.lat, a.lon).compareTo(calculateDistance(p.latitude, p.longitude, b.lat, b.lon)));
  return toReturn;
}

Future<void> diffVotes(String id, int diff, String name) async {
  final docRef = db.collection("public").doc(id);
  int count = 0;
  await docRef.get().then((DocumentSnapshot doc) {
    var v = (doc.data() as Map<String, dynamic>);
    count = v[name];
  },
      onError: (e) {}
  );
  await docRef.update({name : (count + diff)});
}

Future<String> addDocToFirebase(name, lat, lon) async {
  FirebaseDocument fb = FirebaseDocument(
    id: "random",
    lat: lat,
    lon: lon,
    name: name,
    creatorID: "TODO",
    dateCreated: DateTime.now(),
    upVotes: 0,
    downVotes: 0,
    isPublic: false,
    isEnlisted: true,
  );
  final data = <String, dynamic>{
    "creatorID" : fb.creatorID,
    "dateCreated" : fb.dateCreated.millisecondsSinceEpoch,
    "downVotes" : fb.downVotes,
    "upVotes" : fb.upVotes,
    "name" : name,
    "lat" : lat,
    "lon" : lon,
    "isPublic" : 0,
  };
  return await db.collection("public").add(data).then((documentSnapshot) {
    return documentSnapshot.id;
  });
}

Future<void> setIsPublic(String id, int newValue) async {
  final docRef = db.collection("public").doc(id);
  await docRef.update({"isPublic" : newValue});
}