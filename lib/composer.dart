import 'package:Conversando/selectPhrase.dart';
import 'package:flutter/material.dart';
import 'package:Conversando/context.dart';
import 'package:Conversando/composerField.dart';
import 'package:Conversando/savePhrase.dart';
import 'package:share/share.dart';

class ComposerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return Stack(children: [
      Container(
        child: Column(children: [
          // TextEditor
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 100.0, left: 10.0),
              child: new ComposerFieldWidget())
          ),
          // Actions bar
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
                child: Row(children: [
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.red, disabledColor: Color(0xFFD2D2D2),
                onPressed: tc.getWords().length == 0 ? null : () {
                  tc.clearText();
                  tc.clearWords();
                }
              ),
              /*
              IconButton(
                icon: Icon(Icons.undo),
                color: Colors.black54,
                onPressed: () {},
              ),*/
              IconButton(
                icon: Icon(Icons.share),
                color: Colors.grey,
                disabledColor: Color(0xFFD2D2D2),
                onPressed: tc.getWords().length == 0 ? null : () {
                  Share.share(tc.getTextPhrase());
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                color: Theme.of(context).primaryColor,
                disabledColor: Color(0xFFD2D2D2),
                onPressed: tc.getTextPhrase().length == 0 ? null : () {
                  _navigateAndDisplaySelection(context);
                }
              )
            ])),
          ])
      ])),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // Phrases list button
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: 'listPhrasesButton',
              child: Icon(Icons.apps),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => FullPagePhraseSelector());
                Navigator.push(context, route);
              },
            ),
          ),
          // Speak button
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: 'speakButton',
              child: Icon(Icons.volume_up),
              backgroundColor:tc.getTextPhrase().length != 0
                  ? Theme.of(context).backgroundColor
                  : Color(0xFFD2D2D2),
              onPressed:tc.getTextPhrase().length == 0 ? null : () {
                tc.speak(tc.getTextPhrase(), context);
              }
            ),
          )
        ])
      ]),
    ]);
//        new PhraseSelectorWidget(this._tts),
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    Route route = MaterialPageRoute(builder: (context) => SavePhrase());

    final result = await Navigator.push(
      context,
      route
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    if (result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Guardado: $result")));
    }
  }
}
