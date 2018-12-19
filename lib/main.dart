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
    // We're just going to wrap the entire app in our Inherited Widget.
    // This way, every widget in the app will have access to the data.
    final _tts = new FlutterTts();
    final speak = (String text, BuildContext ctx) {
      _tts.speak(text);

      final snackBar = SnackBar(
        content: Text("Diciendo: ${text}"),
        action: SnackBarAction(
          label: 'Reproducir de nuevo',
          onPressed: () {
            _tts.speak(text);
          },
        ),
      );
      Scaffold.of(ctx).showSnackBar(snackBar);
    };

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

    return TextContext(
      speak: speak,
      child: MaterialApp(
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
