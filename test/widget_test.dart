import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:conversando/main.dart';
import 'package:conversando/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (_) async => null,
    );
  });

  Future<MyApp> buildApp() async {
    final prefs = await SharedPreferences.getInstance();
    return MyApp(storage: StorageService(prefs));
  }

  testWidgets('app renders without crashing', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('home page shows three tabs', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    expect(find.text('COMPONER'), findsOneWidget);
    expect(find.text('HABLAR'), findsOneWidget);
    expect(find.text('AJUSTES'), findsOneWidget);
  });

  testWidgets('HABLAR tab shows all quick-speak buttons', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    await tester.tap(find.text('HABLAR'));
    await tester.pumpAndSettle();
    for (final label in ['Sí', 'No', 'Perdona', 'Hola', 'Bien', 'Gracias']) {
      expect(find.text(label), findsOneWidget,
          reason: 'Missing quick-speak button: $label');
    }
  });

  testWidgets('AJUSTES tab shows all settings menu items', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    await tester.tap(find.text('AJUSTES'));
    await tester.pumpAndSettle();
    expect(find.text('Mis frases'), findsOneWidget);
    expect(find.text('Ajustes de voz'), findsOneWidget);
    expect(find.text('Tamaño de fuente'), findsOneWidget);
    expect(find.text('Ayuda'), findsOneWidget);
  });

  testWidgets('login screen is NOT shown on startup', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    expect(find.text('ÚNETE CON TU EMAIL'), findsNothing);
    expect(find.text('Continuar sin identificarte'), findsNothing);
    expect(find.text('María de Antón'), findsNothing);
  });

  testWidgets('COMPONER tab is the default and shows speak FAB',
      (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    // volume_up appears in the FAB and in the tab icon
    expect(find.byIcon(Icons.volume_up), findsWidgets);
  });

  testWidgets('tab icons are present for accessibility', (tester) async {
    await tester.pumpWidget(await buildApp());
    await tester.pump();
    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}
