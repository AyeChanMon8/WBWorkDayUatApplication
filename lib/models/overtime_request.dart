// @dart=2.9

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:winbrother_hr_app/models/category_id.dart';
import 'package:winbrother_hr_app/models/department.dart';
import 'package:winbrother_hr_app/models/overtime_request_line.dart';

class OvertimeRequest {
  String name;
  String start_date;
  String end_date;
  double duration;
  String reason;
  int requested_employee_id;
  List<Department> department_ids;
  List<OvertimeRequestLine> request_line;
  int categ_id;
  OvertimeRequest({
    this.name,
    this.start_date,
    this.end_date,
    this.duration,
    this.reason,
    this.requested_employee_id,
    this.department_ids,
    this.request_line,
    this.categ_id,
  });

  OvertimeRequest copyWith({
    String name,
    String start_date,
    String end_date,
    double duration,
    String reason,
    int requested_employee_id,
    List<Department> department_ids,
    List<OvertimeRequestLine> request_line,
    int categ_id,
  }) {
    return OvertimeRequest(
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      duration: duration ?? this.duration,
      reason: reason ?? this.reason,
      requested_employee_id:
          requested_employee_id ?? this.requested_employee_id,
      department_ids: department_ids ?? this.department_ids,
      request_line: request_line ?? this.request_line,
      categ_id: categ_id ?? this.categ_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'start_date': start_date,
      'end_date': end_date,
      'duration': duration,
      'reason': reason,
      'requested_employee_id': requested_employee_id,
      'department_ids': department_ids?.map((x) => x?.toMap())?.toList(),
      'request_line': request_line?.map((x) => x?.toMap())?.toList(),
      'categ_id': categ_id
    };
  }

  factory OvertimeRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OvertimeRequest(
      name: map['name'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      duration: map['duration'],
      reason: map['reason'],
      requested_employee_id: map['requested_employee_id'],
      department_ids: List<Department>.from(
          map['department_ids']?.map((x) => Department.fromMap(x))),
      request_line: List<OvertimeRequestLine>.from(
          map['request_line']?.map((x) => OvertimeRequestLine.fromMap(x))),
      categ_id: map['categ_id']
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeRequest.fromJson(String source) =>
      OvertimeRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeRequest(name: $name, start_date: $start_date, end_date: $end_date, duration: $duration, reason: $reason, requested_employee_id: $requested_employee_id, department_ids: $department_ids, request_line: $request_line, categ_id: $categ_id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OvertimeRequest &&
        o.name == name &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.duration == duration &&
        o.reason == reason &&
        o.requested_employee_id == requested_employee_id &&
        listEquals(o.department_ids, department_ids) &&
        listEquals(o.request_line, request_line) &&
        o.categ_id == categ_id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        start_date.hashCode ^
        end_date.hashCode ^
        duration.hashCode ^
        reason.hashCode ^
        requested_employee_id.hashCode ^
        department_ids.hashCode ^
        request_line.hashCode ^
        categ_id.hashCode;
  }
}
