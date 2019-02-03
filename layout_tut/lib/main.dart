import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*
     * name: titleSection
     * type: Widget
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
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ], //children
      ),
    );

    Color color = Theme.of(context).primaryColor;
    /*
     * name:
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
     * return MaterialApp
     */
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Layout Demo'),
        ),
        body: Column(
          children: [
            titleSection,
            buttonSection,
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
