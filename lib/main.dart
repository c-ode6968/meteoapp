import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteoapp/utility/appState.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.red));
  runApp(
    // Utilizzo di ChangeNotifierProvider per gestire lo stato globale dell'applicazione
    ChangeNotifierProvider(
      // Creazione di un'istanza della classe AppState
      create: (context) => AppState(),
      // Utilizzo dell'applicazione principale MyApp
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Utilizzo della pagina principale come schermata iniziale
      home: HomePage(
        title: '',
        selectedCity: '',
      ),
    );
  }
}
