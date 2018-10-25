import 'package:flutter/material.dart';
import 'dbutil/databasehelper.dart';
import 'model/note.dart';

void main() => runApp(MaterialApp(
      title: 'Big App',
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
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Get all the stored
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
      print(items.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hallo Cards"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    child: new Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("'${items[position].title}',"),
                              ],
                            ),
                          ],
                        ),
                         Row(
                          children: <Widget>[
                            Text("'${items[position].title}',"),
                           
                          ],
                        ),
                        Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.edit),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
