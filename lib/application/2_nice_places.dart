import 'package:Voyager/application/2_z0_specific_nice_place.dart';
import 'package:flutter/material.dart';
import '../support/constants.dart';
import '../support/firebase_database.dart';

class NicePlaces extends StatefulWidget {
  const NicePlaces({Key? key}) : super(key: key);

  @override
  State<NicePlaces> createState() => _NicePlacesState();
}

class _NicePlacesState extends State<NicePlaces> {
  double w = 10;
  double h = 10;

  List<FirebaseDocument> nicePlaces = [];

  Future<void> loadData() async {
    nicePlaces = await getAllFirebaseDocuments(false);
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
      onPressed: fb.isEnlisted ? null : () {
        Navigator.pushNamed(
          context,
          "/specific_nice_place",
          arguments: SpecificNicePlaceArguments(documentID: fb.id, adminDecision: false),
        ).then((value) {
          Navigator.pop(context);
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 15, top: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: fb.isEnlisted ? Color(0xff3d4564) : coolYellow,
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
