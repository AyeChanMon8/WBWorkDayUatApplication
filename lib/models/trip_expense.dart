// @dart=2.9

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:winbrother_hr_app/models/company.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/travel_expense/employee_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/pocket_line.dart';
import 'package:winbrother_hr_app/models/travel_expense/pocket_model.dart';
import 'package:winbrother_hr_app/models/trip_expense_line.dart';

class TripExpense {
  int id;
  String number;
  String date;
  String state;
  String source_doc;
  double advanced_money;
  EmployeeModel employee_id;
  Company company_id;
  double total_expense;
  double diff_amount;
  Company vendor_bill_id;
  Company daytrip_id;
  Company plantrip_product_id;
  Company plantrip_waybill_id;
  List<TripExpenseLine> trip_expense_lines;

  TripExpense({
    this.id,
    this.date,
    this.state,
    this.employee_id,
    this.company_id,
    this.trip_expense_lines,
    this.number, this.source_doc,
  });

  TripExpense copyWith({
    int id,
    String date,
    String state,
    EmployeeModel employee_id,
    Company company_id,
    List<PocketLine> pocket_line,
    String number,
  }) {
    return TripExpense(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      employee_id: employee_id ?? this.employee_id,
      company_id: company_id ?? this.company_id,
      trip_expense_lines: trip_expense_lines ?? this.trip_expense_lines,
      number: number ?? this.number,
      source_doc: source_doc ?? this.source_doc
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'state': state,
      'employee_id': employee_id?.toMap(),
      'company_id': company_id?.toMap(),
      'trip_expense_lines': trip_expense_lines?.map((x) => x?.toMap())?.toList(),
      'number': number,

    };
  }

  factory TripExpense.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TripExpense(
      id: map['id'],
      date: map['date'],
      state: map['state'],
      employee_id: EmployeeModel.fromMap(map['employee_id']),
      company_id: Company.fromMap(map['company_id']),
      trip_expense_lines: List<TripExpenseLine>.from(map['trip_expense_lines']?.map((x) => TripExpenseLine.fromMap(x))),
      number: map['number'],
      source_doc:  map['source_doc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripExpense.fromJson(String source) => TripExpense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripExpense(id: $id, date: $date, state: $state, employee_id: $employee_id, company_id: $company_id, pocket_line: $trip_expense_lines, number: $number)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TripExpense &&
        o.id == id &&
        o.date == date &&
        o.state == state &&
        o.employee_id == employee_id &&
        o.company_id == company_id &&
        listEquals(o.trip_expense_lines, trip_expense_lines) &&
        o.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    date.hashCode ^
    state.hashCode ^
    employee_id.hashCode ^
    company_id.hashCode ^
    trip_expense_lines.hashCode ^
    number.hashCode;
  }
}
