class City {
  String? id;
  String? name;
  String? province;

  City({this.id, this.name, this.province});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['province'] = province;
    return data;
  }
}
