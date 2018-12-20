import 'package:flutter/material.dart';
import 'package:conversando/composer.dart';
import 'package:conversando/speaker.dart';
import 'package:conversando/context.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabBar = Builder(
      builder: (scaffoldContext) =>
        new TabBarView(
          children: [
            //Composer
            new ComposerWidget(),
            new SpeakerWidget(),
            new Text("TODO SETTINGS"),
            ],
          )
        );

    return TextContextWidget(
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Roboto'),
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
                  backgroundColor: Colors.cyan,
                ),
                body: new TabBarView(
                  children: [
                    //Composer
                    new ComposerWidget(),
                    new SpeakerWidget(),
                    new Text("TODO SETTINGS"),
                  ],
                ),
              )
          )
      )
    );
  }
}