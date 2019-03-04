import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io'; //deals with files and folders
import 'package:path_provider/path_provider.dart';
import 'package:ui_and_persis_tut/models/note.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  //Singleton = this instance will only be initalized once throughout the
  //application
  static DatabaseHelper _databaseHelper; //Singleton DatabaseHelper
  static Database _database;            //Singleton database

  //Note table
  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  //named constructor to create instance of DatabaseHelper
  DatabaseHelper._createInstance();

  //factory lets constructor return a value, this instance is _databaseHelper
  factory DatabaseHelper(){

    //only create instance of databaseHelper if it is null
    //means this is only executed once throughout our application
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); //executed once, singleton object
    }
    return _databaseHelper;
  }

  //whenever we get the database it will initialize it if its not created
  //else it will return the database
  Future<Database> get database async {

    if (_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    //Get directory path for both Android and iOS to store database;
    Directory directory = await getApplicationDocumentsDirectory(); //path_provider package
    String path = directory.path + 'notes.db';


    //Open/Create database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }
  
  //execute statement to create database
  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //Fetch Operations: Get all note objects from database
  //return type is a List of Maps
  Future<List<Map<String,dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    //both statements are the same, first statement is using the raw query
    //second statement is using a function defined in sqflite (Helper function)
    //var result  = await db.rawQuery('SELECT * FROM  $noteTable'
      //  'ORDER BY $colPriority ASC');
    var result  = await db.query(noteTable, orderBy: '$colPriority ASC');

    return result;
  }

  //Insert Operations: Insert a Node object and save it to the database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;

    //var result = await.db.rawQuery('INSERT INTO $noteTable ')
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    var db = await this.database;

    //var result = await.db.rawQuery('UPDATE $noteTable SET ')
    var result = await db.update(noteTable, note.toMap(),
    where: '$colId = ?', whereArgs: [note.id]);

    return result;
  }

  //Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) '
        'FROM $noteTable');
    //Takes first int value in List x (which is one value from count)
    int result = Sqflite.firstIntValue(x);

    return result;
  }

  //get the 'Map List' and convert it to 'Note List'
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // get mapList from database
    int count = noteMapList.length; // count the number of map entries in db table

    List<Note> noteList = List<Note>();

    //for loop populates noteList from 'Map list'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
  void deleteDB() async {
    var databaseDirectory = await getApplicationDocumentsDirectory();
    String path  = databaseDirectory.path + 'notes.db';
    await deleteDatabase(path);
  }
}
