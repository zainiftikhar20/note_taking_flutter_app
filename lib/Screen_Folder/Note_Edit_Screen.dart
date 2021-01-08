import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_taking_flutter_app/DB_Helper/Note_Provider.dart';
import 'package:note_taking_flutter_app/Models_Folder/note.dart';
import 'package:note_taking_flutter_app/Utilities/Constants.dart';
import 'package:note_taking_flutter_app/Widgets_Folder/Delete_Popup.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Note_View_Screen.dart';

// ignore: camel_case_types
class Note_Edit_Screen extends StatefulWidget {
  static const route='/note-edit';
  @override
  _Note_Edit_ScreenState createState() => _Note_Edit_ScreenState();
}

// ignore: camel_case_types
class _Note_Edit_ScreenState extends State<Note_Edit_Screen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  bool firstTime = true;
  Note selectedNote;
  int id;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      id = ModalRoute.of(this.context).settings.arguments;
      if (id != null) {
        selectedNote =
            Provider.of<Note_Provider>(this.context, listen: false).getNote(id);
        titleController.text = selectedNote?.title;
        contentController.text = selectedNote?.content;
        if (selectedNote?.imagePath != null) {
          _image = File(selectedNote.imagePath);

        }
      }
      firstTime = false;
    }
  }
  @override
  void dispose(){
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.black,
            onPressed: share,
          ),
          IconButton(
            icon: Icon(Icons.photo_camera),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.camera);
            },
          ),
          IconButton(
            icon: Icon(Icons.insert_photo),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.black,
            onPressed: () {
              if (id != null) {
                _showDialog();
              } else {
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: createTitle,
                decoration: InputDecoration(
                    hintText: 'Enter Note Title', border: InputBorder.none),
              ),
            ),
            if(_image != null)
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 250.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(
                                    () {
                                  _image = null;
                                },
                              );
                            },
                            child: Icon(
                              Icons.delete,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: createContent,
                decoration: InputDecoration(
                  hintText: 'Enter Something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty)
            titleController.text = 'Untitled Note';
          saveNote();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();
    String imagePath = _image != null ? _image.path : null;
    if (id != null) {
      Provider.of<Note_Provider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath, EditMode.UPDATE);
      Navigator.of(this.context).pop();
    } else {
      int id = DateTime
          .now()
          .millisecondsSinceEpoch;
      Provider.of<Note_Provider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath, EditMode.ADD);
      Navigator.of(this.context)
          .pushReplacementNamed(Note_View_Screen.route, arguments: id);
    }
  }
  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return Delete_PopUp(selectedNote: selectedNote);
        });
  }
  void getImage(ImageSource imageSource) async {
    PickedFile imageFile = await picker.getImage(source: imageSource);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    setState(() {
      _image = tmpFile;

    });
  }
  Future<void> share() async {
    await FlutterShare.share(
      title: 'Example share',

      text: 'Note Title: ${titleController.text} \n Note Content: ${contentController.text}',

      //linkUrl: ,
      chooserTitle: 'Where to Share the Notes',
    );
  }

}
