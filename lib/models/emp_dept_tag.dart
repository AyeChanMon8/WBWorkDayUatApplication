// @dart=2.9

import 'dart:convert';
class EmployeeDeptTag {
  int category_id;
  int emp_id;
  EmployeeDeptTag({
    this.category_id,
    this.emp_id,
  });

  EmployeeDeptTag copyWith({
    int category_id,
    int emp_id,
  }) {
    return EmployeeDeptTag(
      category_id: category_id ?? this.category_id,
      emp_id: emp_id ?? this.emp_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': category_id,
      'emp_id': emp_id,
    };
  }

  factory EmployeeDeptTag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return EmployeeDeptTag(
      category_id: map['category_id'],
      emp_id: map['emp_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeDeptTag.fromJson(String source) => EmployeeDeptTag.fromMap(json.decode(source));

  @override
  String toString() => 'EmployeeDeptTag(category_id: $category_id, emp_id: $emp_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is EmployeeDeptTag &&
      o.category_id == category_id &&
      o.emp_id == emp_id;
  }

  @override
  int get hashCode => category_id.hashCode ^ emp_id.hashCode;
}

