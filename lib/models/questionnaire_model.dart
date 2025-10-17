import 'package:surverior_frontend_mobile/models/metadata_model.dart';

class QuestionnaireResponseModel {
  MetadataModel? metadata;
  QuestionnaireData? data;

  QuestionnaireResponseModel({
    this.metadata,
    this.data,
  });

  QuestionnaireResponseModel.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? MetadataModel.fromJson(json['metadata'])
        : null;
    data =
        json['data'] != null ? QuestionnaireData.fromJson(json['data']) : null;
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

class QuestionnaireData {
  List<QuestionnaireModel>? questionnaires;
  QuestionnaireMetaData? meta;

  QuestionnaireData({
    this.questionnaires,
    this.meta,
  });

  QuestionnaireData.fromJson(Map<String, dynamic> json) {
    if (json['questionnaires'] != null) {
      questionnaires = <QuestionnaireModel>[];
      json['questionnaires'].forEach((v) {
        questionnaires!.add(QuestionnaireModel.fromJson(v));
      });
    }
    meta = json['meta'] != null
        ? QuestionnaireMetaData.fromJson(json['meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questionnaires != null) {
      data['questionnaires'] = questionnaires!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class QuestionnaireModel {
  String? id;
  String? userId;
  String? topic;
  String? title;
  String? description;
  int? respondentTarget;
  String? deadline;
  double? cost;
  double? reward;
  bool? isPublished;
  String? url;
  dynamic profiles;
  dynamic questions;
  dynamic response;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? categoryId;
  QuestionnaireCategory? category;
  QuestionnaireUser? user;

  QuestionnaireModel({
    this.id,
    this.userId,
    this.topic,
    this.title,
    this.description,
    this.respondentTarget,
    this.deadline,
    this.cost,
    this.reward,
    this.isPublished,
    this.url,
    this.profiles,
    this.questions,
    this.response,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categoryId,
    this.category,
    this.user,
  });

  QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    topic = json['topic'];
    title = json['title'];
    description = json['description'];
    respondentTarget = json['respondent_target'];
    deadline = json['deadline'];
    cost = json['cost']?.toDouble();
    reward = json['reward']?.toDouble();
    isPublished = json['is_published'];
    url = json['url'];
    profiles = json['profiles'];
    questions = json['questions'];
    response = json['response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryId = json['category_id'];
    category = json['category'] != null
        ? QuestionnaireCategory.fromJson(json['category'])
        : null;
    user =
        json['user'] != null ? QuestionnaireUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['topic'] = topic;
    data['title'] = title;
    data['description'] = description;
    data['respondent_target'] = respondentTarget;
    data['deadline'] = deadline;
    data['cost'] = cost;
    data['reward'] = reward;
    data['is_published'] = isPublished;
    data['url'] = url;
    data['profiles'] = profiles;
    data['questions'] = questions;
    data['response'] = response;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['category_id'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class QuestionnaireCategory {
  String? id;
  String? name;

  QuestionnaireCategory({
    this.id,
    this.name,
  });

  QuestionnaireCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class QuestionnaireUser {
  String? id;
  String? roleId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  QuestionnaireUser({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  QuestionnaireUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class QuestionnaireMetaData {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  QuestionnaireMetaData({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  QuestionnaireMetaData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['per_page'] = perPage;
    data['total'] = total;
    data['last_page'] = lastPage;
    return data;
  }
}
