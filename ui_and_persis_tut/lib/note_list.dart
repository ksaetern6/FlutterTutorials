import 'package:flutter/material.dart';
import 'note_detail.dart';
import 'package:ui_and_persis_tut/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui_and_persis_tut/utils/database_helper.dart';

class NoteList extends StatefulWidget {

  @override
  NoteListState createState() => NoteListState();
  /*
   State<StatefulWidget> createState() {
    return NoteListState();
  }
   */
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    //if noteList is null instantiate it.
    if (noteList == null){
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),

      body: getNoteListView(),

      //floatingActionButton
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("FAB clicked");
            navigateToDetail(Note('','',  2), "Add Note");
          },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriority(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            title: Text(this.noteList[position].title, style: titleStyle,),

            subtitle: Text(this.noteList[position].date),

            //Using onTap inside of a widget we need to wrap inside
            //GestureDetector
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),

            onTap: () {
              debugPrint("ListTitle Tapped");
              navigateToDetail(this.noteList[position], "Edit Note");
            },
          )
        );
      },
    );


  }//getNoteListView

  //Returns priority color
  Color getPriority(int priority){
    switch(priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }//getPriority

  //Return priority Icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }//switch
  }//getPriorityIcon

  //delete
  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0){
      _showSnackBar(context, 'Note Successfuly Deleted');
      updateListView();
    }
  }

  //showSnackBar
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


  void navigateToDetail(Note note, String title) async {
    //result is taken from Navigator.pop function
    //databaseHelper.deleteDB();
    bool result  = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }//navigateToDetail

  void updateListView() {
    //singleton instance of our database
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        //update ui with setState
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

}//NoteListState