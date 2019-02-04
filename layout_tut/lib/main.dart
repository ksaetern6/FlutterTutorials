import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*
     * name: titleSection
     * type: Widget
     * desc: First Column that displays the title of the Campground and Country
     */
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*
            *putting a column inside an expanded widget stretches the column
            to use all remaining free space in the row.
            *setting crossAxisAlignment to CrossAxisAlignment.start positions
            * the column at the start of the row.
             */
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                *putting first row of text inside a container enables padding
                the second child in the column also displays as grey
                 */
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Kandersteg Swizterland',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ))
              ],
            ),
          ),
          /*
          *last two items in the title row are star icons painted red and text
          '41'. The entire row is in a Container and padded along each edge by
          32 pixels.
           */
          FavoriteWidget(),
        ], //children
      ),
    );

    Color color = Theme.of(context).primaryColor;
    /*
     * name: buttonSection
     * type: Widget
     */
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ], //children
      ),
    );

    /*
     * name: textSection
     * type: Widget
     * desc: Container contains the description on the page.
     */
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    /*
     * return MaterialApp
     */
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Layout Demo'),
        ),
        /*
         * List view supports scrolling when the screen is small.
         */
        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }//build

  /*
   * function adds icon directly to the column
   */
  Column _buildButtonColumn(Color color, IconData icon, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }//_buildButtonColumn

}//MyApp class

/*
 * name: FavoriteWidget
 * type: class
 * desc: public class call to create a FavoriteWidget object.
 */
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
/*
 * name: _FavoriteWidgetState
 * type: class
 * desc: class that creates the favorite star button inside of a Row. The row
 * uses a Container to pad the size and then uses a button that calls the
 * _isFavorite to change the state of the widget.
 */
class _FavoriteWidgetState extends State<FavoriteWidget> {

  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            /*
            _toggleFavorite changes the state of the IconButton when pressed.
            Changes state by calling setState()
             */
            onPressed: _toggleFavorite,
          ),
        ),
        /*
        SizedBox makes it so there isn't a discernible 'jump' when changing numbers.
         */
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
  /*
   * name: _toggleFavorite
   * type: void
   * desc: Changes the state of the _isFavorited variable and the number of
   * _favoriteCount. Changes the state of the widget by setting the setState()
   * function.
   */
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited){
        _favoriteCount -=1;
        _isFavorited = false;
      }//if
      else {
        _favoriteCount += 1;
        _isFavorited = true;
      }//else
    }); //setState
  }//toggleFavorite

}