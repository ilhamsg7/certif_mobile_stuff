// ignore_for_file: unused_field, unnecessary_this, prefer_collection_literals

class Flow {
  int? _id;
  String? _category;
  int? _value;
  String? _description;
  String? _date;

  int get id => _id!;
  String get category => _category!;
  int get value => _value!;
  String get description => _description!;
  String get date => _date!;

  // Setter
  set category(String value) {
    _category = value;
  }

  set value(int value) {
    _value = value;
  }

  set description(String value) {
    _description = value;
  }

  set date(String value) {
    _date = value;
  }

  Flow(
    this._category,
    this._value,
    this._description,
    this._date,
  );

  Flow.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._category = map['category'];
    this._value = map['value'];
    this._description = map['description'];
    this._date = map['date'];
  }

  factory Flow.fromJson(Map<String, dynamic> json) {
    return Flow(
      json['category'],
      json['value'],
      json['description'],
      json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['category'] = this._category;
    map['value'] = this._value;
    map['description'] = this._description;
    map['date'] = this._date;
    return map;
  }
}
