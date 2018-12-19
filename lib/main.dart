import 'package:flutter/material.dart';
import 'package:conversando/composer.dart';
import 'package:conversando/speaker.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  FlutterTts _tts;

  MyAppState() {
    _tts = new FlutterTts();
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
                  //Composer
                  new ComposerWidget(_tts),
                  new SpeakerWidget(_tts),
                  new Text("TODO SETTINGS"),
                ],
              ),
            )));
  }
}
