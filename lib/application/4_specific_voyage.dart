import 'package:Voyager/support/alert_dialogues.dart';
import 'package:Voyager/support/firebase_database.dart';
import 'package:flutter/material.dart';
import '../support/constants.dart';
import '../support/database.dart';
import 'package:flutter/material.dart';
import '../support/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import '../support/shared_prefs_database.dart';

class SpecificVoyageArguments {
  Place place;

  SpecificVoyageArguments({required this.place});
}

class SpecificVoyage extends StatefulWidget {
  const SpecificVoyage({Key? key}) : super(key: key);

  @override
  State<SpecificVoyage> createState() => _SpecificVoyageState();
}

class _SpecificVoyageState extends State<SpecificVoyage> {
  String appBarTitle = "distance :  ? m";
  double lat = 50.0875772;
  double lon = 14.4211547;
  late Place place;
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

  void getDistancePressed() async {
    Position p = await determinePosition();
    double d = calculateDistance(lat, lon, p.latitude, p.longitude);
    appBarTitle = "distance :  ${(d * 1000).toStringAsFixed(0)} m";
    setState(() {});
  }

  void iAmHerePressed() async {
    Position p = await determinePosition();
    if (adminState) {
      await moveFromLookingForToDone(place.firebaseID);
      await markAsFound(place.id);
      Navigator.pop(context);
    } else {
      if (calculateDistance(lat, lon, p.latitude, p.longitude) * 1000 < 50) {
        await moveFromLookingForToDone(place.firebaseID);
        await markAsFound(place.id);
        Navigator.pop(context);
      }
    }
  }

  void deletePlacePressed() {
    deletePlaceFromDatabase(place.id);
    removeFromLookingForAndDone(place.firebaseID);
    Navigator.pop(context);
  }

  void processArgs(Place p) async {
    lat = p.lat;
    lon = p.lon;
    place = p;
    if (place.firebaseID != "NaN") {
      fb = await getOneFirebaseDocumentById(place.firebaseID);
    }
    setState(() {});
  }

  Future<void> publishPressed(BuildContext context) async {
    showDialogStreetViewPage(context, lat, lon, place.id, processArgs);
  }

  bool _shouldLoad = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!.settings.arguments as SpecificVoyageArguments;
    if (_shouldLoad) {
      _shouldLoad = false;
      processArgs(args.place);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontFamily: "hand_mono",
            fontSize: 25,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              deletePlacePressed();
            },
            child: const Icon(
              Icons.delete,
              color: Colors.redAccent,
              size: 30,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterGoogleStreetView(
            initPos: LatLng(lat, lon),
            initSource: StreetViewSource.outdoor,
            initBearing: 30,
            initTilt: 30,
            initZoom: 1.5,
            //panningGesturesEnabled: false,
            streetNamesEnabled: false,
            userNavigationEnabled: false,
            //zoomGesturesEnabled: false,
            onStreetViewCreated: (controller) async {
              controller.animateTo(
                duration: 50,
                camera: StreetViewPanoramaCamera(
                  bearing: 65, tilt: 10, zoom: 3,
                ),
              );
            },
          ),
          Column(
            children: [
              if(place.firebaseID != "NaN")
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
              const Spacer(),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  if (!args.place.found)
                    FloatingActionButton.extended(
                      heroTag: "1",
                      onPressed: () {
                        iAmHerePressed();
                      },
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.check_rounded,
                      ),
                      label: const Text("I am here"),
                    ),
                  if (args.place.found && args.place.firebaseID == "NaN")
                    FloatingActionButton.extended(
                      heroTag: "13",
                      onPressed: () {
                        publishPressed(context);
                      },
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.publish,
                      ),
                      label: const Text("Publish!"),
                    ),
                  const Spacer(),
                  if (args.place.found && args.place.firebaseID != "NaN")
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: "10",
                          onPressed: () async {
                            await upVote(place.firebaseID);
                            processArgs(args.place);
                          },
                          backgroundColor: Colors.green,
                          child: const Icon(
                            Icons.favorite,
                          ),
                        ),
                        SizedBox(width: 10,),
                        FloatingActionButton(
                          heroTag: "10",
                          onPressed: () async {
                            await downVote(place.firebaseID);
                            processArgs(args.place);
                          },
                          backgroundColor: Colors.red,
                          child: const Icon(
                            Icons.dangerous,
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  FloatingActionButton.extended(
                    heroTag: "2",
                    onPressed: () {
                      getDistancePressed();
                    },
                    backgroundColor: Colors.blue,
                    icon: const Icon(
                      Icons.autorenew_rounded,
                    ),
                    label: const Text("get distance"),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ],
      ),
    );
  }
}
