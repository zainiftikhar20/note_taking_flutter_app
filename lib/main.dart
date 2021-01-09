import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'DB_Helper/Note_Provider.dart';
import 'Screen_Folder/Note_Edit_Screen.dart';
import 'Screen_Folder/Note_List_Screen.dart';
import 'Screen_Folder/Note_View_Screen.dart';
import 'Screen_Folder/SplashScreen.dart';
void main() {
  runApp(SplashScreen());
}
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Note_Provider(),
      child: MaterialApp(
        title: "Flutter Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Note_List_Screen(),
          Note_View_Screen.route: (context) => Note_View_Screen(),
          Note_Edit_Screen.route: (context) => Note_Edit_Screen(),
        },
      ),
    );
  }
}