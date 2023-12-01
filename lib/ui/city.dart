import 'package:flutter/material.dart';
class City {
  String name;
  String countryCode;

  City(this.name, this.countryCode);
}

class CityPage extends StatefulWidget {
  const CityPage({Key? key, required String cityName}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CityPageState createState() => _CityPageState();

  void addCityToList(String s, String t) {}
  
}


class _CityPageState extends State<CityPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> cities = [
    'Paris',
    'New York',
    'London',
    'Tokyo',
    'Sydney',
  ];
  List<String> addedCities = []; // Liste des villes ajoutées
  List<String> filteredCities = [];
  

  @override
  void initState() {
    filteredCities = cities;
    super.initState();
  }

  void filterCities(String query) {
    if (query.isNotEmpty) {
      List<String> tempList = [];
      for (var city in cities) {
        if (city.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(city);
        }
      }
      setState(() {
        filteredCities = tempList;
      });
    } else {
      setState(() {
        filteredCities = cities;
      });
    }
  }

  void addCityToList(String cityName) {
    setState(() {
      addedCities.add(cityName); // Ajoute la ville à la liste des villes ajoutées
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Villes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher une ville',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                filterCities(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
            itemCount: filteredCities.length + addedCities.length,
            itemBuilder: (context, index) {
              if (index < filteredCities.length) {
                return ListTile(
                  title: Text(filteredCities[index]),
                  onTap: () {
                    Navigator.pop(context, filteredCities[index]);
                  },
                );
              } else {
                // Afficher les villes ajoutées
                int addedIndex = index - filteredCities.length;
                return ListTile(
                  title: Text(addedCities[addedIndex]),
                );
              }
            },
          ),
          )
        ],
      ),
    );
  }
}
