import 'package:conversando/editPhrase.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile (
        title: Text("María de Antón"),
        subtitle: Text("estoesunmail@gmail.com"),
        leading: Icon(Icons.account_circle, color: Colors.cyan, size: 24.0),
        onTap: () {
//            Route route = MaterialPageRoute(
//              builder: (context) => LoginWidget());
//            Navigator.push(context, route);
        },
      ),
      ListTile (
        title: const Text("Mis frases"),
        leading: Icon(Icons.chat, color: Colors.cyan, size: 24.0),
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => PhraseEditorWidget());
          Navigator.push(context, route);
        },
      ),
      ListTile (
        title: Text("Ajustes de voz"),
        leading: Icon(Icons.keyboard_voice, color: Colors.cyan, size: 24.0),
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => VoiceSettingsWidget());
          Navigator.push(context, route);
        },
      ),
      ListTile (
        title: Text("Tamaño de fuente"),
        leading: Icon(Icons.format_size, color: Colors.cyan, size: 24.0),
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => FontSettingsWidget());
          Navigator.push(context, route);
        },
      ),
      ListTile (
        title: Text("Ayuda"),
        leading: Icon(Icons.help, color: Colors.cyan, size: 24.0),
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => HelpWidget());
          Navigator.push(context, route);
        },
      )]);
  }
}

class VoiceSettingsWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.cyan, title: Text("Ajustes de voz")),
      body: Column(children: [])
    );
  }
}

class FontSettingsWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.cyan, title: Text("Tamaño de fuente")),
      body: Column(children: [])
    );
  }
}

class HelpWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.cyan, title: Text("Ayuda")),
      body: Column(children: [ new Text("Ayudaaaaaarggg")])
    );
  }
}
