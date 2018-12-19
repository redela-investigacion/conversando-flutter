import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterTts flutterTts;
  var textController = new TextEditingController();

  @override
  initState() {
    super.initState();
    flutterTts = new FlutterTts();
  }

  Future _speak() async {
    print(textController.text);
    await flutterTts.speak(textController.text);
  }

  void _onChange(String text) {
    setState(() {
      textController.text = text;
    });
  }

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
            body: Builder(
              builder: (context) =>
                new TabBarView(
                  children: [
                    //Composer
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              controller: textController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tu texto aquí'
                              ),
                              onChanged: (String value) {
                                _onChange(value);
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.keyboard),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.undo),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: () {},
                                  ),
                                  Expanded(
                                    child:
                                      FloatingActionButton(
                                        child: Icon(Icons.volume_up),
                                        backgroundColor: Colors.pink,
                                        onPressed: () {
                                          _speak();

                                          final snackBar = SnackBar(
                                            content: Text("Diciendo: ${textController.text}"),
                                            action: SnackBarAction(
                                              label: 'Reproducir de nuevo',
                                              onPressed: () {
                                                _speak();
                                              },
                                            ),
                                          );

                                          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                                          Scaffold.of(context).showSnackBar(snackBar);

                                        }
                                      ),
                                  )
                                ]
                            )
                          ),
                          ExpansionTile(
                            //key: PageStorageKey<Entry>(root),
                            title: Text('Categorías de frases'),
                            children: [
                              ExpansionTile(
                                title: Text('😍 Saludos'),
                                children: [
                                  new CustomListTile(this, 'Hola'),
                                  new CustomListTile(this, '¿Qué pasa?'),
                                ],
                              ),
                              ExpansionTile(
                                title: Text('🌎 En casa'),
                                children: [
                                  new CustomListTile(this, '¿Puedes subir el volumen de la televisión?'),
                                  new CustomListTile(this, 'Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?'),
                                  new CustomListTile(this, 'Por favor, traeme un vaso de agua')
                                ],
                              ),
                              ExpansionTile(
                                title: Text('😙 Cosas que me gustan'),
                                children: [
                                ],
                              ),
                              ExpansionTile(
                                title: Text('🌐 Preguntas'),
                                children: [
                                ],
                              ),

                            ],
                          ),
                        ]
                      ),
                    ),
                    new GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: <Widget>[
                        new RaisedButton(
                            child: new Text("Sí"),
                            onPressed: () {flutterTts.speak("Sí");}),
                        new RaisedButton(
                            child: new Text("No"),
                            onPressed: () {flutterTts.speak("No");}),
                        new RaisedButton(
                            child: new Text("Hola"),
                            onPressed: () {flutterTts.speak("Hola");}),
                        new RaisedButton(
                            child: new Text("¿Cómo estás?"),
                            onPressed: () {flutterTts.speak("¿Cómo estás?");}),
                        new RaisedButton(
                            child: new Text("Bien"),
                            onPressed: () {flutterTts.speak("Bien");}),
                        new RaisedButton(
                            child: new Text("Gracias"),
                            onPressed: () {flutterTts.speak("Gracias");}),
                      // 4 Text Fields here
                      ]
                    ),
                    new Text("TODO SETTINGS"),
                  ],
          ),
          )
        ),
      )
    );
  }
}

class CustomListTile extends StatelessWidget {
  String _text;
  _MyAppState _appState;

  CustomListTile(this._appState, this._text);

  @override
  Widget build(context) {
    return new ListTile(
        title: Text(this._text),
        onTap: () {
          this._appState.setState(() {
            this._appState._onChange(this._text);
          });
        }
    );
  }
}