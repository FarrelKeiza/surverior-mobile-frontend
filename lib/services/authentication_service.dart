import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surverior_frontend_mobile/models/authentication_model.dart';
import 'package:surverior_frontend_mobile/models/otp_model.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class AuthenticationService {
  Future<AuthenticationModel> signIn(
    String email,
    String password,
  ) async {
    String apiURL = "${baseApiUrl()}/authentication/sign-in";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        // body: {
        //   "email": email,
        //   "password": password,
        // },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await storage.write(
            key: "token", value: jsonObject['data']['access_token']);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<AuthenticationModel> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String roleId,
    required String educationId,
    String? referralId,
    required String nik,
    required String gender,
    required String birthdate,
    required String domicile,
    required String marriedStatus,
    required bool isAcademic,
    required String reason,
    String? profilePhotoUrl,
    String? referral,
    required String academicId,
    required String academicType,
    required String dateIn,
    required String college,
    required String department,
    required String collegeId,
    required String departmentId,
  }) async {
    String apiURL = "${baseApiUrl()}/authentication/sign-up";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "role_id": roleId,
          "education_id": educationId,
          "referral_id": referralId,
          "nik": nik,
          "gender": gender,
          "birthdate": birthdate,
          "domicile": domicile,
          "married_status": marriedStatus,
          "is_academic": isAcademic,
          "reason": reason,
          "profile_photo_url": profilePhotoUrl,
          "referral": referral,
          "academic_id": academicId,
          "academic_type": academicType,
          "date_in": dateIn,
          "college": college,
          "department": department,
          "college_id": collegeId,
          "department_id": departmentId,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 201) {
        await storage.write(
            key: "token", value: jsonObject['data']['access_token']);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<AuthenticationModel> signUpNonAcademic({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String roleId,
    required String educationId,
    String? referralId,
    required String nik,
    required String gender,
    required String birthdate,
    required String domicile,
    required String marriedStatus,
    required bool isAcademic,
    String? reason,
    String? profilePhotoUrl,
    String? referral,
  }) async {
    String apiURL = "${baseApiUrl()}/authentication/sign-up";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "role_id": roleId,
          "education_id": educationId,
          "referral_id": referralId,
          "nik": nik,
          "gender": gender,
          "birthdate": birthdate,
          "domicile": domicile,
          "married_status": marriedStatus,
          "is_academic": isAcademic,
          "reason": reason,
          "profile_photo_url": profilePhotoUrl,
          "referral": referral,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 201) {
        await storage.write(
            key: "token", value: jsonObject['data']['access_token']);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<OtpModel> sendOtp(String email) async {
    String apiURL = "${baseApiUrl()}/authentication/send-otp";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        // body: {
        body: jsonEncode({
          "email": email,
        }),
        // },
      );

      var jsonObject = jsonDecode(response.body);

      return OtpModel.fromJson(jsonObject);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<AuthenticationModel> verifyOtp(String email, String otp) async {
    String apiURL = "${baseApiUrl()}/authentication/verify-otp";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        // body: {
        //   "email": email,
        //   "otp": otp,
        // },
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await storage.write(
            key: "token", value: jsonObject['data']['access_token']);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<bool> createPin(String email, String pin) async {
    String apiURL = "${baseApiUrl()}/authentication/security/pin";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(true),
        body: jsonEncode({
          "email": email,
          "pin": pin,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      return jsonObject['success'];
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
