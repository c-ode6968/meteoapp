
import 'package:flutter/cupertino.dart';

//Classe ici permet de gérer l'état des appareils ajoutés afin que l'appareil ajouté pour l'utilisateur ne soit déconnecté qu'une seule fois de l'application

class AppState extends ChangeNotifier {
  List<String> addedCities = [];

  void addCity(String cityName) {
    addedCities.add(cityName);
    notifyListeners();
  }
}
