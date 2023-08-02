// @dart=2.9

import 'dart:convert';


import 'package:winbrother_hr_app/models/leave_balance.dart';

class LeaveReportList {
  int employee_id;
  String employee_name;
  List<LeaveBalance> balance_list;
  LeaveReportList({
    this.employee_id,
    this.employee_name,
    this.balance_list,
  });



  LeaveReportList copyWith({
    int employee_id,
    String employee_name,
    List<LeaveBalance> balance_list,
  }) {
    return LeaveReportList(
      employee_id: employee_id ?? this.employee_id,
      employee_name: employee_name ?? this.employee_name,
      balance_list: balance_list ?? this.balance_list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'employee_name': employee_name,
      'balance_list': balance_list?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory LeaveReportList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return LeaveReportList(
      employee_id: map['employee_id'],
      employee_name: map['employee_name'],
      balance_list: List<LeaveBalance>.from(map['balance_list']?.map((x) => LeaveBalance.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveReportList.fromJson(String source) => LeaveReportList.fromMap(json.decode(source));

  @override
  String toString() => 'LeaveReportList(employee_id: $employee_id, employee_name: $employee_name, balance_list: $balance_list)';


  @override
  int get hashCode => employee_id.hashCode ^ employee_name.hashCode ^ balance_list.hashCode;
}
