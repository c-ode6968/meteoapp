import 'package:flutter/material.dart';
import 'package:meteoapp/ui/city.dart';

import '../ui/about.dart';

void openMenu(BuildContext context) async {
  // Trova la posizione dell'appBar nella gerarchia degli oggetti di rendering
    final RenderBox appBar = context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
      // Posiziona il menu sopra l'appBar
      position: RelativeRect.fromLTRB(
        appBar.localToGlobal(const Offset(0.0, 0.0)).dx,
        appBar.localToGlobal(const Offset(0.0, 0.0)).dy - appBar.size.height * 2,
        appBar.localToGlobal(appBar.size.bottomLeft(Offset.zero)).dx,
        appBar.localToGlobal(const Offset(0.0, 0.0)).dy,
      ),
      items: const [
        PopupMenuItem(
          value: 1,
          child: Text('City'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('About'),
        ),
      ],
    );
    // Gestisce le azioni in base alla selezione del menu
      if (result != null) {
        //Logica per gestire le azioni in base alla selezione del menu
        if (result == 1) {
          // Naviga alla pagina delle città
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CityPage(cityName: '',)),
          );

        }else if(result == 2){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        }
      }
  }