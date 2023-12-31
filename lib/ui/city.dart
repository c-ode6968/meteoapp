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


  void citySelection(String selectedCity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          selectedCity: selectedCity,
          title: '',
        ),
      ),
    );
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
                      citySelection(filteredCities[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(selectedCity: filteredCities[index],
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

