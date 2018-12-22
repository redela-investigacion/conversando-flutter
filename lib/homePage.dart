import 'package:Conversando/settings.dart';
import 'package:flutter/material.dart';
import 'package:Conversando/composer.dart';
import 'package:Conversando/speaker.dart';

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
                  indicatorColor: Colors.white,
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
              new ComposerWidget(),
              new SpeakerWidget(),
              new SettingsWidget(),
            ],
          ),
        )
    );
  }
}