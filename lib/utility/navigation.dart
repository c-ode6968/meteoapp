import 'package:flutter/material.dart';
import 'package:meteoapp/ui/city.dart';

import '../ui/about.dart';

void openMenu(BuildContext context) async {
    final RenderBox appBar = context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
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
      if (result != null) {
        //Logica per gestire le azioni in base alla selezione del menu
        if (result == 1) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CityPage(cityName: '', addedCities: [],)),
          );

        }else if(result == 2){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        }
      }
  }