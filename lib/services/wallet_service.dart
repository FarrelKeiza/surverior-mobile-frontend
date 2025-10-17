import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surverior_frontend_mobile/models/wallet_model.dart';
import 'package:surverior_frontend_mobile/utils/data_util.dart';

class WalletService {
  Future<WalletResponseModel> getWallet() async {
    String apiURL = "${baseApiUrl()}/users/wallets/me";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await get(
        Uri.parse(apiURL),
        headers: header(true, token: token),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WalletResponseModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else if (response.statusCode == 404) {
        // Handle wallet not found
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Wallet not found';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to get wallet';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<WalletResponseModel> updateWalletPin(String pin) async {
    String apiURL = "${baseApiUrl()}/wallet/pin";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await put(
        Uri.parse(apiURL),
        headers: header(true, token: token),
        body: jsonEncode({
          "pin": pin,
        }),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WalletResponseModel.fromJson(jsonObject);
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
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to update wallet PIN';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<WalletResponseModel> lockWallet() async {
    String apiURL = "${baseApiUrl()}/wallet/lock";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await put(
        Uri.parse(apiURL),
        headers: header(true, token: token),
        body: jsonEncode({}),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WalletResponseModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to lock wallet';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }

  Future<WalletResponseModel> unlockWallet() async {
    String apiURL = "${baseApiUrl()}/wallet/unlock";

    try {
      // Get token from storage
      String? token = await storage.read(key: "token");

      var response = await put(
        Uri.parse(apiURL),
        headers: header(true, token: token),
        body: jsonEncode({}),
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WalletResponseModel.fromJson(jsonObject);
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Unauthorized access';
        throw Exception(errorMessage);
      } else {
        // Handle other errors
        String errorMessage =
            jsonObject['metadata']?['message'] ?? 'Failed to unlock wallet';
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("$e");
    }
  }
}
