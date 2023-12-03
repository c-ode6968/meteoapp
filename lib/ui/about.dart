import 'package:flutter/material.dart';

class AbaoutPage extends StatelessWidget {
  const AbaoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A Proposito'),
      ),
      body: const Center(
        child: Text('Contenu de la page About'),
      ),
    );
  }
}
