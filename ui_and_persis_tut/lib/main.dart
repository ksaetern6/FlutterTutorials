import 'package:flutter/material.dart';
import 'note_list.dart'; //NoteList
import 'note_detail.dart'; //NoteDetail

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "NoteKeeper",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      //
      home: NoteList(),
    );
  }
}
