import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';
import 'package:note_taking_flutter_app/Utilities/Constants.dart';
import 'Note_Edit_Screen.dart';

// ignore: camel_case_types
class Note_View_Screen extends StatefulWidget {
  static const route='/note-view';
  @override
  _Note_View_ScreenState createState() => _Note_View_ScreenState();
}

// ignore: camel_case_types
class _Note_View_ScreenState extends State<Note_View_Screen> {
Note selectedNote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [

          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () => _showDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedNote?.title,
                style: viewTitleStyle,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text('${selectedNote?.date}')
              ],
            ),
            if (selectedNote.imagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(File(selectedNote.imagePath)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedNote.content,
                style: viewContentStyle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Note_Edit_Screen.route,
              arguments: selectedNote.id);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
