import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_flutter_app/SignUp_Page.dart';
import 'package:note_taking_flutter_app/main.dart';
import 'EmailAndPswdValidator.dart';
import 'Utilities/Constants.dart';

// ignore: camel_case_types
class Login_Page extends StatefulWidget {
  @override
  _Login_PageState createState() => _Login_PageState();
}

// ignore: camel_case_types
class _Login_PageState extends State<Login_Page> {
  String uid;
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> _Login=GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  TextEditingController Lemail_Controller;

  // ignore: non_constant_identifier_names
  TextEditingController LpasswordController;
  final auth=FirebaseAuth.instance;
  @override
  initState(){
    Lemail_Controller =new TextEditingController();
    LpasswordController=new TextEditingController();
    super.initState();
  }
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
                    'Login',
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
                      SizedBox(height: 50,),
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
                        child: Form(
                          key: _Login,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(00),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,

                                  ),
                                  validator: emailValidator,
                                  controller: Lemail_Controller,
                                  keyboardType: TextInputType.emailAddress,
                                ),

                              ),
                              Container(
                                padding: EdgeInsets.all(00),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                  validator: pwdValidator,
                                  controller: LpasswordController,
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: (){
                                if(_Login.currentState.validate()){
                                  FirebaseAuth.instance.signInWithEmailAndPassword(email: Lemail_Controller.text, password: LpasswordController.text)
                                      .then((currentUser) => FirebaseFirestore.instance.collection("NotesTakingApp")
                                      .doc(uid).get()
                                      .then((result) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>MyApp()),
                                  ),));
                                }
                                else{
                                  showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Please Enter data"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
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

                          SizedBox(width: 30,),
                          Expanded(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new SignUp_Page()));

                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xa6211f1f),
                                ),
                                child: Center(
                                  child: Text("Signup", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),

                          )

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