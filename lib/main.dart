import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "File demo",
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Color backgroundColor = const Color(0xff122332);
Color coolYellow = const Color(0xfffbc10a);
Color darkerBlue = const Color(0xff091521);

TextStyle buttonTextStyle = TextStyle(
  fontSize: 25,
  fontFamily: "hand_mono",
  color: Colors.white,
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
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
            Spacer(flex: 10,),
            Text(
              "Where to go?",
              style: TextStyle(
                color: coolYellow,
                fontSize: 40,
                fontFamily: "hand_mono",
              ),
            ),
            Spacer(flex: 2,),
            TextButton(
              onPressed: () {},
              child: Text(
                "   Quick & Random ->   ",
                style: buttonTextStyle,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "   Nice places ->   ",
                style: buttonTextStyle,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "   My voyges ->   ",
                style: buttonTextStyle,
              ),
            ),
            Spacer(flex: 15,),
          ],
        ),
      ),
    );
  }
}
