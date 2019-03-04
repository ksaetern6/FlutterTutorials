import "package:flutter/material.dart";
import "package:ui_and_persis_tut/models/note.dart";
import "package:ui_and_persis_tut/utils/database_helper.dart";
import "package:intl/intl.dart";

class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  //constructor to pass Scaffold Title based on button click
  NoteDetail(this.note, this.appBarTitle);

  @override
  NoteDetailState createState() => NoteDetailState(this.note, this.appBarTitle);
}

class NoteDetailState extends State<NoteDetail>{

  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  //control values entered by the User
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //Constructor
  NoteDetailState(this.note, this.appBarTitle);
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    /*
    We wrap everything in WillPopScope so the page can pop off the Stack
    when pressing the back button and to control how we can navigate backwards
     */
    return WillPopScope(

      onWillPop: () {
        //Write some code when user presses back nav bar on device
        moveToLastScreen();
      },

      child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon: Icon(
          Icons.arrow_back),
            onPressed: () {
              //Write some code when user presses back nav bar in AppBar
              moveToLastScreen();
            })
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: ListView(
          children: <Widget>[
            //first element: ListTile
            ListTile(
              title: DropdownButton(
              //-------------------------------------------------
                items: _priorities.map((String dropDownStringItem) {
                  return DropdownMenuItem<String> (
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                  );
                }).toList(),

                style: textStyle,

                value: getPriorityAsString(note.priority),

                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint("User Selected $valueSelectedByUser");
                    updatePriorityAsInt(valueSelectedByUser);
                  });
                }, //onChanged
              ),
              //-----------------------------------------------
            ),
            //Second Element:
            //-------------------------------------------------
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint("Something Changed in the Title Text Field");
                  UpdateTitle();
                },
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
              ),
            ),
            //-------------------------------------------------

            //Third Element
            //-------------------------------------------------
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint("Something Changed in the Description Text Field");
                  UpdateDescription();
                },
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
              ),
            ),
            //------------------------------------------------
            //Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  //1st element of Row
                  //Wrapped in Expanded so they're in equal space
                  //Save button
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Save",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save Button Clicked");
                          _save();
                        });
                      },//onPressed
                    ),
                  ),

                  //Container added for spacing between buttons
                  Container(width: 5.0,),

                  //Second Element
                  //Delete button
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete Button Clicked");
                            _delete();
                          });
                        },//onPressed
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    ));
  }//build

  void moveToLastScreen() {
    //pops the previous screen on the stack
    //Second parameter of 'pop()' is returned to the last screen
    Navigator.pop(context, true);
  }//moveToLastScreen

  //Convert string priority to int to save to databse
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }//updatePriorityAsInt

  //convert int priority to string value and display to ui
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; //High
        break;
      case 2:
        priority = _priorities[1]; //Low
        break;

    }
    return priority;
  }// getPriorityAsString

  //update title
  void UpdateTitle() {
    note.title = titleController.text;
  }

  //update description
  void UpdateDescription() {
    note.description = descriptionController.text;
  }

  //Save data to database
  void _save() async {

    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    //update operation
    if (note.id != null) {
      result = await helper.updateNote(note);
    }
    //else insert operation
    else {
      result  = await helper.insertNote(note);
    }

    //check if successful or failure
    if (result != 0){ //Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    }
    else { //Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }//_save

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }//_showAlertDialog

  void _delete() async {

    //navigate to last screen
    moveToLastScreen();

    //Case 1: if user is trying to delete the NEW NOTE, i.e has come to
    //the detail page by pressing FAB of NoteListPage
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }


    //Case 2: user is trying to delete old note with a valid ID
    int result = await helper.deleteNote(note.id);

    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    }
    else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }
}