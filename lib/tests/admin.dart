import 'package:flutter/material.dart';
import '../application/2_z0_specific_nice_place.dart';
import '../support/constants.dart';
import '../support/firebase_database.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  double w = 10;
  double h = 10;

  List<FirebaseDocument> nicePlaces = [];

  Future<void> loadData() async {
    nicePlaces = await getAllFirebaseDocuments(true);
    setState(() {});
  }

  bool init = true;
  @override
  Widget build(BuildContext context) {
    if (init) {
      init = false;
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
      loadData();
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              for (var i in nicePlaces) getCell(i)
            ],
          ),
        ],
      ),
    );
  }

  Widget getCell(FirebaseDocument fb) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          "/specific_nice_place",
          arguments: SpecificNicePlaceArguments(documentID: fb.id, adminDecision: true),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 15, top: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: coolYellow,
        ),

        child: Center(
          child: Text(
            fb.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "hand_mono",
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
