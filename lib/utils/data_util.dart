import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String baseUrl() {
  // return "http://72.60.210.20";
  return "http://72.60.210.20:81";
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
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  } else {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}

const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);
