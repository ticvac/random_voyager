import 'package:flutter/material.dart';
import '../support/constants.dart';

class RandomStreetViewPage extends StatefulWidget {
  const RandomStreetViewPage({Key? key}) : super(key: key);

  @override
  State<RandomStreetViewPage> createState() => _RandomStreetViewPageState();
}

class _RandomStreetViewPageState extends State<RandomStreetViewPage> {
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
                      //goFindPressed();
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
                      //newLocationPressed();
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
