import 'package:cloud_firestore/cloud_firestore.dart';

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

  FirebaseDocument({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.creatorID,
    required this.dateCreated,
    required this.upVotes,
    required this.downVotes,
  });
}

Future<FirebaseDocument> getOneFirebaseDocumentById(String id) async {
  final docRef = db.collection("public").doc(id);
  return await docRef.get().then((DocumentSnapshot doc) {
      var v = (doc.data() as Map<String, dynamic>);
      return FirebaseDocument(
        id: id,
        lat: v["lat"],
        lon: v["lon"],
        name: v["name"],
        creatorID: v["creatorID"],
        dateCreated: DateTime.fromMillisecondsSinceEpoch((v["dateCreated"]).seconds * 1000),
        upVotes: v["upVotes"],
        downVotes: v["downVotes"],
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
      );
    }
  );
}

Future<List<FirebaseDocument>> getAllFirebaseDocuments() async {
  List<FirebaseDocument> toReturn = [];
  var querySnapshot = await db.collection("public").get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> v = queryDocumentSnapshot.data();
    toReturn.add(FirebaseDocument(
      id: queryDocumentSnapshot.id,
      lat: v["lat"],
      lon: v["lon"],
      name: v["name"],
      creatorID: v["creatorID"],
      dateCreated: DateTime.fromMillisecondsSinceEpoch((v["dateCreated"]).seconds * 1000),
      upVotes: v["upVotes"],
      downVotes: v["downVotes"],
    ));
  }
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