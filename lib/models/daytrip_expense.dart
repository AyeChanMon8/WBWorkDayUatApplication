// @dart=2.9

import 'dart:convert';
class Daytrip_expense {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Daytrip_expense({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Daytrip_expense.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

  factory Daytrip_expense.fromMap(Map<String, dynamic> map) {
    return new Daytrip_expense(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this._id,
      'name': this._name,
    } as Map<String, dynamic>;
  }
}