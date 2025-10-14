class AcademicIdentityModel {
  String? userId;
  String? educationId;
  String? academicId;
  String? academicType;
  String? dateIn;
  String? college;
  String? department;
  String? id;
  String? updatedAt;
  String? createdAt;

  AcademicIdentityModel({
    this.userId,
    this.educationId,
    this.academicId,
    this.academicType,
    this.dateIn,
    this.college,
    this.department,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory AcademicIdentityModel.fromJson(Map<String, dynamic> json) {
    return AcademicIdentityModel(
      userId: json['user_id'],
      educationId: json['education_id'],
      academicId: json['academic_id'],
      academicType: json['academic_type'],
      dateIn: json['date_in'],
      college: json['college'],
      department: json['department'],
      id: json['id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'education_id': educationId,
      'academic_id': academicId,
      'academic_type': academicType,
      'date_in': dateIn,
      'college': college,
      'department': department,
      'id': id,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
