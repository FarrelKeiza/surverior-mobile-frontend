import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surverior_frontend_mobile/models/user_profile_model.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class UserService {
  Future<UserProfileModel> getUserProfile() async {
    String apiURL = "${baseApiUrl()}/users/me";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await get(
        Uri.parse(apiURL),
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 404) {
        // Handle user not found
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'User not found';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to get user profile';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<UserProfileModel> updateUserProfile({
    String? name,
    String? nik,
    String? gender,
    String? birthdate,
    String? domicile,
    String? marriedStatus,
    String? profilePhotoUrl,
  }) async {
    String apiURL = "${baseApiUrl()}/users/me";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      // Build request body with only non-null values
      Map<String, dynamic> requestBody = {};
      if (name != null) requestBody['name'] = name;
      if (nik != null) requestBody['nik'] = nik;
      if (gender != null) requestBody['gender'] = gender;
      if (birthdate != null) requestBody['birthdate'] = birthdate;
      if (domicile != null) requestBody['domicile'] = domicile;
      if (marriedStatus != null) requestBody['married_status'] = marriedStatus;
      if (profilePhotoUrl != null) {
        requestBody['profile_photo_url'] = profilePhotoUrl;
      }

      var response = await put(
        Uri.parse(apiURL),
        headers: header(true, token: token),
        body: jsonEncode(requestBody),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 422) {
        // Handle validation errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Validation failed';

        // Check for specific field errors
        if (jsonObject['data'] != null) {
          // Get the first error message from any field
          for (var field in jsonObject['data'].keys) {
            if (jsonObject['data'][field] is List &&
                jsonObject['data'][field].isNotEmpty) {
              errorMessage = jsonObject['data'][field].first.toString();
              break;
            }
          }
        }

        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage = jsonObject['metadata']?['message'] ??
            'Failed to update user profile';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
