/*
  note_screen.dart
  Add or update a scanned item
 */

import 'package:flutter/material.dart';
import '../dbutil/databasehelper.dart';
import '../model/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  // Ctor
  NoteScreen(this.note);
  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.note.title);
    _descriptionController =
        new TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Check what kind of title we need to show, depending of the id
      appBar: AppBar(
          title: (widget.note.id != null)
              ? Text('Update note')
              : Text('Add new note')),
      body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              /*
                If the id is not null, this means we can update
                the item.  Otherwise the button will show 'Add'
               */
              RaisedButton(
                color: Colors.lightGreen,
                child: (widget.note.id != null)
                    ? Text(
                        'Update',
                        style: TextStyle(color: Colors.black),
                      )
                    : Text('Add',
                        style: TextStyle(color: Colors.black),),
                onPressed: () {
                  if (widget.note.id != null) {
                    db
                        .updateNote(Note.fromMap({
                      'id': widget.note.id,
                      'title': _titleController.text,
                      'description': _descriptionController.text
                    }))
                        .then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db
                        .saveNote(Note(
                            _titleController.text, _descriptionController.text))
                        .then((_) {
                      Navigator.pop(context, 'save');
                    });
                  }
                },
              ),
            ],
          )),
    );
  }
}
