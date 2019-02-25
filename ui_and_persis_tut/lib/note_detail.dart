import "package:flutter/material.dart";

class NoteDetail extends StatefulWidget {
  
  @override
  NoteDetailState createState() => NoteDetailState();
}

class NoteDetailState extends State<NoteDetail>{

  static var _priorities = ['High', 'Low'];
  //control values entered by the User
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit note"),
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

                value: "Low",

                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint("User Selected $valueSelectedByUser");
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
                        });
                      },//onPressed
                    )
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

    );
  }
}