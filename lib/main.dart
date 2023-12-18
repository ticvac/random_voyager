import 'package:flutter/material.dart';
import 'application/0_home_page.dart';
import 'application/1_random_street_view_page.dart';
import 'application/3_my_voyages.dart';
import 'application/2_nice_places.dart';
import 'application/4_specific_voyage.dart';

void main() {
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
        "/my_voyages": (context) => const MyVoyages(),
        "/specific_voyage": (context) => const SpecificVoyage(),

        // testing routes

        //"/geolocator_test": (context) => ,
        //"/map_test": (context) => ,
        //"/street_view_test": (context) => ,
      },
    );
  }
}

