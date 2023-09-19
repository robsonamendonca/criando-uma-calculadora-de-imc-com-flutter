import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:imcapp/pages/pessoa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],        
        debugShowCheckedModeBanner: false,
        title: 'IMC Nível',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade100),
          useMaterial3: true,
        ),
        home: const PessoaPage());
  }
}
