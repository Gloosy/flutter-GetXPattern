class CategoryModel {
  Data? _data;

  CategoryModel({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _id;
  Attributes? _attributes;

  Data({int? id, Attributes? attributes}) {
    if (id != null) {
      _id = id;
    }
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  Attributes? get attributes => _attributes;
  set attributes(Attributes? attributes) => _attributes = attributes;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_attributes != null) {
      data['attributes'] = _attributes!.toJson();
    }
    return data;
  }
  
}

class Attributes {
  String? _title;
  String? _createdAt;
  String? _updatedAt;
  String? _publishedAt;
  String? _iconUrl;

  Attributes(
      {String? title,
        String? createdAt,
        String? updatedAt,
        String? publishedAt,
        String? iconUrl}) {
    if (title != null) {
      _title = title;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (publishedAt != null) {
      _publishedAt = publishedAt;
    }
    if (iconUrl != null) {
      _iconUrl = iconUrl;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get publishedAt => _publishedAt;
  set publishedAt(String? publishedAt) => _publishedAt = publishedAt;
  String? get iconUrl => _iconUrl;
  set iconUrl(String? iconUrl) => _iconUrl = iconUrl;

  Attributes.fromJson(Map<String, dynamic> json) {
    _title       = json['title'];
    _createdAt   = json['createdAt'];
    _updatedAt   = json['updatedAt'];
    _publishedAt = json['publishedAt'];
    _iconUrl     = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title']       = _title;
    data['createdAt']   = _createdAt;
    data['updatedAt']   = _updatedAt;
    data['publishedAt'] = _publishedAt;
    data['iconUrl']     = _iconUrl;
    return data;
  }
}
