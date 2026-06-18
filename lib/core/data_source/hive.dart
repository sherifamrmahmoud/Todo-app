/* import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource {
  static const String boxName = 'notesBox';

  Box<String> getBox() {
    return Hive.box<String>(boxName);
  }

  List<String> getNotes() {
    return getBox().values.toList();
  }

  Future<void> addNote(String note) async {
    await getBox().add(note);
  }

  Future<void> deleteNote(int index) async {
    await getBox().deleteAt(index);
  }
} */


import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource {
  static const String boxName = 'notesBox';

  // 🔥 get box safely
  Box<String> get _box => Hive.box<String>(boxName);

  // 📥 get all notes
  List<String> getNotes() {
    return _box.values.toList();
  }

  // ➕ add note
  Future<void> addNote(String note) async {
    await _box.add(note);
  }

  // 🗑️ delete note
  Future<void> deleteNote(int index) async {
    await _box.deleteAt(index);
  }

  // 🧹 optional: clear all notes
  Future<void> clearAll() async {
    await _box.clear();
  }
}