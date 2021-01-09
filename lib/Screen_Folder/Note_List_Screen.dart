import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/DB_Helper/Note_Provider.dart';
import 'package:note_taking_flutter_app/Utilities/Constants.dart';
import 'package:note_taking_flutter_app/Widgets_Folder/List_Items.dart';
import 'package:provider/provider.dart';
import '../Login_Page.dart';
import 'Note_Edit_Screen.dart';

// ignore: camel_case_types
class Note_List_Screen extends StatefulWidget {
  @override
  _Note_List_ScreenState createState() => _Note_List_ScreenState();
}

// ignore: camel_case_types
class _Note_List_ScreenState extends State<Note_List_Screen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Note_Provider>(context, listen: false).getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                body: Consumer<Note_Provider>(
                  child: noNotesUI(context),
                  builder: (context, noteprovider, child) =>
                  noteprovider.items.length <= 0
                      ? child
                      : ListView.builder(
                    itemCount: noteprovider.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return header();
                      }
                      else {
                        final i = index - 1;
                        final item = noteprovider.items[i];
                        return Dismissible(key: Key('$item'),
                          onDismissed: (direction) {
                            setState(() {
                              Provider.of<Note_Provider>(context, listen: false)
                                  .deleteNote(item.id);
                              // item.removeAt(i);
                            });
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(
                                content: Text("Deleted Successfully ")));
                          },
                          background: Container(color: const Color(0xa6211f1f),
                          ),
                          child: List_Items(
                            id: item.id,
                            title: item.title,
                            content: item.content,
                            imagePath: item.imagePath,
                            date: item.date,
                          ),
                        );
                      }
                    },
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: const Color(0xa6211f1f),
                  onPressed: () {
                    //goToNoteEditScreen(context);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Login_Page()));
                  },

                  child: Icon(Icons.add, color: Colors.blue,),

                ),
              );
            }
          }
          return Container();
        }

    );
  }

  Widget header() {
    return
      Container(
        decoration: BoxDecoration(
          //color: headerColor,
          borderRadius: BorderRadius.circular(56.0),
          color: const Color(0xa6211f1f),
          border: Border.all(width: 0.0, color: const Color(0xa6707070)
          ),
        ),
        height: 100,
        width: double.infinity,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zain Iftikhar\'s',
              style: headerRideStyle,
            ),
            Text(
              'NOTES',
              style: headerNotesStyle,
            ),
          ],
        ),
      );
  }


  noNotesUI(BuildContext context) {
    return ListView(
      children: [
        header(),
        SizedBox(
          width: 100.0,
          height: 20.0,
        ),
        Container(
          width: 0.0,
          height: 561.0,
          decoration: BoxDecoration(
            //color: headerColor,
            borderRadius: BorderRadius.circular(26.0),
            color: const Color(0xa6211f1f),
            border: Border.all(width: 0.0, color: const Color(0xa6707070)
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
              ),
              RichText(
                text: TextSpan(
                  style: noNotesStyle,
                  children: [
                    TextSpan(text: 'No Notes available\n',
                      style: TextStyle(color: Colors.white),
                    ), //touching Blue Button

                    TextSpan(text: 'Create Notes by pressing\n ',
                      style: TextStyle(color: Colors.white),),
                    TextSpan(
                      text: 'BLUE Button',
                      style: boldPlus,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(Note_Edit_Screen.route);
  }
}

