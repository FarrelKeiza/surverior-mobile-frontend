class Education {
  String? id;
  String? educationName;

  Education({this.id, this.educationName});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    educationName = json['education_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['education_name'] = educationName;
    return data;
  }
}
