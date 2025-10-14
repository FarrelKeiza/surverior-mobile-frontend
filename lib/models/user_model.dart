class UserModel {
  String? name;
  String? email;
  String? roleId;
  String? id;
  String? updatedAt;
  String? createdAt;

  UserModel({
    this.name,
    this.email,
    this.roleId,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      roleId: json['role_id'],
      id: json['id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role_id': roleId,
      'id': id,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
