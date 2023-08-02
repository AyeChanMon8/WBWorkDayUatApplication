// @dart=2.9

import 'dart:convert';

import 'package:winbrother_hr_app/models/employee_id.dart';

class Department {
  final int id;
  final String name;
  String complete_name;
  List<EmployeeID> employee_ids;
  Department({
    this.id,
    this.name,this.complete_name,
  });


  Department copyWith({
    int id,
    String name,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Department(
      id: map['id'],
      name: map['name'],
      complete_name: map['complete_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) => Department.fromMap(json.decode(source));

  @override
  String toString() => 'Department(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Department &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
