// @dart=2.9

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/employee_payslip.dart';
import 'package:winbrother_hr_app/models/line_ids.dart';

class PaySlips {
  int _id;
  String _month;
  String _year;
  String _dateFrom;
  String _dateTo;
  Employee_id _employeeId;
  List<Category_list> _categoryList;
  double _total;
  String _pin;
  String _slip_number;
  dynamic _bank_account_number;

  int get id => _id;
  String get month => _month;
  String get year => _year;
  String get dateFrom => _dateFrom;
  String get dateTo => _dateTo;
  Employee_id get employeeId => _employeeId;
  List<Category_list> get categoryList => _categoryList;
  double get total=> _total;
  String get pin => _pin;
  String get slip_number => _slip_number;
  dynamic get bank_account_number => _bank_account_number;

  PaySlips({
    int id,
    String month,
    String year,
    String dateFrom,
    String dateTo,
    Employee_id employeeId,
    List<Category_list> categoryList,
    String pin,
    String slip_number,
    String bank_account_number}){
    _id = id;
    _month = month;
    _year = year;
    _dateFrom = dateFrom;
    _dateTo = dateTo;
    _employeeId = employeeId;
    _categoryList = categoryList;
    _pin = pin;
    _slip_number = slip_number;
    _bank_account_number = bank_account_number;
  }

  PaySlips.fromJson(dynamic json) {
    _id = json['id'];
    _month = json['month'];
    _year = json['year'];
    _dateFrom = json['date_from'];
    _dateTo = json['date_to'];
    _employeeId = json['employee_id'] != null ? Employee_id.fromJson(json['employee_id']) : null;
    if (json['category_list'] != null) {
      _categoryList = [];
      json['category_list'].forEach((v) {
        _categoryList.add(Category_list.fromJson(v));
      });
    }
    _total = json['total'];
    _pin = json['pin'];
    _slip_number = json['slip_number'];
    _bank_account_number = json['bank_account_number'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['month'] = _month;
    map['year'] = _year;
    map['date_from'] = _dateFrom;
    map['date_to'] = _dateTo;
    if (_employeeId != null) {
      map['employee_id'] = _employeeId.toJson();
    }
    if (_categoryList != null) {
      map['category_list'] = _categoryList.map((v) => v.toJson()).toList();
    }
    map['pin'] = _pin;
    map['slip_number'] = _slip_number;
    map['bank_account_number'] = _bank_account_number;
    return map;
  }

}

/// name : "Basic Salary"
/// code : "BASIC"
/// total : 4600000.0

class Category_list {
  String _name;
  String _code;
  double _total;
  List<LineIDs> _lineList;

  String get name => _name;
  String get code => _code;
  double get total => _total;
  List<LineIDs> get lineList => _lineList;
  Category_list({
    String name,
    String code,
    double total}){
    _name = name;
    _code = code;
    _total = total;
  }

  Category_list.fromJson(dynamic json) {
    _name = json['name'];
    _code = json['code'];
    _total = json['total'];
    if (json['line_ids'] != null) {
      _lineList = [];
      json['line_ids'].forEach((v) {
        _lineList.add(LineIDs.fromMap(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['code'] = _code;
    map['total'] = _total;
    return map;
  }

}

/// id : 5098
/// name : "Kham Nandar Phe"
/// job_id : {"id":1342,"name":"Head of HR"}
/// department_id : {"id":410,"name":"HR DEPARTMENT"}

class Employee_id {
  int _id;
  String _name;
  Job_id _jobId;
  Department_id _departmentId;

  int get id => _id;
  String get name => _name;
  Job_id get jobId => _jobId;
  Department_id get departmentId => _departmentId;

  Employee_id({
    int id,
    String name,
    Job_id jobId,
    Department_id departmentId}){
    _id = id;
    _name = name;
    _jobId = jobId;
    _departmentId = departmentId;
  }

  Employee_id.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _jobId = json['job_id'] != null ? Job_id.fromJson(json['job_id']) : null;
    _departmentId = json['department_id'] != null ? Department_id.fromJson(json['department_id']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_jobId != null) {
      map['job_id'] = _jobId.toJson();
    }
    if (_departmentId != null) {
      map['department_id'] = _departmentId.toJson();
    }
    return map;
  }

}

/// id : 410
/// name : "HR DEPARTMENT"

class Department_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Department_id({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  Department_id.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 1342
/// name : "Head of HR"

class Job_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Job_id({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  Job_id.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}
