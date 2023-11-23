import 'package:flutter/material.dart';

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Città'),
      ),
      body: const Center(
        child: Text('Contenu de la page City'),
      ),
    );
  }
}
