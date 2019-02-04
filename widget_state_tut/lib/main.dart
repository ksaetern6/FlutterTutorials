import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//------------------------- TapboxA ----------------------------------
 /*
  * name: TapboxA
  * type: class
  * desc: public call
  */
 class TapboxA extends StatefulWidget {

   TapboxA({Key key}) : super(key: key);

   @override
   _TapboxAState createState() => _TapboxAState();
 }

 /*
  * name: _TapboxAState
  * type: class
  * desc:
  */
 class _TapboxAState extends State<TapboxA> {

   bool _active = false;

   /*
    * name: _handTap()
    * type: void
    * desc: function changes the boolean variable _active
    */
   void _handleTap() {
     setState(() {
       _active = !_active;
     });
   }//_handTap

  /*
   * name: build
   * type: Widget
   * desc: Widget builds the two boxes and calls on _handleTap when pressed on
   * screen using the GestureDetector function.
   */
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}


//------------------------- MyApp ----------------------------------
/*
 * main()
 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}

