import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/homePage.dart';
import 'package:conversando/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await StorageService.create();
  runApp(MyApp(storage: storage));
}

class MyApp extends StatelessWidget {
  final StorageService storage;

  const MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return TextContextWidget(
      storage: storage,
      child: MaterialApp(
        title: 'Conversando',
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan,
            secondary: const Color(0xFFFDA05D),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
