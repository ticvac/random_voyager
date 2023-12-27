import 'package:flutter/material.dart';
import '../support/database.dart';
import '../support/firebase_database.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import '../support/constants.dart';
import '../support/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import '../support/shared_prefs_database.dart';
import '4_specific_voyage.dart';

class SpecificNicePlaceArguments {
  String documentID;
  bool adminDecision;

  SpecificNicePlaceArguments({required this.documentID, required this.adminDecision});
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
    isPublic: false,
    isEnlisted: false,
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

  Future<void> goFindPressed() async {
    Position p = await determinePosition();
    int id = await addPlaceToDatabase(lat, lon, p.latitude, p.longitude, documentID);
    await addToLookingFor(documentID);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: FloatingActionButton.extended(
                      backgroundColor: fb.upVotes >= fb.downVotes ? Colors.green : Colors.red,
                      onPressed: null,
                      label: Row(
                        children: [
                          Text(
                            fb.upVotes.toString(),
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(width: 5,),
                          const Icon(
                            Icons.favorite,
                          ),
                          SizedBox(width: 40,),
                          Text(
                            fb.downVotes.toString(),
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(width: 5,),
                          const Icon(
                            Icons.dangerous,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              if(args.adminDecision)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "21",
                      onPressed: () async {
                        await setIsPublic(fb.id, 1);
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.send,
                      ),
                    ),
                    SizedBox(width: 20,),
                    FloatingActionButton(
                      heroTag: "22",
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        await setIsPublic(fb.id, -1);
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
              if(!args.adminDecision)
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
