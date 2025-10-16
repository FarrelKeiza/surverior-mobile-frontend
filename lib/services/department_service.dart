import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:surverior_frontend_mobile/models/department.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class DepartmentService {
  Future<List<Department>> fetchDepartments() async {
    String apiURL = "${baseApiUrl()}/departments";

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(true),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Department> departments = (jsonObject['data'] as List)
            .map((department) => Department.fromJson(department))
            .toList();
        return departments;
      } else {
        throw Exception("Failed to load departments");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
