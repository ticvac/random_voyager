import 'package:flutter/material.dart';
import '../support/constants.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import '../support/geolocator.dart';
import 'package:geolocator/geolocator.dart';

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

  }

  void goFindPressed() {
    Navigator.pushNamed(context, "/specific_voyage");//.then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "distance : 0 m",
          style: TextStyle(
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
