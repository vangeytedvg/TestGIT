/*
 * Note.dart
 * DIS Datamodel
 * Version 0.0.1
 */

class Note {
  int _id;
  String _title;
  String _description;

  // Constructor taking parameters and setting the property values
  Note(this._title, this._description);

  // Map the values from the db to the properties
  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
  }

  // Get the values from the properties
  int get id => _id;
  String get title => _title;
  String get description => _description;

  // Map our properties
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
  }
}
