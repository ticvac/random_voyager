import 'package:flutter/material.dart';
import '../support/constants.dart';

class SpecificVoyage extends StatefulWidget {
  const SpecificVoyage({Key? key}) : super(key: key);

  @override
  State<SpecificVoyage> createState() => _SpecificVoyageState();
}

class _SpecificVoyageState extends State<SpecificVoyage> {
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
            onPressed: () {},
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
