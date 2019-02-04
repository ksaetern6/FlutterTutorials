import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());
/*

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
*/

//------------------------ ParentWidget --------------------------------
/*
 * name: ParentWidget
 * type: class
 * desc:
 */
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

/*
   * name: _ParentWidgetState
   * type: class
   * desc:
   */
class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  /*
     * name: _handleTapboxChanged
     * type: void
     * desc: set _active variable to newValue
     */
  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  } // _handleTapboxChanged

  /*
     * name: build
     * type: Widget
     * desc:
     */
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }

} // _ParentWidgetState

//------------------------- TapboxB ----------------------------------

/*
 *
 */
class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  /*
   * name: _handleTap
   * type: void
   * desc:
   */
  void _handleTap() {
    onChanged(!active);
  } //_handleTap
    /*
     * name: build
     * type: Widget
     * desc:
     */
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
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
          //child: TapboxA(),
          //change to TapboxA to use prev version.
          child: TapboxB(),
        ),
      ),
    );
  }
}
