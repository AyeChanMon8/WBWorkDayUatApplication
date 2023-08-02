// @dart=2.9

/// job grade : ""
/// salary level : ""
/// wage : 0.0

class Employee_jobinfo {
  String _job_grade;
  String _salary_level;
  double _wage;
  String _salary_level_name;
  String _job_grade_name;

  String get job_grade => _job_grade;
  String get salary_level => _salary_level;
  double get wage => _wage;
  String get salary_level_name => _salary_level_name;
  String get job_grade_name => _job_grade_name;

  Employee_jobinfo({
      String job_grade,
      String salary_level,
      double wage,String job_grade_name,
    String salary_level_name}){
    _job_grade = job_grade;
    _salary_level = salary_level;
    _wage = wage;
    _job_grade_name = job_grade_name;
    _salary_level_name = salary_level_name;
}

  Employee_jobinfo.fromJson(dynamic json) {
    _job_grade = json['job_grade'].toString();
    _salary_level = json['salary_level'].toString();
    _wage = json['wage'];
    _salary_level_name = json['salary_level_name'].toString();
    _job_grade_name = json['job_grade_name'].toString();

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['job_grade'] = _job_grade;
    map['salary-level'] = _salary_level;
    map['wage'] = _wage;
    return map;
  }

}