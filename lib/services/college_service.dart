import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:surverior_frontend_mobile/models/college.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class CollegeService {
  Future<List<College>> fetchColleges() async {
    String apiURL = "${baseApiUrl()}/colleges";

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(true),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<College> colleges = (jsonObject['data'] as List)
            .map((college) => College.fromJson(college))
            .toList();
        return colleges;
      } else {
        throw Exception("Failed to load colleges");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
