import 'package:flutter/material.dart';
import 'package:messangerApp/helper/authenticate.dart';
import 'package:messangerApp/helper/functions.dart';
import 'package:messangerApp/views/chatRoomsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Din\'s messanger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ? userIsLoggedIn
            ? ChatRoom()
            : Authenticate()
            :Container(
              child:
                Center(
                  child: Authenticate(),
                )
             )
    );
  }
}
