
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              new Text("TODO COMPONER"),
              new Text("TODO SPEAK"),
              new Text("TODO SETTINGS"),
            ],
          ),
        ),
      )
    );
  }
}

