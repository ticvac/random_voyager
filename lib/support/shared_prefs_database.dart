import 'package:shared_preferences/shared_preferences.dart';

String _lookingForFirebase = "lookingForFirebase";
String _doneFirebase = "doneFirebase";
String _upVotes = "upVotes";
String _downVotes = "downVotes";

// looking for
Future<List<String>> getLookingForFirebase() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(_lookingForFirebase) ?? [];
}

Future<void> setLookingForFirebase(List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(_lookingForFirebase, value);
}

// done
Future<List<String>> getDoneFirebase() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(_doneFirebase) ?? [];
}

Future<void> setDoneFirebase(List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(_doneFirebase, value);
}

// upVotes
Future<List<String>> getUpVotes() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(_upVotes) ?? [];
}

Future<void> setUpVotes(List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(_upVotes, value);
}

// downVotes
Future<List<String>> getDownVotes() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(_downVotes) ?? [];
}

Future<void> setDownVotes(List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(_downVotes, value);
}