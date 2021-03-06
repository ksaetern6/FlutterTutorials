import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //grey highlight means unused

//Use Arrow Notation for one-line functions or methods.
void main() => runApp(MyApp());

/*
  class name: RandomWordsState
 */
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    /*
    name: build
     */
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
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
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ), //Text
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ), //Icon
      onTap: () {
        setState (() {
          if (alreadySaved) {
            _saved.remove(pair);
          }
          else {
            _saved.add(pair);
          }
        }); //setState
      }, //onTap
    );
  }

  /*
  name: _pushSaved
  desc: used for app bar, Navigator Stack
   */
  void _pushSaved() {
    /*
     * pushes the route to the Navigator Stack
     */
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                ),
              ); //ListTile
            },//WordPair
          );
          final List<Widget> divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
          )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ), //appBar
            body: new ListView(children: divided),
          ); //Scaffold
        },
      ),
    );
  } //_pushSaved()
}//RandomWordsState

/*
 * name: RandomWords
 * type: class
 * desc:
 *  extends StatefulWidget meaning class RandomWords is a subclass of Stateful Widget
 *  Stateful Widget:
 *    *State can be read Synchronously when the widget is built and can change
 *     during the lifetime of the widget.
 *     *Stateful Widgets are useful when interface needs to change dynamically (internal clock)
 *  creates a mutable(changeable) state of type RandomWordsState and passes in a new object
 *  of RandomWordsState into the new state.
 */
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
    return new MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
        home: RandomWords(),
      );
  }
}
