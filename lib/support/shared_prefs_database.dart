import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_database.dart';

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

// now real functions

// add toLookingFor
// move from lookingFor to done
// remove is // both from looking for and done
// check if is in lookingFor
// check if is in done

// upVote
// downVote
// get vote 1 for up -1 for down 0 for nothing

Future<bool> isInLookingFor(String id) async {
  return (await getLookingForFirebase()).contains(id);
}

Future<bool> isInDone(String id) async {
  return (await getDoneFirebase()).contains(id);
}

Future<void> moveFromLookingForToDone(String id) async {
  if (await isInLookingFor(id) && !(await isInDone(id))) {
    List<String> old = await getLookingForFirebase();
    old.removeWhere((element) => element == id);
    await setLookingForFirebase(old);
    List<String> oldDone = await getDoneFirebase();
    oldDone.add(id);
    await setDoneFirebase(oldDone);
  }
}

Future<void> removeFromLookingForAndDone(String id) async {
  List<String> old = await getLookingForFirebase();
  old.removeWhere((element) => element == id);
  await setLookingForFirebase(old);
  List<String> oldDone = await getLookingForFirebase();
  oldDone.removeWhere((element) => element == id);
  await setLookingForFirebase(oldDone);
}

Future<void> addToLookingFor(String id) async {
  List<String> old = await getLookingForFirebase();
  old.add(id);
  await setLookingForFirebase(old);
}

// voting
Future<void> upVote(String id) async {
  if (!(await getUpVotes()).contains(id)) {
    await diffVotes(id, 1, "upVotes");
    List<String> old = await getUpVotes();
    old.add(id);
    await setUpVotes(old);
  }
  if ((await getDoneFirebase()).contains(id)) {
    await diffVotes(id, -1, "downVotes");
    List<String> old = await getDownVotes();
    old.removeWhere((element) => element == id);
    await setDownVotes(old);
  }
}

Future<void> downVote(String id) async {
  if (!(await getDownVotes()).contains(id)) {
    await diffVotes(id, 1, "downVotes");
    List<String> old = await getDownVotes();
    old.add(id);
    await setDownVotes(old);
  }
  if ((await getDoneFirebase()).contains(id)) {
    await diffVotes(id, -1, "upVotes");
    List<String> old = await getUpVotes();
    old.removeWhere((element) => element == id);
    await setUpVotes(old);
  }
}