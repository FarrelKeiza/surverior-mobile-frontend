import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surverior_frontend_mobile/models/questionnaire_model.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class QuestionnaireService {
  Future<QuestionnaireResponseModel> getQuestionnaires({
    int page = 1,
    int perPage = 10,
    String? category,
    String? search,
  }) async {
    String apiURL = "${baseApiUrl()}/questionnaires";

    // Build query parameters
    Map<String, String> queryParams = {
      'page': page.toString(),
      'per_page': perPage.toString(),
    };

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    // Create URI with query parameters
    Uri uri = Uri.parse(apiURL).replace(queryParameters: queryParams);

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await get(
        uri,
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return QuestionnaireResponseModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 404) {
        // Handle not found
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Questionnaires not found';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage = jsonObject['metadata']?['message'] ??
            'Failed to get questionnaires';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<QuestionnaireModel> getQuestionnaireById(String id) async {
    String apiURL = "${baseApiUrl()}/questionnaires/$id";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await get(
        Uri.parse(apiURL),
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return QuestionnaireModel.fromJson(jsonObject['data']);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 404) {
        // Handle not found
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Questionnaire not found';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to get questionnaire';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<void> createQuestionnaire() async {
    String apiURL = "${baseApiUrl()}/questionnaires";
    debugPrint("Create questionnaire endpoint: $apiURL");
  }

  Future<QuestionnaireResponseModel> deleteQuestionnaire(String id) async {
    String apiURL = "${baseApiUrl()}/questionnaires/$id";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await delete(
        Uri.parse(apiURL),
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return QuestionnaireResponseModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 404) {
        // Handle not found
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Questionnaire not found';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage = jsonObject['metadata']?['message'] ??
            'Failed to delete questionnaire';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
