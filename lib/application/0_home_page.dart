import 'package:flutter/material.dart';
import '../support/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



TextStyle buttonTextStyle = const TextStyle(
  fontSize: 25,
  fontFamily: "hand_mono",
  color: Colors.white,
);

class _HomePageState extends State<HomePage> {

  void newRandomVoyagePressed() {
    Navigator.pushNamed(context, "/quick_voyage");
  }

  void nicePlacesPressed() {
    Navigator.pushNamed(context, "/nice_places");
  }

  void myVoyagesPressed() {
    Navigator.pushNamed(context, "/my_voyages");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Random Voyager",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "hand_mono",
              color: Colors.white
          ),
        ),
        backgroundColor: darkerBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 10,),
            Text(
              "Where to go?",
              style: TextStyle(
                color: coolYellow,
                fontSize: 40,
                fontFamily: "hand_mono",
              ),
            ),
            const Spacer(flex: 2,),
            TextButton(
              onPressed: () { newRandomVoyagePressed(); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 13),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Quick random walk",
                            style: buttonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () { nicePlacesPressed(); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 13),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Nice places",
                            style: buttonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () { myVoyagesPressed(); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "   My voyages   ",
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 15,),
          ],
        ),
      ),
    );
  }
}
