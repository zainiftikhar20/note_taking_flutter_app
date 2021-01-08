import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';
import 'package:note_taking_flutter_app/Utilities/Constants.dart';
import 'DB_Helper.dart';

// ignore: camel_case_types
class Note_Provider with ChangeNotifier{

  List _items = [];
  List get items {
    return [..._items];
  }
  Future addOrUpdateNote(int id, String title, String content,
      String imagePath, EditMode editMode) async {
    final note = Note(id, title, content, imagePath);
    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }
    notifyListeners();
    DB_Helper.insert(
      {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'imagePath': note.imagePath,
      },
    );
  }
  Future getNotes() async {
    final notesList = await DB_Helper.getNotesFromDB();
    _items = notesList
        .map(
          (item) =>
          Note(
              item['id'], item['title'], item['content'], item['imagePath']),
    )
        .toList();
    notifyListeners();
  }
  Note getNote(int id) {
    return _items.firstWhere((note) => note.id == id, orElse: () => null);
  }
  Future deleteNote(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DB_Helper.delete(id);
  }

}
