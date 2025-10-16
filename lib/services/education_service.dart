import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surverior_frontend_mobile/models/education.dart';

import 'package:surverior_frontend_mobile/utils/data_util.dart';

class EducationService {
  Future<List<Education>> fetchEducations() async {
    var response = await http.get(
        Uri.parse('${baseApiUrl()}/educations'),
        headers: header(false));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      List<Education> categories = (jsonObject['data'] as List)
          .map((education) => Education.fromJson(education))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load educations');
    }
  }
}
