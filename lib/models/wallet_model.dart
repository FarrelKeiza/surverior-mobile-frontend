import 'package:surverior_frontend_mobile/models/metadata_model.dart';

class WalletResponseModel {
  MetadataModel? metadata;
  WalletModel? data;

  WalletResponseModel({
    this.metadata,
    this.data,
  });

  WalletResponseModel.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? MetadataModel.fromJson(json['metadata'])
        : null;
    data = json['data'] != null ? WalletModel.fromJson(json['data']) : null;
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

class WalletModel {
  String? id;
  String? userId;
  String? cardNumber;
  double? balances;
  bool? isLocked;
  String? pinSetAt;
  String? createdAt;
  String? updatedAt;

  WalletModel({
    this.id,
    this.userId,
    this.cardNumber,
    this.balances,
    this.isLocked,
    this.pinSetAt,
    this.createdAt,
    this.updatedAt,
  });

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardNumber = json['card_number'];
    balances = json['balances']?.toDouble() ?? 0.0;
    isLocked = json['is_locked'];
    pinSetAt = json['pin_set_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['card_number'] = cardNumber;
    data['balances'] = balances;
    data['is_locked'] = isLocked;
    data['pin_set_at'] = pinSetAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
