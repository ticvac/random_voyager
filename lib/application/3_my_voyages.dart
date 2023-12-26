import 'package:Voyager/support/firebase_database.dart';
import 'package:flutter/material.dart';
import '../support/constants.dart';
import '../support/database.dart';
import '4_specific_voyage.dart';

class MyVoyages extends StatefulWidget {
  const MyVoyages({Key? key}) : super(key: key);

  @override
  State<MyVoyages> createState() => _MyVoyagesState();
}

class _MyVoyagesState extends State<MyVoyages> {
  List <Place> voyages = [];
  int numberOfDone = 0;
  List<String> lookingForNames = [];
  List<String> doneNames = [];

  @override
  void initState() {
    loadVoyages();
    super.initState();
  }

  void loadVoyages() async {
    doneNames = [];
    lookingForNames = [];
    voyages = await getAllPlaces();
    numberOfDone = 0;
    for (Place p in voyages) {
      if (p.found) {
        numberOfDone += 1;
        if (p.firebaseID == "NaN") {
          doneNames.add(getCellText(p));
        } else {
          doneNames.add((await getOneFirebaseDocumentById(p.firebaseID)).name);
        }
      } else {
        if (p.firebaseID == "NaN") {
          lookingForNames.add(getCellText(p));
        } else {
          lookingForNames.add((await getOneFirebaseDocumentById(p.firebaseID)).name);
        }
      }
    }
    setState(() {});
  }

  List<Widget> getBody() {
    print("creating body");
    print(lookingForNames);
    print(doneNames);
    List<Widget> values = [];
    values.add(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Text(
          "STILL LOOKING FOR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "hand_mono"
          ),
        ),
      ),
    );
    int c = 0;
    for (Place p in voyages) {
      if (p.found == false) {
        values.add(
          getVoyageCell(p, lookingForNames[c]),
        );
        c += 1;
      }
    }
    values.add(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          "DONE - $numberOfDone",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "hand_mono"
          ),
        ),
      ),
    );
    c = 0;
    for (Place p in voyages) {
      if (p.found) {
        values.add(
          getVoyageCell(p, doneNames[c]),
        );
        c += 1;
      }
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "My voyages",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
      ),
      body: ListView(
        children: getBody(),
      ),
    );
  }

  Widget getVoyageCell(Place place, String text) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          "/specific_voyage",
          arguments: SpecificVoyageArguments(place: place),
        ).then((value) {
          loadVoyages();
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        height: place.firebaseID == "NaN" ? 50 : 100,
        decoration: BoxDecoration(
          border: Border.all(color: getCellColor(place)),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: place.firebaseID != "NaN" ? Color(0xff3d4564) : backgroundColor,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "hand_mono",
                  color: getCellColor(place),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 7, top: 5),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: getCellColor(place),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Color getCellColor(Place p) {
    return !p.found ? coolYellow : coolPurple;
  }

  String getCellText(Place p) {
    if (p.firebaseID == "NaN") {
      return "${p.dateRegistered.day < 10 ? "0" : ""}" // space
          "${p.dateRegistered.day}. "
          "${p.dateRegistered.month < 10 ? "0" : ""}" // space
          "${p.dateRegistered.month}. "
          "${p.dateRegistered.year.toString()[2]}"
          "${p.dateRegistered.year.toString()[3]} - "
          "${p.dateRegistered.hour < 10 ? "0" : ""}" // space
          "${p.dateRegistered.hour}."
          "${p.dateRegistered.minute < 10 ? "0" : ""}" // space
          "${p.dateRegistered.minute}";
    } else {
      return "hmm";
    }
  }

}

