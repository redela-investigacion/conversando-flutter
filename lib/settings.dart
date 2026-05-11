import 'package:flutter/material.dart';
import 'package:conversando/commons.dart';
import 'package:conversando/context.dart';
import 'package:conversando/managePhrase.dart';
import 'package:conversando/models.dart';
import 'package:conversando/help.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _SettingsMenuOption(
          title: 'Mis frases',
          subtitle: 'Gestiona tus frases y categorías',
          icon: Icons.chat,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CategoryManagerWidget()),
          ),
        ),
        _SettingsMenuOption(
          title: 'Ajustes de voz',
          subtitle: 'Velocidad, tono e idioma',
          icon: Icons.keyboard_voice,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VoiceSettingsWidget()),
          ),
        ),
        _SettingsMenuOption(
          title: 'Tamaño de fuente',
          subtitle: 'Ajusta el tamaño del texto',
          icon: Icons.format_size,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FontSettingsWidget()),
          ),
        ),
        _SettingsMenuOption(
          title: 'Ayuda',
          icon: Icons.help,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HelpWidget()),
          ),
        ),
      ],
    );
  }
}

class VoiceSettingsWidget extends StatefulWidget {
  const VoiceSettingsWidget({super.key});

  @override
  State<VoiceSettingsWidget> createState() => _VoiceSettingsWidgetState();
}

class _VoiceSettingsWidgetState extends State<VoiceSettingsWidget> {
  late AppSettings _settings;
  late TextContextWidgetState _tc;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _tc = TextContextWidget.of(context);
      _settings = _tc.getAppSettings();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes de voz'),
        actions: [
          ActionBarButtonWidget('GUARDAR', () async {
            await _tc.updateSettings(_settings);
            if (context.mounted) Navigator.pop(context);
          }),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Velocidad del habla',
              style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              const Text('Lenta'),
              Expanded(
                child: Slider(
                  value: _settings.speechRate,
                  min: 0.1,
                  max: 1.0,
                  divisions: 9,
                  label: _settings.speechRate.toStringAsFixed(1),
                  onChanged: (v) => setState(
                      () => _settings = _settings.copyWith(speechRate: v)),
                ),
              ),
              const Text('Rápida'),
            ],
          ),
          const SizedBox(height: 16),
          Text('Tono de voz',
              style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              const Text('Grave'),
              Expanded(
                child: Slider(
                  value: _settings.speechPitch,
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  label: _settings.speechPitch.toStringAsFixed(1),
                  onChanged: (v) => setState(
                      () => _settings = _settings.copyWith(speechPitch: v)),
                ),
              ),
              const Text('Agudo'),
            ],
          ),
          const SizedBox(height: 16),
          Text('Idioma', style: Theme.of(context).textTheme.titleMedium),
          DropdownButton<String>(
            value: _settings.speechLanguage,
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                  value: 'es-ES', child: Text('Español (España)')),
              DropdownMenuItem(
                  value: 'es-MX', child: Text('Español (México)')),
              DropdownMenuItem(
                  value: 'es-AR',
                  child: Text('Español (Argentina)')),
              DropdownMenuItem(value: 'ca-ES', child: Text('Català')),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(
                    () => _settings = _settings.copyWith(speechLanguage: v));
              }
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.volume_up),
            label: const Text('Probar voz'),
            onPressed: () {
              _tc.speak(
                  'Hola, estoy probando la configuración de voz');
            },
          ),
        ],
      ),
    );
  }
}

class FontSettingsWidget extends StatefulWidget {
  const FontSettingsWidget({super.key});

  @override
  State<FontSettingsWidget> createState() => _FontSettingsWidgetState();
}

class _FontSettingsWidgetState extends State<FontSettingsWidget> {
  late AppSettings _settings;
  late TextContextWidgetState _tc;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _tc = TextContextWidget.of(context);
      _settings = _tc.getAppSettings();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tamaño de fuente'),
        actions: [
          ActionBarButtonWidget('GUARDAR', () async {
            await _tc.updateSettings(_settings);
            if (context.mounted) Navigator.pop(context);
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tamaño de fuente',
                style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                const Text('A', style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Slider(
                    value: _settings.fontSize,
                    min: 12.0,
                    max: 32.0,
                    divisions: 10,
                    label: '${_settings.fontSize.round()}',
                    onChanged: (v) => setState(
                        () => _settings = _settings.copyWith(fontSize: v)),
                  ),
                ),
                const Text('A', style: TextStyle(fontSize: 32)),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Así se verá el texto de las frases',
                style: TextStyle(
                    fontSize: _settings.fontSize, fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsMenuOption extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsMenuOption({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading:
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24.0),
      onTap: onTap,
    );
  }
}
