
class Note {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  //[this._description] means this is optional
  Note(this._title, this._date, this._priority, [this._description]);

  //named constructor
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  //getters
  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get priority => _priority;

  //setters
  set title(String newTitle){
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription){
    if (newTitle.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority){
    if (newPriority >=1 && newPriority <=2){
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //convert a Note object to a Map object
  //String = key type, dynamic = works for both int and String types
  Map<String, dynamic> toMap() {

    //empty map object
    var map = Map<String, dynamic>();
    //null id = update, else its an insert
    if (id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //Extract Note object from Map object
  //named Note constructor that takes map as a parameter and creates instance
  //of note object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}
