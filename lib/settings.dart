import 'package:Conversando/commons.dart';
import 'package:Conversando/managePhrase.dart';
import 'package:Conversando/help.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      new SettingsMenuOptionWidget (
        title: "María de Antón",
        subtitle: "estoesunmail@gmail.com",
        icon: Icons.account_circle,
        onTap: () {
//            Route route = MaterialPageRoute(
//              builder: (context) => LoginWidget());
//            Navigator.push(context, route);
        },
      ),
      Divider(),
      new SettingsMenuOptionWidget(
        title: "Mis frases",
        subtitle: "Gestiona tus frases y categorías",
        icon: Icons.chat,
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => CategoryManagerWidget());
          Navigator.push(context, route);
        },
      ),
      new SettingsMenuOptionWidget(
        title: "Ajustes de voz",
        icon: Icons.keyboard_voice,
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => VoiceSettingsWidget());
          Navigator.push(context, route);
        },
      ),
      new SettingsMenuOptionWidget(
        title: "Tamaño de fuente",
        icon: Icons.format_size,
        onTap: () {
          Route route = MaterialPageRoute(
            builder: (context) => FontSettingsWidget());
          Navigator.push(context, route);
        },
      ),
      new SettingsMenuOptionWidget(
        title: "Ayuda",
        icon: Icons.help,
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
      appBar: new AppBar(
        title: Text("Ajustes de voz"),
        actions: <Widget>[
          new ActionBarButtonWidget("GUARDAR", () { Navigator.pop(context);})
        ]
      ),
      body: Column(children: [])
    );
  }
}

class FontSettingsWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Tamaño de fuente"),
        actions: <Widget>[
          new ActionBarButtonWidget("GUARDAR", () { Navigator.pop(context);})
        ]
      ),
      body: Column(children: [])
    );
  }
}

class SettingsMenuOptionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  SettingsMenuOptionWidget({this.title, this.subtitle, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile (
      title: Text(this.title),
      subtitle: this.subtitle != null ? Text(this.subtitle) : null ,
      leading: Icon(this.icon, color: Theme.of(context).primaryColor, size: 24.0),
      onTap: this.onTap,
    );
  }

}

