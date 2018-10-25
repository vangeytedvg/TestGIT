import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),    
    );
  }
}

