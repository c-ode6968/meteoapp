class City{
  bool isSelected;
  final String city;
  final String country; 
  final bool isDefault;

  City(String cityName, String countryCode, {required this.isSelected, required this.city, required this.country, required this.isDefault});

  void addCityToList(String cityName) {}
}