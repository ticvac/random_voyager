import 'package:flutter/material.dart';
import 'application/0_home_page.dart';
import 'application/3_my_voyages.dart';

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
        //"/quick_voyage": (context) => ,
        //"/nice_places": (context) => ,
        "/my_voyages": (context) => const MyVoyages(),
        //"/specific_voyage_page": (context) => ,

        // testing routes

        //"/geolocator_test": (context) => ,
        //"/map_test": (context) => ,
        //"/street_view_test": (context) => ,
      },
    );
  }
}

