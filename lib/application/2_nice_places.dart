import 'package:flutter/material.dart';
import '../support/constants.dart';

class NicePlaces extends StatefulWidget {
  const NicePlaces({Key? key}) : super(key: key);

  @override
  State<NicePlaces> createState() => _NicePlacesState();
}

class _NicePlacesState extends State<NicePlaces> {

  double w = 10;
  double h = 10;

  bool init = true;
  @override
  Widget build(BuildContext context) {
    if (init) {
      init = false;
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Near nice places",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  getCell("Vyšehrad"),
                  SizedBox(height: 10,),
                  getCell("Katedrála sv. Víta"),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 10,),
                  getCell("Pražský hrad"),
                  SizedBox(height: 10,),
                  getCell("Tančící dům"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getCell(String name) {
    return Container(
      height: w / 2 - 20,
      width: w / 2 - 20,
      child: TextButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: coolYellow,
          ),

          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "hand_mono",
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
