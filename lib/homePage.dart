import 'package:conversando/settings.dart';
import 'package:flutter/material.dart';
import 'package:conversando/composer.dart';
import 'package:conversando/speaker.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
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
    );
  }
}