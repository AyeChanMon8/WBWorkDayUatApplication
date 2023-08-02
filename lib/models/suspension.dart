// @dart=2.9

class Suspension {
  int _id;
  String _name;
  Employee_id _employeeId;
  Department_id _departmentId;
  String _suspension_reason;
  dynamic _joinedDate;
  String _approvedRevealingDate;
  String _suspension_submit_date;
  Employee_id _company_id;
  Employee_id _branch_id;
  Job_id _job_id;
  Job_grade_id _job_grade_id;

  int get id => _id;
  String get name => _name;
  String get suspension_submit_date => _suspension_submit_date;
  Employee_id get employeeId => _employeeId;
  Department_id get departmentId => _departmentId;
  String get suspension_reason => _suspension_reason;
  dynamic get joinedDate => _joinedDate;
  String get approvedRevealingDate => _approvedRevealingDate;
  Employee_id get company_id => _company_id;
  Employee_id get branch_id => _branch_id;
  Job_id get job_id => _job_id;
  Job_grade_id get job_grade_id => _job_grade_id;

  Suspension({
      int id,
      String name,
      Employee_id employeeId,
      Department_id departmentId,
      String employeeContract,
      String suspension_reason,
      dynamic joinedDate,
      String approvedRevealingDate,
      String suspension_submit_date,
      Job_id job_id,
      Job_grade_id job_grade_id,
      }){
    _id = id;
    _name = name;
    _employeeId = employeeId;
    _departmentId = departmentId;
    _suspension_reason = suspension_reason;
    _joinedDate = joinedDate;
    _approvedRevealingDate = approvedRevealingDate;
    _suspension_submit_date = suspension_submit_date;
    _job_id = job_id;
    _job_grade_id = job_grade_id;
}

  Suspension.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _departmentId = json["department_id"] != null ? Department_id.fromJson(json["department_id"]) : null;
    _suspension_reason = json["suspension_reason"];
    _joinedDate = json["joined_date"];
    _approvedRevealingDate = json["approved_revealing_date"];
    _suspension_submit_date = json["suspension_submit_date"];
    _company_id = json["company_id"] != null ? Employee_id.fromJson(json["company_id"]) : null;
    _branch_id = json["branch_id"] != null ? Employee_id.fromJson(json["branch_id"]) : null;
    _job_id = json["job_id"] != null ? Job_id.fromJson(json["job_id"]) : null;
    _job_grade_id = json["job_grade_id"] != null ? Job_grade_id.fromJson(json["job_grade_id"]) : null;
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
    map["suspension_reason"] = _suspension_reason;
    map["joined_date"] = _joinedDate;
    map["approved_revealing_date"] = _approvedRevealingDate;
    map["suspension_submit_date"] = _suspension_submit_date;
    if (_job_id != null) {
      map["job_id"] = _job_id?.toJson();
    }
    if (_job_grade_id != null) {
      map["job_grade_id"] = _job_grade_id?.toJson();
    }
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

class Job_grade_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Job_grade_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Job_grade_id.fromJson(dynamic json) {
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