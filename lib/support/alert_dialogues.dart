import 'package:Voyager/support/database.dart';
import 'package:Voyager/support/shared_prefs_database.dart';
import 'package:flutter/material.dart';
import '../support/constants.dart';
import 'package:flutter/cupertino.dart';
import '../support/firebase_database.dart';

void showDialogStreetViewPage(BuildContext context, double lat, double lon, localDatabaseID, Function after) async {
  await Future.delayed(const Duration(milliseconds: 10));
  TextEditingController _textController = TextEditingController(text: '');
  // not sure what next line does
  if (!context.mounted) return;
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        height: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white, width: 1),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Enter a name for\nthis location",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "hand_mono",
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CupertinoTextField(
                controller: _textController,
                placeholder: "enter a name...",
              ),
            ),
            TextButton(
              onPressed: () async {
                String id = await addDocToFirebase(_textController.text, lat, lon);
                await addToLookingFor(id);
                await moveFromLookingForToDone(id);
                await changeFirebaseID(localDatabaseID, id);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacementNamed(context, "/");
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
                child: const Text(
                  "Publish!",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "hand_mono",
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}