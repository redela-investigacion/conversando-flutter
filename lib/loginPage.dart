import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: const EdgeInsets.only(top: 70, right: 30, bottom: 30, left: 30),
        color: Theme.of(context).backgroundColor,
        child: new Column(
          children: [
            new Column(
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                new SizedBox(height: 20.0),
                new Text(
                  'Conversando',
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                new Text(
                  'Tu ayuda para volver a hablar',
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 15.0
                  )
                )
              ]
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new OutlineLoginButton(
                    text: 'ÚNETE CON TU EMAIL',
                    icon: null,
                    onPressed: () {print ('#TODO Registro con email');}
                  ),
                  new OutlineLoginButton(
                    text: 'CONTINUA CON FACEBOOK',
                    icon: FontAwesomeIcons.facebook,
                    onPressed: () {print ('#TODO Registro con Facebook');}
                  ),
                  new OutlineLoginButton(
                    text: 'CONTINUA CON GOOGLE',
                    icon: FontAwesomeIcons.google,
                    onPressed: () {print ('#TODO Registro con Google');}
                  ),
                  new FlatLoginButton(
                    text: '¿Tienes una cuenta? Log in',
                    icon: null,
                    onPressed: () {print ('#TODO Login');}
                  ),
                  new FlatLoginButton(
                    text: 'Continuar sin identificarte',
                    icon: null,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }
}


class OutlineLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  OutlineLoginButton({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: new OutlineButton(
        color: Color(0xFFFDA05D),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(3.0)),
        child:new Container(
          padding: const EdgeInsets.all(8),
          child: new Row(
            children: [
              (
                this.icon != null
                  ? new Icon(this.icon, color: Colors.white, size: 18.0)
                  : new SizedBox(width: 18.0)
              ),
              new Expanded(
                child: new Text(
                  this.text,
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white)
                )
              ),
              new SizedBox(width: 18.0),
            ]
          )
        ),
        onPressed: this.onPressed,
      )
    );
  }
}

class FlatLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  FlatLoginButton({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new FlatButton(
        color: Color(0xFFFDA05D),
        child:new Container(
          padding: const EdgeInsets.all(8),
          child: new Row(
            children: [
              (
                this.icon != null
                  ? new Icon(this.icon, color: Colors.white, size: 18.0)
                  : new SizedBox(width: 18.0)
              ),
              new Expanded(
                child: new Text(
                  this.text,
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.white)
                )
              ),
              new SizedBox(width: 18.0),
            ]
          )
        ),
        onPressed: this.onPressed,
      )
    );
  }
}