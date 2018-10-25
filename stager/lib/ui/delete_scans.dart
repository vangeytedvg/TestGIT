/*
  delete_scans.dart
  Remove all the scanned items from the database
  Version 0.0.1
*/

import 'package:flutter/material.dart';
import '../dbutil/databasehelper.dart';
import '../model/note.dart';

class DeleteScansScreen extends StatelessWidget {
  final DatabaseHelper db = new DatabaseHelper();

  // In the constructor, require a Todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Delete ALL scans!"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      color: Colors.pink,
                  child: Text("I'm sure!"),
                  onPressed: () {
                    db.deleteAll("disProducts");
                    Navigator.pop(context, 'deleted');
                  },
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      color: Colors.green,
                  child: Text(
                    "Get outta here!",
                    style: TextStyle(color: Colors.black,),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'refused');
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
