import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/DB_Helper/Note_Provider.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';
import 'package:note_taking_flutter_app/Utilities/Constants.dart';
import 'package:note_taking_flutter_app/Widgets_Folder/Delete_Popup.dart';
import 'package:provider/provider.dart';
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
void didChangeDependencies() {
  super.didChangeDependencies();
  final id = ModalRoute.of(context).settings.arguments;
  final provider = Provider.of<Note_Provider>(context);
  if (provider.getNote(id) != null) {
    selectedNote = provider.getNote(id);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: const Color(0xa6211f1f),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [

          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.blue,
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
        backgroundColor: const Color(0xa6211f1f),
        onPressed: () {
          Navigator.pushNamed(context, Note_Edit_Screen.route,
              arguments: selectedNote.id);
        },
        child: Icon(Icons.edit, color: Colors.blue,),
      ),
    );
  }
_showDialog() {
  showDialog(
      context: this.context,
      builder: (context) {
        return Delete_PopUp(selectedNote: selectedNote);
      });
}
}
