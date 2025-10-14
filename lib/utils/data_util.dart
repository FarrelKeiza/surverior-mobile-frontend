import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String baseUrl() {
  return "http://72.60.210.20";
}

String baseImageUrl() {
  return "http://138.91.164.57";
}

String baseApiUrl() {
  return "${baseUrl()}/api/v1";
}

Map<String, String> header(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  } else {
    return {
      'Accept': 'application/json',
    };
  }
}

const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);
