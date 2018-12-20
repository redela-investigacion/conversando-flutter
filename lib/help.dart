import 'package:flutter/material.dart';

class HelpWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Ayuda"),
      ),
      body: ListView(children: [
        new ListTile(
          title: Text("Componer", style: TextStyle(fontSize: 20)),
          subtitle: Text("Escribe lo que quieras comunicar"),
        ),
        new ListTile(
          title: Text("Pulsa el altavoz para hablar", style: TextStyle(fontSize: 15.0)),
          leading: Container(
            constraints: BoxConstraints.expand(height: 30.0, width: 25.0),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: FloatingActionButton(
              heroTag: "speakIcon",
              child: Icon(Icons.volume_up, color: Colors.white, size: 10.0,),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: null,
            )
          )
        ),
        new ListTile(
          title: Text("Selecciona una de tus frases guardadas para editarla antes de hablar", style: TextStyle(fontSize: 15.0)),
          leading: Container(
            constraints: BoxConstraints.expand(height: 30.0, width: 25.0),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: FloatingActionButton(
              heroTag: "listPhrasesIcon",
              child: Icon(Icons.apps, color: Colors.white, size: 10.0,),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: null,
            )
          )
        ),
        new ListTile(
          title: Text("Descarta tu frase cuando ya no la necesites", style: TextStyle(fontSize: 15.0),),
          leading: Icon(Icons.close, color: Colors.red, size: 25.0,)
        ),
        new ListTile(
          title: Text("Guarda la frase actual en una categoría", style: TextStyle(fontSize: 15.0),),
          leading: Icon(Icons.save, color: Theme.of(context).primaryColor, size: 25.0,)
        ),
        new ListTile(
        title: Text("Hablar", style: TextStyle(fontSize: 20)),
        ),
        new ListTile(
          title: Text("Toca una palabra o frase para decirla en voz alta", style: TextStyle(fontSize: 15.0),),
        )
      ])
    );
  }
}
