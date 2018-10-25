/*
  main.dart
  Main forms of the application.
  This application can also be the base of 
  shopping list, a todo or whatever...
  Copyright(c) Danny Van Geyte (DaVaGe)
  Version 0.0.1
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './ui/drawer_menu.dart';
import './model/note.dart';
import './ui/details_screen.dart';
import 'package:barcode_scan/barcode_scan.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightGreen,
          accentColor: Colors.cyan[600],
          backgroundColor: Colors.white54),
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String t;
  String result = "Press <Scan> to start!";
  String buttonText = "Save";
  Note note;

  /* 
    Start the camera to scan a QR-Code.
  */
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                    qrcode: qrResult,
                    goodQrInfo: "DIS",
                    buttonLabel: "Save",
                    note: note)));
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        result = "Unknow error $ex";
      }
      ;
    }
  }

  /*
    Layout of the main screen
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QrCodeChanner"),
      ),
      body: ListView(
        children: [
          Center(
            heightFactor: 2.0,
            child: Image.asset("assets/barcsmart2.png"),
          ),
          Center(
            heightFactor: 5.0,
            child: new Text(
              "Press the button below",
              style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: new Text(
              "to start scanning bar- or Qr codes...",
              style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton. extended(
        icon: Icon(Icons.camera_alt, color: Colors.black,),
        label: Text(
          "Scan Now",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreenAccent,
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: DrawerPage(),
    );
  }
}
