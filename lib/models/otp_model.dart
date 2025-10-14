import 'metadata_model.dart';

class OtpModel {
  MetadataModel? metadata;
  OtpDataModel? data;

  OtpModel({
    this.metadata,
    this.data,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      metadata: json['metadata'] != null
          ? MetadataModel.fromJson(json['metadata'])
          : null,
      data: json['data'] != null ? OtpDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (metadata != null) {
      json['metadata'] = metadata!.toJson();
    }
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class OtpDataModel {
  String? email;
  String? expiresIn;

  OtpDataModel({
    this.email,
    this.expiresIn,
  });

  factory OtpDataModel.fromJson(Map<String, dynamic> json) {
    return OtpDataModel(
      email: json['email'],
      expiresIn: json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (email != null) json['email'] = email;
    if (expiresIn != null) json['expires_in'] = expiresIn;
    return json;
  }
}
