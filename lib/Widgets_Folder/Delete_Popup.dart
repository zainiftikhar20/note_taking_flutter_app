import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/DB_Helper/Note_Provider.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Delete_PopUp extends StatelessWidget {
  const Delete_PopUp({
    Key key,
    @required this.selectedNote,
  }) : super(key: key);
  final Note selectedNote;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Delete?'),
      content: Text('Are you sure to delete the note?'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Provider.of<Note_Provider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

  }

}