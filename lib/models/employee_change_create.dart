// @dart=2.9

import 'dart:convert';

/// type : "promotion/demotion/transfer/employee_change"
/// employee_id : "id"
/// company_id : "id"
/// branch_id : "id"
/// department_id : "id"
/// job_id : "id"
/// job_grade_id : "id"
/// salary_level_id : "id"
/// wage : 300000
/// date : "2021-10-10"
/// new_company_id : "id"
/// new_branch_id : "id"
/// new_department_id : "id"
/// new_job_id : "id"
/// new_job_grade_id : "id"
/// new_salary_level_id : "id"
/// new_wage : 400000
/// new_approved_manager_id : "id"
/// note : "Testing emp changes"
class Employee_change_create {
  String type;
  int employeeId;
  int companyId;
  int branchId;
  int departmentId;
  int jobId;
  int jobGradeId;
  int salaryLevelId;
  double wage;
  String date;
  int newCompanyId;
  int newBranchId;
  int newDepartmentId;
  int newJobId;
  int newJobGradeId;
  int newSalaryLevelId;
  double newWage;
  int newApprovedManagerId;
  String note;
  Employee_change_create({
    this.type,
    this.employeeId,
    this.companyId,
    this.branchId,
    this.departmentId,
    this.jobId,
    this.jobGradeId,
    this.salaryLevelId,
    this.wage,
    this.date,
    this.newCompanyId,
    this.newBranchId,
    this.newDepartmentId,
    this.newJobId,
    this.newJobGradeId,
    this.newSalaryLevelId,
    this.newWage,
    this.newApprovedManagerId,
    this.note,

  });


  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'employee_id': employeeId,
      'company_id' : companyId,
      'branch_id': branchId,
      'department_id': departmentId,
      'job_id': jobId,
      'job_grade_id': jobGradeId,
      'salary_level_id' : salaryLevelId,
      'wage': wage,
      'date': date,
      'new_company_id': newCompanyId,
      'new_branch_id': newBranchId,
      'new_department_id' : newDepartmentId,
      'new_job_id': newJobId,
      'new_job_grade_id': newJobGradeId,
      'new_salary_level_id': newSalaryLevelId,
      'new_wage': newWage,
      'new_approved_manager_id': newApprovedManagerId,
      'note': note,


    };
  }

  String toJson() => json.encode(toMap());

}
