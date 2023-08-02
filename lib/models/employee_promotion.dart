// @dart=2.9

/// id : 1
/// name : "Changing Salary of Lin Zaw Oo"
/// type : "salary_change"
/// employee_id : {"id":5958,"name":"Lin Zaw Oo"}
/// company_id : {"id":11,"name":"WIN BROTHERS BACK OFFICE GROUP"}
/// branch_id : {"id":36,"name":"WB BO SITE"}
/// department_id : {"id":493,"name":"OFFICE FLEET TEAM"}
/// job_id : {"id":1332,"name":"Fleet Incharge"}
/// job_grade_id : {"id":5,"name":"G-02"}
/// salary_level_id : {"id":7,"name":"L-06"}
/// wage : 250000.0
/// date : "2020-10-01"
/// new_company_id : {"id":11,"name":"WIN BROTHERS BACK OFFICE GROUP"}
/// new_branch_id : {"id":36,"name":"WB BO SITE"}
/// new_department_id : {"id":493,"name":"OFFICE FLEET TEAM"}
/// new_job_id : {"id":1332,"name":"Fleet Incharge"}
/// new_job_grade_id : {"id":5,"name":"G-02"}
/// new_salary_level_id : {"id":12,"name":"L-11"}
/// new_wage : 300000.0
/// note : null

class Employee_promotion {
  int _id;
  String _name;
  String _type;
  Employee_id _employeeId;
  Company_id _companyId;
  Branch_id _branchId;
  Department_id _departmentId;
  Job_id _jobId;
  Job_grade_id _jobGradeId;
  Salary_level_id _salaryLevelId;
  double _wage;
  String _date;
  New_company_id _newCompanyId;
  New_branch_id _newBranchId;
  New_department_id _newDepartmentId;
  New_job_id _newJobId;
  New_job_grade_id _newJobGradeId;
  New_salary_level_id _newSalaryLevelId;
  double _newWage;
  dynamic _note;
  String _state;

  int get id => _id;
  String get name => _name;
  String get type => _type;
  Employee_id get employeeId => _employeeId;
  Company_id get companyId => _companyId;
  Branch_id get branchId => _branchId;
  Department_id get departmentId => _departmentId;
  Job_id get jobId => _jobId;
  Job_grade_id get jobGradeId => _jobGradeId;
  Salary_level_id get salaryLevelId => _salaryLevelId;
  double get wage => _wage;
  String get date => _date;
  New_company_id get newCompanyId => _newCompanyId;
  New_branch_id get newBranchId => _newBranchId;
  New_department_id get newDepartmentId => _newDepartmentId;
  New_job_id get newJobId => _newJobId;
  New_job_grade_id get newJobGradeId => _newJobGradeId;
  New_salary_level_id get newSalaryLevelId => _newSalaryLevelId;
  double get newWage => _newWage;
  dynamic get note => _note;
  String get state => _state;

  Employee_promotion({
      int id, 
      String name, 
      String type, 
      Employee_id employeeId, 
      Company_id companyId, 
      Branch_id branchId, 
      Department_id departmentId, 
      Job_id jobId, 
      Job_grade_id jobGradeId, 
      Salary_level_id salaryLevelId, 
      double wage, 
      String date, 
      New_company_id newCompanyId, 
      New_branch_id newBranchId, 
      New_department_id newDepartmentId, 
      New_job_id newJobId, 
      New_job_grade_id newJobGradeId, 
      New_salary_level_id newSalaryLevelId, 
      double newWage, 
      dynamic note}){
    _id = id;
    _name = name;
    _type = type;
    _employeeId = employeeId;
    _companyId = companyId;
    _branchId = branchId;
    _departmentId = departmentId;
    _jobId = jobId;
    _jobGradeId = jobGradeId;
    _salaryLevelId = salaryLevelId;
    _wage = wage;
    _date = date;
    _newCompanyId = newCompanyId;
    _newBranchId = newBranchId;
    _newDepartmentId = newDepartmentId;
    _newJobId = newJobId;
    _newJobGradeId = newJobGradeId;
    _newSalaryLevelId = newSalaryLevelId;
    _newWage = newWage;
    _note = note;
}

  Employee_promotion.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _type = json["type"];
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _companyId = json["company_id"] != null ? Company_id.fromJson(json["company_id"]) : null;
    _branchId = json["branch_id"] != null ? Branch_id.fromJson(json["branch_id"]) : null;
    _departmentId = json["department_id"] != null ? Department_id.fromJson(json["department_id"]) : null;
    _jobId = json["job_id"] != null ? Job_id.fromJson(json["job_id"]) : null;
    _jobGradeId = json["job_grade_id"] != null ? Job_grade_id.fromJson(json["job_grade_id"]) : null;
    _salaryLevelId = json["salary_level_id"] != null ? Salary_level_id.fromJson(json["salary_level_id"]) : null;
    _wage = json["wage"];
    _date = json["date"];
    _newCompanyId = json["new_company_id"] != null ? New_company_id.fromJson(json["new_company_id"]) : null;
    _newBranchId = json["new_branch_id"] != null ? New_branch_id.fromJson(json["new_branch_id"]) : null;
    _newDepartmentId = json["new_department_id"] != null ? New_department_id.fromJson(json["new_department_id"]) : null;
    _newJobId = json["new_job_id"] != null ? New_job_id.fromJson(json["new_job_id"]) : null;
    _newJobGradeId = json["new_job_grade_id"] != null ? New_job_grade_id.fromJson(json["new_job_grade_id"]) : null;
    _newSalaryLevelId = json["new_salary_level_id"] != null ? New_salary_level_id.fromJson(json["new_salary_level_id"]) : null;
    _newWage = json["new_wage"];
    _note = json["note"];
    _state = json["state"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["type"] = _type;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.toJson();
    }
    if (_companyId != null) {
      map["company_id"] = _companyId.toJson();
    }
    if (_branchId != null) {
      map["branch_id"] = _branchId.toJson();
    }
    if (_departmentId != null) {
      map["department_id"] = _departmentId.toJson();
    }
    if (_jobId != null) {
      map["job_id"] = _jobId.toJson();
    }
    if (_jobGradeId != null) {
      map["job_grade_id"] = _jobGradeId.toJson();
    }
    if (_salaryLevelId != null) {
      map["salary_level_id"] = _salaryLevelId.toJson();
    }
    map["wage"] = _wage;
    map["date"] = _date;
    if (_newCompanyId != null) {
      map["new_company_id"] = _newCompanyId.toJson();
    }
    if (_newBranchId != null) {
      map["new_branch_id"] = _newBranchId.toJson();
    }
    if (_newDepartmentId != null) {
      map["new_department_id"] = _newDepartmentId.toJson();
    }
    if (_newJobId != null) {
      map["new_job_id"] = _newJobId.toJson();
    }
    if (_newJobGradeId != null) {
      map["new_job_grade_id"] = _newJobGradeId.toJson();
    }
    if (_newSalaryLevelId != null) {
      map["new_salary_level_id"] = _newSalaryLevelId.toJson();
    }
    map["new_wage"] = _newWage;
    map["note"] = _note;
    return map;
  }

}

/// id : 12
/// name : "L-11"

class New_salary_level_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_salary_level_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_salary_level_id.fromJson(dynamic json) {
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

/// id : 5
/// name : "G-02"

class New_job_grade_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_job_grade_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_job_grade_id.fromJson(dynamic json) {
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

/// id : 1332
/// name : "Fleet Incharge"

class New_job_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_job_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_job_id.fromJson(dynamic json) {
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

/// id : 493
/// name : "OFFICE FLEET TEAM"

class New_department_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_department_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_department_id.fromJson(dynamic json) {
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

/// id : 36
/// name : "WB BO SITE"

class New_branch_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_branch_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_branch_id.fromJson(dynamic json) {
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

/// id : 11
/// name : "WIN BROTHERS BACK OFFICE GROUP"

class New_company_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  New_company_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  New_company_id.fromJson(dynamic json) {
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

/// id : 7
/// name : "L-06"

class Salary_level_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Salary_level_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Salary_level_id.fromJson(dynamic json) {
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

/// id : 5
/// name : "G-02"

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

/// id : 1332
/// name : "Fleet Incharge"

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

/// id : 493
/// name : "OFFICE FLEET TEAM"

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

/// id : 36
/// name : "WB BO SITE"

class Branch_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Branch_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Branch_id.fromJson(dynamic json) {
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

/// id : 11
/// name : "WIN BROTHERS BACK OFFICE GROUP"

class Company_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Company_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Company_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
  @override
  String toString() {

    return _name;
  }

}

/// id : 5958
/// name : "Lin Zaw Oo"

class Employee_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Employee_id({
      int id, 
      String name}){
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