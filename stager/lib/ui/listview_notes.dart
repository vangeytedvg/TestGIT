/*
  listview_note.dart
  Show a list with previously scanned items

 */

import 'package:flutter/material.dart';
import '../ui/note_screen.dart';
import '../dbutil/databasehelper.dart';
import '../model/note.dart';

class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          title: Text("Denka's shopping list"),
          centerTitle: true,
          //backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Divider(height: 10.0),
                        /* The text of the items */
                        ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          title: Text(
                            '${items[position].title}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.green,
                            ),
                          ),
                          subtitle: Text(
                            '${items[position].description}',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                              /* Show the id nr in a circle */
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                radius: 20.0,
                                child: Text(
                                  '${items[position].description.substring(0, 1).toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              /* The small button that allows to delete the selected item */
                              IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: Colors.red,
                                  iconSize: 30.0,
                                  onPressed: () => _deleteNote(
                                      context, items[position], position)),
                            ],
                          ),
                          onTap: () => _navigateToNote(context, items[position]),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
    );
  }

  void _deleteNote(BuildContext context, Note note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
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

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', ''))),
    );

    if (result == 'save') {
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
}
