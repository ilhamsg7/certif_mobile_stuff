// ignore_for_file: unnecessary_this, prefer_collection_literals

class User {
  int? _id;
  String? _username;
  String? _password;
  String? _email;

  int get id => _id!;
  String get username => _username!;
  String get password => _password!;
  String get email => _email!;

  // Setter
  set username(String value) {
    _username = value;
  }

  set password(String value) {
    _password = value;
  }

  set email(String value) {
    _email = value;
  }

  User(
    this._username,
    this._password,
    this._email,
  );

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
    this._email = map['email'];
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['password'],
      json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['username'] = this._username;
    map['password'] = this._password;
    map['email'] = this._email;
    return map;
  }
}
