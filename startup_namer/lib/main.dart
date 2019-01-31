import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //grey highlight means unused

//Use Arrow Notation for one-line functions or methods.
void main() => runApp(MyApp());

/*
  class name: RandomWordsState
 */
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

    /*
    name: build
     */
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }//build
  /*
    name: _buildSuggestions

   */
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i){
        if (i.isOdd) return Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index]);
      });
  }

  /*
  name: _buildRow
   */
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}//RandomWordsState

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}//RandomWords

//app extends Stateless Widget, makes the app itself a widget.
//In flutter almost everything is a widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Function returns a Material App
    return MaterialApp(
        title: 'Startup Name Generator',
        home: RandomWords(),
      );
  }
}
