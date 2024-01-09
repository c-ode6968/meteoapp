import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteoapp/utility/appState.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.red));
  runApp(
    ChangeNotifierProvider( // Utilizzo di ChangeNotifierProvider per gestire lo stato globale dell'applicazione
      create: (context) => AppState(), // Creazione di un'istanza della classe AppState
      child: const MyApp(), // Utilizzo dell'applicazione principale MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage( // Utilizzo della pagina principale come schermata iniziale
        title: '',
        selectedCity: '',
      ),
    );
  }
}
