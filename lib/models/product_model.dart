
import 'categories_model.dart';
import 'thumbnail.dart';
class ProductModel {
  List<Data>? _data;

  ProductModel({List<Data>? data}) {
    if (data != null) {
      _data = data;
    }
  }

  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
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
  String? _price;
  String? _rating;
  String? _description;
  String? _quantity;
  CategoryModel? _category;
  Thumbnail? _thumbnail;


  Attributes(
      {String? title,
        String? createdAt,
        String? updatedAt,
        String? publishedAt,
        String? price,
        String? rating,
        String? description,
        String? quantity,
        CategoryModel? category,
        Thumbnail? thumbnail
        }) {
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
    if (price != null) {
      _price = price;
    }
    if (rating != null) {
      _rating = rating;
    }
    if (description != null) {
      _description = description;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if(category != null){
      _category = category;
    }
    if(thumbnail != null)
      {
        _thumbnail = thumbnail;
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
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get rating => _rating;
  set rating(String? rating) => _rating = rating;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  CategoryModel? get category => _category;
  set category(CategoryModel? category) => _category = category;
  Thumbnail? get thumbnail => _thumbnail;
  set thumbnail(Thumbnail? thumbnail) => _thumbnail =thumbnail;


  Attributes.fromJson(Map<String, dynamic> json) {
    _title        = json['title'];
    _createdAt    = json['createdAt'];
    _updatedAt    = json['updatedAt'];
    _publishedAt  = json['publishedAt'];
    _price        = json['price'];
    _rating       = json['rating'];
    _description  = json['description'];
    _quantity     = json['quantity'];
    _category     = CategoryModel.fromJson(json['category']);
    _thumbnail    = Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title']       = _title;
    data['createdAt']   = _createdAt;
    data['updatedAt']   = _updatedAt;
    data['publishedAt'] = _publishedAt;
    data['price']       = _price;
    data['rating']      = _rating;
    data['description'] = _description;
    data['quantity']    = _quantity;
    data['category']    = _category;
    data['thumbnail']   = _thumbnail;
    return data;
  }
}
