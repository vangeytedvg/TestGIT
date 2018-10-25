/* 
  Simple age calculator
*/

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Change button text',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(title: 'Great Fluttering'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double age = 0.0;
  var selectedYear;
  String quote = "Can't say anything...";
  String buttonText = "Hi there";
  
  void _showPicker() {
    showDatePicker(
      context: context,
      firstDate: new DateTime(1900),
      initialDate : new DateTime(2018),
      lastDate: DateTime.now()).then((DateTime dt) {
        selectedYear = dt.year;
        calculateAge();
      });
  }

  void calculateAge() {
    setState(() {
      age = (2018 - selectedYear).toDouble();
      if (age >=1 && age <= 5) {
        quote = "Very very young for android!";
      } else if (age >= 5 && age<=15) {
        quote = "Still a bit young for android";
      } else if (age >= 15 && age <= 25) {
        quote = "Age seems ok for android";
      } else if (age >= 25 && age <= 50) {
        quote = "Getting old";
      } else if (age >= 50) {
        quote = "Old faggot!";
      }
    });
  }
  
  void _changeButtonText() {
    setState(() {
          buttonText = "Zot geworden";
        });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              //borderSide: new BorderSide(color: Colors.black, width: 2.0),
              color: Colors.lightGreenAccent,
              child: Text("Select year of birth..."),
              onPressed: () { 
                _showPicker();
              },
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Text(
              "Your age is ${age.toStringAsFixed(0)}",
              style: new TextStyle(
                color: Colors.red,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
              ),
              new Padding(
                padding: const EdgeInsets.all(25.0),
              ),
              new Text("$quote"),
          ],
        ),
      ),
     );
  }
}
