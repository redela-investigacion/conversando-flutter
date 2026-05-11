import 'package:flutter/material.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Componer', style: TextStyle(fontSize: 20)),
            subtitle: Text('Escribe lo que quieras comunicar'),
          ),
          ListTile(
            title: const Text('Pulsa el altavoz para hablar',
                style: TextStyle(fontSize: 15.0)),
            leading: Container(
              constraints:
                  const BoxConstraints.expand(height: 30.0, width: 25.0),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FloatingActionButton(
                heroTag: 'speakIcon',
                backgroundColor: Colors.deepOrangeAccent,
                onPressed: null,
                child: const Icon(Icons.volume_up,
                    color: Colors.white, size: 10.0),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Selecciona una de tus frases guardadas para editarla antes de hablar',
              style: TextStyle(fontSize: 15.0),
            ),
            leading: Container(
              constraints:
                  const BoxConstraints.expand(height: 30.0, width: 25.0),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FloatingActionButton(
                heroTag: 'listPhrasesIcon',
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: null,
                child:
                    const Icon(Icons.apps, color: Colors.white, size: 10.0),
              ),
            ),
          ),
          const ListTile(
            title: Text('Descarta tu frase cuando ya no la necesites',
                style: TextStyle(fontSize: 15.0)),
            leading: Icon(Icons.close, color: Colors.red, size: 25.0),
          ),
          ListTile(
            title: const Text('Guarda la frase actual en una categoría',
                style: TextStyle(fontSize: 15.0)),
            leading: Icon(Icons.save,
                color: Theme.of(context).colorScheme.primary, size: 25.0),
          ),
          const ListTile(
            title: Text('Hablar', style: TextStyle(fontSize: 20)),
          ),
          const ListTile(
            title: Text(
                'Toca una palabra o frase para decirla en voz alta',
                style: TextStyle(fontSize: 15.0)),
          ),
        ],
      ),
    );
  }
}
