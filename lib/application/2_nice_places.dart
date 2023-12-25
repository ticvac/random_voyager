import 'package:flutter/material.dart';
import '../support/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NicePlaces extends StatefulWidget {
  const NicePlaces({Key? key}) : super(key: key);

  @override
  State<NicePlaces> createState() => _NicePlacesState();
}

class _NicePlacesState extends State<NicePlaces> {

  double w = 10;
  double h = 10;


  Future<void> getData() async {
    /*FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    }); */
    var collection = FirebaseFirestore.instance.collection('test');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['name'];
      var lat = data['lat'];
      var lon = data['lon'];
      print(name);
    }
    print("object");
    setState(() {});
  }

  bool init = true;
  @override
  Widget build(BuildContext context) {
    if (init) {
      init = false;
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
      getData();
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Nice places nearby",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  getCell("Vyšehrad"),
                  SizedBox(height: 10,),
                  getCell("Katedrála sv. Víta"),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 10,),
                  getCell("Pražský hrad"),
                  SizedBox(height: 10,),
                  getCell("Tančící dům"),
                ],
              )
            ],
          ),
          const Text(
            "Loaded from firebase",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "hand_mono",
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCell(String name) {
    return Container(
      height: w / 2 - 20,
      width: w / 2 - 20,
      child: TextButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: coolYellow,
          ),

          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "hand_mono",
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
