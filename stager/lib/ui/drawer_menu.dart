/*
  drawer_menu.dart
  Show the drawer with several options
  Version 0.0.1
*/

import 'package:flutter/material.dart';
import '../dbutil/databasehelper.dart';
//import '../ui/listview_notes.dart';
import '../ui/delete_scans.dart';
import '../ui/scan_history.dart';

class DrawerPage extends StatelessWidget {
  final DatabaseHelper db = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('DIS Qr Inventory System',
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
            accountEmail: Text('Version 0.0.1',
              style: new TextStyle(fontSize: 15.0, color: Colors.white)),
            decoration: BoxDecoration(color: Colors.lightGreen,
              //image: new DecorationImage(image: AssetImage("assets/qrlogo.png"), alignment: Alignment.centerLeft)
              image: new DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/bground.jpg"))
            ),
          ),
          ListTile(
              title: Text('View scan history'),
              trailing: Icon(Icons.view_list, color: Colors.lightGreen),
              onTap: () {
                // Get rid of the drawer
                Navigator.of(context).pop(context);
                // Show the scan history tablef
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanHistory(),));
              }),
          ListTile(
            title: Text('Send via email...'),
            trailing: Icon(Icons.email, color: Colors.lightGreen),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.white),
          ListTile(
              title: Text('Delete scan history!',style: new TextStyle(fontStyle: FontStyle.italic, color: Colors.red[200])),
              trailing: Icon(Icons.delete_forever, color: Colors.red,),
              onTap: () {
                _deleteAllScans(context);
                print("Kilroy was Here!");
              }),
          Divider(color: Colors.white),
          ListTile(
              title: Text('Close menu'),
              trailing: Icon(Icons.cancel, color: Colors.green[200]),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  void _deleteAllScans(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeleteScansScreen()),
    );
    if (result == 'deleted') {
      print("Records deleted");
    }
  }
}
