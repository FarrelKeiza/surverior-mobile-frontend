import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surverior_frontend_mobile/utils/data_util.dart';

import 'package:surverior_frontend_mobile/models/category.dart';

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    var response = await http.get(
        Uri.parse('${baseApiUrl()}/questionnaires/categories'),
        headers: header(false));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      List<Category> categories = (jsonObject['data'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
