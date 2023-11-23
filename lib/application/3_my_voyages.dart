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
    values.add(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Text(
          "STILL LOOKING FOR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "hand_mono"
          ),
        ),
      ),
    );
    for (int i = 0; i < 3; i++) {
      values.add(
        getVoyageCell(true),
      );
    }
    values.add(
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Text(
          "DONE - 10",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "hand_mono"
          ),
        ),
      ),
    );
    for (int i = 0; i < 6; i++) {
      values.add(
        getVoyageCell(false),
      );
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
        children: getBody(),
      ),
    );
  }

  Widget getVoyageCell(bool working) {
    return TextButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: working ? coolYellow : coolPurple),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "04. 11. 23 - 10:04",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "hand_mono",
                  color: working ? coolYellow : coolPurple,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 7, top: 5),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: working ? coolYellow : coolPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
