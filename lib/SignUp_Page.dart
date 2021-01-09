import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/Screen_Folder/Note_List_Screen.dart';
import 'Utilities/Constants.dart';

// ignore: camel_case_types
class SignUp_Page extends StatefulWidget {
  @override
  _SignUp_PageState createState() => _SignUp_PageState();
}

// ignore: camel_case_types
class _SignUp_PageState extends State<SignUp_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
                    'Signup',
                    style: headerNotesStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: const Color(0xa6211f1f),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(00),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,

                                ),
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.all(00),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,

                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.all(00),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new Note_List_Screen()));

                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text("Login", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),

                          ),
                        ],
                      )
                    ],
                  ),


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}