import 'package:flutter/material.dart';
import 'package:conversando/composer.dart';
import 'package:conversando/speaker.dart';
import 'package:conversando/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.edit), text: 'COMPONER'),
              Tab(icon: Icon(Icons.volume_up), text: 'HABLAR'),
              Tab(icon: Icon(Icons.settings), text: 'AJUSTES'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ComposerWidget(),
            SpeakerWidget(),
            SettingsWidget(),
          ],
        ),
      ),
    );
  }
}
