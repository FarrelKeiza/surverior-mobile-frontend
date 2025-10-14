class MetadataModel {
  int? code;
  String? status, message;
  dynamic data;

  MetadataModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> object) {
    return MetadataModel(
      code: object['code'],
      status: object['status'],
      message: object['message'],
      data: object['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
