import 'package:flutter/material.dart';
import '../support/constants.dart';

class MyVoyages extends StatefulWidget {
  const MyVoyages({Key? key}) : super(key: key);

  @override
  State<MyVoyages> createState() => _MyVoyagesState();
}

class _MyVoyagesState extends State<MyVoyages> {

  List<Widget> getBody() {
    List<Widget> values = [];
    for (int i = 0; i < 4; i++) {
      values.add(Container(
        margin: EdgeInsets.all(5),
        height: 60,
        color: coolPurple,
      ),);
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "My voyages",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
      ),
      body: ListView(
        children: getBody() + [Container(height: 20, color: Colors.red,)],
      ),
    );
  }
}
