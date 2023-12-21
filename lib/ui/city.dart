import 'package:flutter/material.dart';
import 'package:meteoapp/ui/home.dart';

import 'cityList.dart';


class CityPage extends StatefulWidget {
  final List<String> addedCities;
  const CityPage({Key? key, required String cityName, required this.addedCities}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}


class _CityPageState extends State<CityPage> {
  final TextEditingController _searchController = TextEditingController();
  late CityData cityData;
  List<String> addedCities = []; // Elenco delle città aggiunte
  List<String> filteredCities = [];



  @override
  void initState() {
    super.initState();
    cityData = CityData();
    addedCities = widget.addedCities;
    filteredCities = cityData.cities;
  }


  void filterCities(String query) {
    if (query.isNotEmpty) {
      List<String> tempList = [];
      for (var city in cityData.cities) {
        if (city.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(city);
        }
      }
      setState(() {
        filteredCities = tempList.cast<String>();
      });
    } else {
      setState(() {
        filteredCities = cityData.cities.cast<String>();
      });
    }
  }



  void  addCityToList(String cityName) {
    setState(() {
      addedCities.add(cityName); // Aggiunge la città all'elenco delle città
    });
  }
  @override
  Widget build(BuildContext context) {
    addedCities.forEach((city) {
      //print(city);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco delle città'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cerca una città',
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
              itemCount: filteredCities.length + widget.addedCities.length,
              itemBuilder: (context, index) {
                if (index < filteredCities.length) {
                  return ListTile(
                    title: Text(filteredCities[index]),
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(selectedCity: filteredCities[index],
                            title: '',
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Mostra le città aggiunte
                  int addedIndex = index - filteredCities.length;
                  return ListTile(
                    title: Text(widget.addedCities[addedIndex]),
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(selectedCity: widget.addedCities[addedIndex],
                          title: '',
                        ),
                      ),
                    );
                  },
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
