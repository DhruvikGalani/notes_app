import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app_by_sql/spleshSreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade800,
    ),
    debugShowCheckedModeBanner: false,
    home: spleshScreen(),
    // home: const mainPage(),
    // home: MyHomePage(),
  ));
}
