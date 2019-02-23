import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}//MyCustomForm

class MyCustomFormState extends State<MyCustomForm> {
  //Create a global key that lets us uniqely identify the form widget and allow
  //us to validate the form.

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Build a Form widget using the global key (_formKey) created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Form to type in
          TextFormField(
            validator: (value){
              if (value.isEmpty){
                return "Please enter a text";
              }//if
            }, //validator
          ),
          //Padding for RaisedButton
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                //Validate if true will return
                //else form is invalid
                if (_formKey.currentState.validate()) {
                  //if true show snackbar
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(
                    "Processing Data")));
                }//if
              },
              child: Text("Submit"),
            )
          )
        ],
      )
    );
  }
}