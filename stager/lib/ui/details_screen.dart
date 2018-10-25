/*
  details_screen.dart
  Inventory System
  Author: Google/Danny Van Geyte
  Scanned product information
  Version 0.0.1
*/

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../dbutil/databasehelper.dart'; 
import '../model/note.dart';

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo
  final String qrcode;
  final String goodQrInfo;
  final String buttonLabel;
  final Note note;

  final DatabaseHelper db = new DatabaseHelper();

  // In the constructor, require a Todo
  DetailScreen(
      {Key key,
      @required this.qrcode,
      @required this.goodQrInfo,
      @required this.buttonLabel,
      @required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Product details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Product information:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white12,
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$qrcode"),
                ),
                RaisedButton(
                  child: Text(this.buttonLabel),
                  onPressed: () {
                    if (goodQrInfo == "DIS") {
                      // Save the data to the database
                      db.saveNote(Note("QRCODE", qrcode)).then((_) {
                        print("Record Saved");
                        Navigator.pop(context, 'save');
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
