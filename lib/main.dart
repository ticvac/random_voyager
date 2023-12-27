import 'package:flutter/material.dart';
import 'application/0_home_page.dart';
import 'application/1_random_street_view_page.dart';
import 'application/3_my_voyages.dart';
import 'application/2_nice_places.dart';
import 'application/2_z0_specific_nice_place.dart';
import 'application/4_specific_voyage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'tests/admin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Random Voyageur",
      theme: ThemeData.light(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/quick_voyage": (context) => const RandomStreetViewPage(),
        "/nice_places": (context) => const NicePlaces(),
        "/specific_nice_place": (context) => const SpecificNicePlace(),
        "/my_voyages": (context) => const MyVoyages(),
        "/specific_voyage": (context) => const SpecificVoyage(),

        // testing routes
        "/admin": (context) => const Admin(),

        //"/geolocator_test": (context) => ,
        //"/map_test": (context) => ,
        //"/street_view_test": (context) => ,
      },
    );
  }
}

