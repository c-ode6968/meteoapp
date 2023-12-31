
import 'package:flutter/cupertino.dart';

//Classe qui permet de gérer l'état de l'application  afin que la ville  ajouté par l'utilisateur ne soit pas supprimé une fois que l'utilisateur se deconnecte de l'application.

class AppState extends ChangeNotifier {
  List<String> addedCities = [];

  void seachCity(String cityName) {
    addedCities.add(cityName);
    notifyListeners();
  }
}
