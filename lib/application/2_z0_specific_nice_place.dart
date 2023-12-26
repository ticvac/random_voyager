import 'package:flutter/material.dart';
import '../support/firebase_database.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import '../support/constants.dart';
import '../support/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class SpecificNicePlaceArguments {
  String documentID;

  SpecificNicePlaceArguments({required this.documentID});
}

class SpecificNicePlace extends StatefulWidget {
  const SpecificNicePlace({Key? key}) : super(key: key);

  @override
  State<SpecificNicePlace> createState() => _SpecificNicePlaceState();
}

class _SpecificNicePlaceState extends State<SpecificNicePlace> {
  late String documentID;
  late FirebaseDocument fb = FirebaseDocument(
    id: "NaN",
    lat: 0,
    lon: 0,
    name: "error",
    creatorID: "",
    dateCreated: DateTime.now(),
    upVotes: 0,
    downVotes: 0,
  );
  String appBarTitle = "distance :  ? m";
  double lat = 50.0875772;
  double lon = 14.4211547;

  Future<void> loadData() async {
    fb = await getOneFirebaseDocumentById(documentID);
    lat = fb.lat;
    lon = fb.lon;
    Position p = await determinePosition();
    double d = calculateDistance(lat, lon, p.latitude, p.longitude);
    appBarTitle = "distance :  ${(d * 1000).toStringAsFixed(0)} m";
    setState(() {});
  }

  bool _shouldLoad = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!.settings.arguments as SpecificNicePlaceArguments;
    if (_shouldLoad) {
      _shouldLoad = false;
      documentID = args.documentID;
      loadData();
    }
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
                        //goFindPressed();
                      },
                      backgroundColor: Colors.blueAccent,
                      icon: const Icon(
                        Icons.check_rounded,
                      ),
                      label: const Text("go find"),
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
