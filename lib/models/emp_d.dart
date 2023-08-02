// @dart=2.9

import 'dart:convert';

/// id : 1

class Emp_ID {
  int _id;

  int get id => _id;

  Emp_ID({
      int id}){
    _id = id;
}

  Emp_ID.fromJson(dynamic json) {
    _id = json["id"];
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
