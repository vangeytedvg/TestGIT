/*
  scan_history.dart
  Show a list with previously scanned items
  Shows a card layout
 */

import 'package:flutter/material.dart';
import '../ui/note_screen.dart';
import '../dbutil/databasehelper.dart';
import '../model/note.dart';

class ScanHistory extends StatefulWidget {
  @override
  _ScanHistoryState createState() => new _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getAllNotes(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Denka's shopping list"),
        centerTitle: true,
        //backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            // To 'view' the card, it should be under a listview builder
            // then return the card for drawing
            return Container(
              padding: const EdgeInsets.only(top: 1.0),
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(
                  color: Colors.white12,
                  blurRadius: 1.0,
                ),
              ]),
              // The Actual card widget
              child: Card(
                color: Colors.white10,
                elevation: 8.0,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  leading: Container(
                    // Delete icon
                    child: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.redAccent,
                        iconSize: 35.0,
                        onPressed: () =>
                            _deleteNote(context, items[position], position)),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        '${items[position].title}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Text('${items[position].description}',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontStyle: FontStyle.italic))
                    ],
                  ),
                  // Edit note icon
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.lightGreen,
                    iconSize: 30.0,
                    onPressed: () => _navigateToNote(context, items[position]),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
        onPressed: () => _createNewNote(context),
      ),
    );
  }

  Future<Null> _deleteNote(
      BuildContext context, Note note, int position) async {
    return showDialog<Null>(
        context: context,
        // The user HAS to select a button with this
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sure to delete item?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text("Select option:")],
              ),
            ),
            actions: <Widget>[
              // When the user clicks Yes, delete the record
              FlatButton(
                child: Text("AGREE"),
                onPressed: () {
                  db.deleteNote(note.id).then((notes) {
                    setState(() {
                      items.removeAt(position);
                    });
                  });
                  // Dismiss dialog
                  Navigator.of(context).pop();
                },
              ),
              Icon(Icons.delete_forever),
              FlatButton(
                child: Text("DISAGREE"),
                // Dismiss withoout deleting
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Icon(Icons.undo),
            ],
          );
        });
  }

  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      _getAllNotes(context);
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', ''))),
    );

    if (result == 'save') {
      _getAllNotes(context);
    }
  }

  // Asynchronically get the context of the items table.
  void _getAllNotes(BuildContext context) async {
    db.getAllNotes().then((notes) {
      setState(() {
        items.clear();
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }
}
