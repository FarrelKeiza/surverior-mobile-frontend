import 'package:surverior_frontend_mobile/models/metadata_model.dart';
import 'package:surverior_frontend_mobile/models/user_model.dart';
import 'package:surverior_frontend_mobile/models/end_user_model.dart';

class UserProfileModel {
  MetadataModel? metadata;
  UserProfileData? data;

  UserProfileModel({
    this.metadata,
    this.data,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? MetadataModel.fromJson(json['metadata'])
        : null;
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserProfileData {
  UserModel? user;
  EndUserModel? endUser;

  UserProfileData({
    this.user,
    this.endUser,
  });

  UserProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    endUser = json['end_user'] != null
        ? EndUserModel.fromJson(json['end_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (endUser != null) {
      data['end_user'] = endUser!.toJson();
    }
    return data;
  }
}
