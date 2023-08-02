// @dart=2.9

/// id : 1
/// name : "RES001"
/// employee_id : {"id":null,"name":null}
/// department_id : {"id":null,"name":null}
/// employee_contract : "Ahr Yu"
/// resignation_type : null
/// reason : "test"
/// joined_date : null
/// expected_revealing_date : "2020-09-30"
/// approved_revealing_date : "2020-10-15"
/// notice_period : "0"

class Resignation {
  int _id;
  String _name;
  Employee_id _employeeId;
  Department_id _departmentId;
  String _employeeContract;
  dynamic _resignationType;
  String _reason;
  dynamic _joinedDate;
  String _expectedRevealingDate;
  String _approvedRevealingDate;
  String _noticePeriod;
  String _confirm_date;
  Employee_id _company_id;
  Employee_id _branch_id;

  int get id => _id;
  String get name => _name;
  String get confirm_date => _confirm_date;
  Employee_id get employeeId => _employeeId;
  Department_id get departmentId => _departmentId;
  String get employeeContract => _employeeContract;
  dynamic get resignationType => _resignationType;
  String get reason => _reason;
  dynamic get joinedDate => _joinedDate;
  String get expectedRevealingDate => _expectedRevealingDate;
  String get approvedRevealingDate => _approvedRevealingDate;
  String get noticePeriod => _noticePeriod;
  Employee_id get company_id => _company_id;
  Employee_id get branch_id => _branch_id;

  Resignation({
      int id,
      String name,
      Employee_id employeeId,
      Department_id departmentId,
      String employeeContract,
      dynamic resignationType,
      String reason,
      dynamic joinedDate,
      String expectedRevealingDate,
      String approvedRevealingDate,
      String noticePeriod,String confirmDate}){
    _id = id;
    _name = name;
    _employeeId = employeeId;
    _departmentId = departmentId;
    _employeeContract = employeeContract;
    _resignationType = resignationType;
    _reason = reason;
    _joinedDate = joinedDate;
    _expectedRevealingDate = expectedRevealingDate;
    _approvedRevealingDate = approvedRevealingDate;
    _noticePeriod = noticePeriod;
    _confirm_date = confirmDate;
}

  Resignation.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _departmentId = json["department_id"] != null ? Department_id.fromJson(json["department_id"]) : null;
    _employeeContract = json["employee_contract"];
    _resignationType = json["resignation_type"];
    _reason = json["reason"];
    _joinedDate = json["joined_date"];
    _expectedRevealingDate = json["expected_revealing_date"];
    _approvedRevealingDate = json["approved_revealing_date"];
    _noticePeriod = json["notice_period"];
    _confirm_date = json["resign_confirm_date"];
    _company_id = json["company_id"] != null ? Employee_id.fromJson(json["company_id"]) : null;
    _branch_id = json["branch_id"] != null ? Employee_id.fromJson(json["branch_id"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId?.toJson();
    }
    if (_departmentId != null) {
      map["department_id"] = _departmentId?.toJson();
    }
    map["employee_contract"] = _employeeContract;
    map["resignation_type"] = _resignationType;
    map["reason"] = _reason;
    map["joined_date"] = _joinedDate;
    map["expected_revealing_date"] = _expectedRevealingDate;
    map["approved_revealing_date"] = _approvedRevealingDate;
    map["notice_period"] = _noticePeriod;
    return map;
  }

}

/// id : null
/// name : null

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
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : null
/// name : null

class Employee_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Employee_id({
      dynamic id,
      dynamic name}){
    _id = id;
    _name = name;
}

  Employee_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}