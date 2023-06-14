class UserResponse {
  String? _message;
  bool? _success;
  User? _user;
  String? _accessToken;

  UserResponse(
      {String? message, bool? success, User? user, String? accessToken}) {
    if (message != null) {
      this._message = message;
    }
    if (success != null) {
      this._success = success;
    }
    if (user != null) {
      this._user = user;
    }
    if (accessToken != null) {
      this._accessToken = accessToken;
    }
  }

  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  User? get user => _user;
  set user(User? user)                 => _user = user;
  String? get accessToken              => _accessToken;
  set accessToken(String? accessToken) => _accessToken = accessToken;

  UserResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _success = json['success'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['success'] = this._success;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    data['access_token'] = this._accessToken;
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  Null? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;

  User(
      {int? id,
        String? name,
        String? email,
        String? phone,
        Null? emailVerifiedAt,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (emailVerifiedAt != null) {
      this._emailVerifiedAt = emailVerifiedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  Null? get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(Null? emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
