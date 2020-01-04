import 'package:listadecompras2_5/screens/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.dark, accentColor: Colors.redAccent),
      home: HomePage(),
    );
  }
}
