import 'dart:convert';
import 'package:flutter/foundation.dart';
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
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Safely check if access_token exists before storing
        final accessToken = jsonObject['data']?['access_token'];
        if (kDebugMode) {
          print(accessToken);
        }
        if (accessToken != null) {
          await storage.write(key: "token", value: accessToken.toString());
          final token = await storage.read(key: "token");
          if (kDebugMode) {
            print("$token ini token");
          }
        }
      } else if (response.statusCode == 422 || response.statusCode == 401) {
        // Handle validation errors or authentication errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Authentication failed';

        // Check for specific field errors
        if (jsonObject['data'] != null) {
          if (jsonObject['data']['email'] != null) {
            List emailErrors = jsonObject['data']['email'];
            if (emailErrors.isNotEmpty) {
              errorMessage = emailErrors.first.toString();
            }
          } else if (jsonObject['data']['password'] != null) {
            List passwordErrors = jsonObject['data']['password'];
            if (passwordErrors.isNotEmpty) {
              errorMessage = passwordErrors.first.toString();
            }
          }
        }

        throw Exception(errorMessage);
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
        // Safely check if access_token exists before storing
        final accessToken = jsonObject['data']?['access_token'];
        if (accessToken != null) {
          await storage.write(key: "token", value: accessToken.toString());
        }
      } else if (response.statusCode == 422) {
        // Handle validation errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Validation failed';

        // Check for specific email error
        if (jsonObject['data'] != null && jsonObject['data']['email'] != null) {
          List emailErrors = jsonObject['data']['email'];
          if (emailErrors.isNotEmpty) {
            errorMessage = emailErrors.first.toString();
          }
        }

        throw Exception(errorMessage);
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
        // Safely check if access_token exists before storing
        final accessToken = jsonObject['data']?['access_token'];
        if (accessToken != null) {
          await storage.write(key: "token", value: accessToken.toString());
        }
      } else if (response.statusCode == 422) {
        // Handle validation errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Validation failed';

        // Check for specific email error
        if (jsonObject['data'] != null && jsonObject['data']['email'] != null) {
          List emailErrors = jsonObject['data']['email'];
          if (emailErrors.isNotEmpty) {
            errorMessage = emailErrors.first.toString();
          }
        }

        throw Exception(errorMessage);
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
        body: jsonEncode({
          "email": email,
        }),
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
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Safely check if access_token exists before storing
        final accessToken = jsonObject['data']?['access_token'];
        if (accessToken != null) {
          await storage.write(key: "token", value: accessToken.toString());
        }
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        // Handle validation errors or OTP errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'OTP verification failed';

        // Check for specific field errors
        if (jsonObject['data'] != null) {
          if (jsonObject['data']['otp'] != null) {
            List otpErrors = jsonObject['data']['otp'];
            if (otpErrors.isNotEmpty) {
              errorMessage = otpErrors.first.toString();
            }
          } else if (jsonObject['data']['email'] != null) {
            List emailErrors = jsonObject['data']['email'];
            if (emailErrors.isNotEmpty) {
              errorMessage = emailErrors.first.toString();
            }
          }
        }

        throw Exception(errorMessage);
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
        body: {
          "email": email,
          "pin": pin,
        },
      );

      var jsonObject = jsonDecode(response.body);

      return jsonObject['success'];
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
