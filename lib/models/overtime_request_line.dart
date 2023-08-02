// @dart=2.9

import 'dart:convert';

import 'package:winbrother_hr_app/models/employee.dart';

class OvertimeRequestLine {
  String start_date;
  String end_date;
  int employee_id;
  String emp_name;
  String email;
  String state;
  int dept_id;
  double duration;
  OvertimeRequestLine({
    this.start_date,
    this.end_date,
    this.employee_id,
    this.emp_name,
    this.email,
    this.state,
    this.dept_id,
    this.duration,
  });


  OvertimeRequestLine copyWith({
    String start_date,
    String end_date,
    int employee_id,
    String emp_name,
    String email,
    String state,
    int dept_id,
    double duration,
  }) {
    return OvertimeRequestLine(
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      employee_id: employee_id ?? this.employee_id,
      emp_name: emp_name ?? this.emp_name,
      email: email ?? this.email,
      state: state ?? this.state,
      dept_id: dept_id ?? this.dept_id,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'duration': duration,
      'start_date': start_date,
      'end_date': end_date,
      'email': email,
      'state': state,
    };
  }

  factory OvertimeRequestLine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OvertimeRequestLine(
      start_date: map['start_date'],
      end_date: map['end_date'],
      employee_id: map['employee_id'],
      emp_name: map['emp_name'],
      email: map['email'],
      state: map['state'],
      dept_id: map['dept_id'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeRequestLine.fromJson(String source) => OvertimeRequestLine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OvertimeRequestLine(start_date: $start_date, end_date: $end_date, employee_id: $employee_id, emp_name: $emp_name, email: $email, state: $state, dept_id: $dept_id, duration: $duration)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OvertimeRequestLine &&
        o.start_date == start_date &&
        o.end_date == end_date &&
        o.employee_id == employee_id &&
        o.emp_name == emp_name &&
        o.email == email &&
        o.state == state &&
        o.dept_id == dept_id &&
        o.duration == duration;
  }

  @override
  int get hashCode {
    return start_date.hashCode ^
    end_date.hashCode ^
    employee_id.hashCode ^
    emp_name.hashCode ^
    email.hashCode ^
    state.hashCode ^
    dept_id.hashCode ^
    duration.hashCode;
  }
}
