import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteoapp/utility/appState.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
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
      home: HomePage(
        title: '',
        selectedCity: '',
      ),
    );
  }
}
