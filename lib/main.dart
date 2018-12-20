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
                    new SettingsWidget(),
                  ],
                ),
              )
          )
      )
    );
  }
}
