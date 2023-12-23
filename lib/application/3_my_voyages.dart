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

  @override
  void initState() {
    loadVoyages();
    super.initState();
  }

  void loadVoyages() async {
    voyages = await getAllPlaces();
    numberOfDone = 0;
    for (Place p in voyages) {
      if (p.found) numberOfDone += 1;
    }
    setState(() {});
  }

  List<Widget> getBody() {
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
    /*for (int i = 0; i < 3; i++) {
      values.add(
        getVoyageCell(true),
      );
    } */
    for (Place p in voyages) {
      if (p.found == false) {
        values.add(
          getVoyageCell(p),
        );
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
    /*for (int i = 0; i < 6; i++) {
      values.add(
        getVoyageCell(false),
      );
    }*/
    for (Place p in voyages) {
      if (p.found) {
        values.add(
          getVoyageCell(p),
        );
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

  Widget getVoyageCell(Place place) {
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
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: !place.found ? coolYellow : coolPurple),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "${place.dateRegistered.day < 10 ? "0" : ""}" // space
                    "${place.dateRegistered.day}. "
                    "${place.dateRegistered.month < 10 ? "0" : ""}" // space
                    "${place.dateRegistered.month}. "
                    "${place.dateRegistered.year.toString()[2]}"
                    "${place.dateRegistered.year.toString()[3]} - "
                    "${place.dateRegistered.hour < 10 ? "0" : ""}" // space
                    "${place.dateRegistered.hour}."
                    "${place.dateRegistered.minute < 10 ? "0" : ""}" // space
                    "${place.dateRegistered.minute}",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "hand_mono",
                  color: !place.found ? coolYellow : coolPurple,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 7, top: 5),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: !place.found ? coolYellow : coolPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
