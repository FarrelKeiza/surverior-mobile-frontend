import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surverior_frontend_mobile/models/city.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class CityService {
  Future<List<City>> fetchCities() async {
    var response = await http.get(
        Uri.parse('${baseApiUrl()}/cities'),
        headers: header(false));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      List<City> cities = (jsonObject['data'] as List)
          .map((category) => City.fromJson(category))
          .toList();
      return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
