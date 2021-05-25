import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'relatorios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relatorios COVID-19',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: RelatoriosScreen(),
    );
  }
}