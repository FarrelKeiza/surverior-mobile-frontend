import 'metadata_model.dart';
import 'user_model.dart';
import 'end_user_model.dart';
import 'academic_identity_model.dart';

class AuthenticationModel {
  MetadataModel? metadata;
  AuthDataModel? data;

  AuthenticationModel({
    this.metadata,
    this.data,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      metadata: json['metadata'] != null
          ? MetadataModel.fromJson(json['metadata'])
          : null,
      data: json['data'] != null ? AuthDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata?.toJson(),
      'data': data?.toJson(),
    };
  }
}

class AuthDataModel {
  UserModel? user;
  EndUserModel? endUser;
  String? accessToken;
  String? tokenType;
  AcademicIdentityModel? academicIdentity;

  AuthDataModel({
    this.user,
    this.endUser,
    this.accessToken,
    this.tokenType,
    this.academicIdentity,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      endUser: json['end_user'] != null
          ? EndUserModel.fromJson(json['end_user'])
          : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      academicIdentity: json['academic_identity'] != null
          ? AcademicIdentityModel.fromJson(json['academic_identity'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'end_user': endUser?.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
      'academic_identity': academicIdentity?.toJson(),
    };
  }
}
