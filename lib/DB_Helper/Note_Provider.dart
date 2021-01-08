import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/DB_Helper/DB_Helper.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';

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


}
enum EditMode {
  ADD,
  UPDATE,
}