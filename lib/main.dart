import 'package:conversando/settings.dart';
import 'package:flutter/material.dart';
import 'package:conversando/composer.dart';
import 'package:conversando/speaker.dart';
import 'package:conversando/context.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextContextWidget(
      child: MaterialApp(
          theme: ThemeData(fontFamily: "Roboto").copyWith(
            primaryColor: Colors.cyan,
          ),
          home: new DefaultTabController(
              length: 3,
              child: new Scaffold(
                appBar: new AppBar(
                  flexibleSpace: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new TabBar(
                        labelStyle: new TextStyle(fontSize: 18.0),
                        tabs: [
                          Tab(text: "Componer"),
                          Tab(text: "Hablar"),
                          Tab(text: "Ajustes"),
                        ],
                      ),
                    ],
                  ),
                ),
                body: new TabBarView(
                  children: [
                    //Composer
                    new ComposerWidget(),
                    new SpeakerWidget(),
                    new SettingsWidget(),
                  ],
                ),
              )
          )
      )
    );
  }
}
