import 'package:flutter/material.dart';
import '../support/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



TextStyle buttonTextStyle = TextStyle(
  fontSize: 25,
  fontFamily: "hand_mono",
  color: Colors.white,
);

class _HomePageState extends State<HomePage> {
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
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "   Quick random walk   ",
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.nature_people,
                    color: Colors.white,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "   Nice places   ",
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "   My voyges   ",
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
