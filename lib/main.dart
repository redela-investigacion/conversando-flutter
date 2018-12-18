import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _newVoiceText = "";
  FlutterTts flutterTts;

  @override
  initState() {
    super.initState();
    flutterTts = new FlutterTts();
  }

  Future _speak() async {
    await flutterTts.speak(_newVoiceText);
  }


  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            flexibleSpace: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new TabBar(
                  tabs: [
                    Tab(text: "COMPONER"),
                    Tab(text: "HABLAR"),
                    Tab(text: "AJUSTES"),
                  ],
                ),
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              new TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tu texto aquí'
                ),
                onChanged: (String value) {
                  _onChange(value);
                },
              ),
              new Text("TODO SPEAK"),
              new Text("TODO SETTINGS"),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.volume_up),
            backgroundColor: Colors.pink,
            onPressed: _speak,
          ),
          bottomNavigationBar: BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.keyboard),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.undo),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

