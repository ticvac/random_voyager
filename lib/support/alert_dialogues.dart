import 'package:flutter/material.dart';
import '../support/constants.dart';

void showDialogStreetViewPage(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 10));
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
              "If you press \"new location\", \nand street view does not refresh, "
                  "\njust click if once more ;)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "hand_mono",
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Publish!",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "hand_mono",
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}