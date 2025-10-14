class EndUserModel {
  String? userId;
  String? educationId;
  String? referralId;
  String? nik;
  String? gender;
  String? birthdate;
  String? domicile;
  String? marriedStatus;
  bool? isAcademic;
  String? reason;
  String? profilePhotoUrl;
  String? referral;
  String? id;
  String? updatedAt;
  String? createdAt;

  EndUserModel({
    this.userId,
    this.educationId,
    this.referralId,
    this.nik,
    this.gender,
    this.birthdate,
    this.domicile,
    this.marriedStatus,
    this.isAcademic,
    this.reason,
    this.profilePhotoUrl,
    this.referral,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory EndUserModel.fromJson(Map<String, dynamic> json) {
    return EndUserModel(
      userId: json['user_id'],
      educationId: json['education_id'],
      referralId: json['referral_id'],
      nik: json['nik'],
      gender: json['gender'],
      birthdate: json['birthdate'],
      domicile: json['domicile'],
      marriedStatus: json['married_status'],
      isAcademic: json['is_academic'],
      reason: json['reason'],
      profilePhotoUrl: json['profile_photo_url'],
      referral: json['referral'],
      id: json['id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'education_id': educationId,
      'referral_id': referralId,
      'nik': nik,
      'gender': gender,
      'birthdate': birthdate,
      'domicile': domicile,
      'married_status': marriedStatus,
      'is_academic': isAcademic,
      'reason': reason,
      'profile_photo_url': profilePhotoUrl,
      'referral': referral,
      'id': id,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
