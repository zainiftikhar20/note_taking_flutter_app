import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MaterialApp(
            title: 'Notes App',
            home: MyApp(),
            theme: ThemeData(
                primarySwatch: Colors.green)))));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/zain.jpg'), height: 300),
          Text("M Zain Iftikhar", style: TextStyle(fontSize: 20,color: Color(0xFF000000))),
          SizedBox(
            height: 10,
          ),
          Text("FA17-BSE-043", style: TextStyle(fontSize: 20,color: Color(0xFF000000))),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}