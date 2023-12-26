import 'package:flutter/material.dart';
import '../support/constants.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import '../support/database.dart';
import '../support/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import '4_specific_voyage.dart';

// TODO seed
var rng = Random();

class RandomStreetViewPage extends StatefulWidget {
  const RandomStreetViewPage({Key? key}) : super(key: key);

  @override
  State<RandomStreetViewPage> createState() => _RandomStreetViewPageState();
}

class _RandomStreetViewPageState extends State<RandomStreetViewPage> {
  String appBarTitle = "distance :  0 m";
  double lat = 50.0875772;
  double lon = 14.4211547;
  double startLat = 50.0875772;
  double startLon = 14.4211547;

  void pointToMyPositionPressed() async {
    Position position = await determinePosition();
    lat = position.latitude;
    lon = position.longitude;
    startLat = position.latitude;
    startLon = position.longitude;
    appBarTitle = "distance :  0 m";
    setState(() {});
  }

  void newLocationPressed() {
    calculateNewPosition();
  }

  Future<void> goFindPressed() async {
    int id = await addPlaceToDatabase(lat, lon, startLat, startLon, "NaN");
    List<Place> places = await getAllPlaces();
    for (Place p in places) {
      if (p.id == id) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(
          context,
          "/specific_voyage",
          arguments: SpecificVoyageArguments(place: p),
        ).then((value) {
          Navigator.pop(context);
        });
      }
    }
  }

  void calculateNewPosition() {
    // generating new coordinates
    // maybe between 0.3 and 1.3? whatever
    // TODO add adjustable constants
    int off1 = rng.nextInt(201);
    off1 += -100;
    int off2 = rng.nextInt(201);
    off2 += -100;
    double newLat = startLat + off1 * 0.00015;
    double newLon = startLon + off2 * 0.00015;
    // calculating distance
    double latR = startLat * pi / 180;
    double lonR = startLon * pi / 180;
    double newLatR = newLat * pi / 180;
    double newLonR =  newLon * pi / 180;
    double dLatR = newLatR - latR;
    double dLonR = newLonR - lonR;
    num a = pow(sin(dLatR/2), 2)+cos(latR)*cos(newLatR)*pow(sin(dLonR/2), 2);
    double d = 6373 * 2 * atan2(sqrt(a), sqrt(1 - a));
    // check conditions
    if (d > 1.0 || d < 0.1) {
      calculateNewPosition();
      print("-----------------");
      return;
    }
    // updating to position
    lat = newLat;
    lon = newLon;
    appBarTitle = "distance :  ${(d * 1000).toStringAsFixed(0)} m";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pointToMyPositionPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
        actions: [
          TextButton(
            onPressed: () { pointToMyPositionPressed(); },
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.green,
                // streetView
                child: FlutterGoogleStreetView(
                  initPos: LatLng(lat, lon),
                  //initPanoId: SANTORINI,
                  initSource: StreetViewSource.outdoor,
                  initBearing: 30,

                  streetNamesEnabled: false,
                  userNavigationEnabled: false,
                  onStreetViewCreated: (StreetViewController controller) async {
                    /*controller.animateTo(
                      duration: 750,
                      camera: StreetViewPanoramaCamera(
                          bearing: 90, tilt: 30, zoom: 3));*/
                  },
                ),
              ),
            ),
          ),
          Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (appBarTitle != "distance :  0 m")
                    FloatingActionButton.extended(
                      heroTag: "1",
                      onPressed: () {
                        goFindPressed();
                      },
                      backgroundColor: Colors.blueAccent,
                      icon: const Icon(
                        Icons.check_rounded,
                      ),
                      label: const Text("go find"),
                    ),
                  FloatingActionButton.extended(
                    heroTag: "2",
                    onPressed: () {
                      newLocationPressed();
                    },
                    backgroundColor: Colors.pinkAccent,
                    icon: const Icon(
                      Icons.autorenew_rounded,
                    ),
                    label: const Text("new location"),
                  ),
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ],
      ),
    );
  }
}
