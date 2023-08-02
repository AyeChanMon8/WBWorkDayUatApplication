// @dart=2.9

/// id : 1
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// premium_amount : 1000000.0
/// insurance_type_id : {"id":2}
/// coverage_amount : 1000000.0
/// policy_number : 10
/// fees_employee : 100000.0
/// benefit : "Health care"
/// fees_employer : 100000.0
/// effective_date : "2021-03-01"
/// installment : 10
/// expire_date : "2022-02-01"
/// deduction_per_month : 100000.0
/// insurance_lines : [{"date":"2021-03-01","state":"open","amount":100000.0},{"date":"2021-04-01","state":"open","amount":100000.0},{"date":"2021-05-01","state":"open","amount":100000.0},{"date":"2021-06-01","state":"open","amount":100000.0},{"date":"2021-07-01","state":"open","amount":100000.0},{"date":"2021-08-01","state":"open","amount":100000.0},{"date":"2021-09-01","state":"open","amount":100000.0},{"date":"2021-10-01","state":"open","amount":100000.0},{"date":"2021-11-01","state":"open","amount":100000.0},{"date":"2021-12-01","state":"open","amount":100000.0}]
/// total_amount : 1000000.0
/// total_paid_amount : 0.0
/// balance_amount : 1000000.0

class Insurancemodel {
  int _id;
  Employee_id _employeeId;
  double _premiumAmount;
  Insurance_type_id _insuranceTypeId;
  double _coverageAmount;
  int _policyNumber;
  double _feesEmployee;
  String _benefit;
  double _feesEmployer;
  String _effectiveDate;
  int _installment;
  String _expireDate;
  double _deductionPerMonth;
  List<Insurance_lines> _insuranceLines;
  double _totalAmount;
  double _totalPaidAmount;
  double _balanceAmount;
  String _name;
  String _poilcy_coverage;

  int get id => _id;
  Employee_id get employeeId => _employeeId;
  double get premiumAmount => _premiumAmount;
  Insurance_type_id get insuranceTypeId => _insuranceTypeId;
  double get coverageAmount => _coverageAmount;
  int get policyNumber => _policyNumber;
  double get feesEmployee => _feesEmployee;
  String get benefit => _benefit;
  double get feesEmployer => _feesEmployer;
  String get effectiveDate => _effectiveDate;
  int get installment => _installment;
  String get expireDate => _expireDate;
  double get deductionPerMonth => _deductionPerMonth;
  List<Insurance_lines> get insuranceLines => _insuranceLines;
  double get totalAmount => _totalAmount;
  double get totalPaidAmount => _totalPaidAmount;
  double get balanceAmount => _balanceAmount;
  String get name => _name;
  String get poilcy_coverage => _poilcy_coverage;
  Insurancemodel({
      int id, 
      Employee_id employeeId, 
      double premiumAmount, 
      Insurance_type_id insuranceTypeId, 
      double coverageAmount, 
      int policyNumber, 
      double feesEmployee, 
      String benefit, 
      double feesEmployer, 
      String effectiveDate, 
      int installment, 
      String expireDate, 
      double deductionPerMonth, 
      List<Insurance_lines> insuranceLines, 
      double totalAmount, 
      double totalPaidAmount, 
      double balanceAmount}){
    _id = id;
    _employeeId = employeeId;
    _premiumAmount = premiumAmount;
    _insuranceTypeId = insuranceTypeId;
    _coverageAmount = coverageAmount;
    _policyNumber = policyNumber;
    _feesEmployee = feesEmployee;
    _benefit = benefit;
    _feesEmployer = feesEmployer;
    _effectiveDate = effectiveDate;
    _installment = installment;
    _expireDate = expireDate;
    _deductionPerMonth = deductionPerMonth;
    _insuranceLines = insuranceLines;
    _totalAmount = totalAmount;
    _totalPaidAmount = totalPaidAmount;
    _balanceAmount = balanceAmount;
}

  Insurancemodel.fromJson(dynamic json) {
    _name = json["name"];
    _id = json["id"];
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _premiumAmount = json["premium_amount"];
    _insuranceTypeId = json["insurance_type_id"] != null ? Insurance_type_id.fromJson(json["insurance_type_id"]) : null;
    _coverageAmount = json["coverage_amount"];
    _policyNumber = json["policy_number"];
    _feesEmployee = json["fees_employee"];
    _benefit = json["benefit"];
    _feesEmployer = json["fees_employer"];
    _effectiveDate = json["effective_date"];
    _installment = json["installment"];
    _expireDate = json["expire_date"];
    _deductionPerMonth = json["deduction_per_month"];
    if (json["insurance_lines"] != null) {
      _insuranceLines = [];
      json["insurance_lines"].forEach((v) {
        _insuranceLines.add(Insurance_lines.fromJson(v));
      });
    }
    _totalAmount = json["total_amount"];
    _totalPaidAmount = json["total_paid_amount"];
    _balanceAmount = json["balance_amount"];
    _poilcy_coverage = json["policy_coverage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.toJson();
    }
    map["premium_amount"] = _premiumAmount;
    if (_insuranceTypeId != null) {
      map["insurance_type_id"] = _insuranceTypeId.toJson();
    }
    map["coverage_amount"] = _coverageAmount;
    map["policy_number"] = _policyNumber;
    map["fees_employee"] = _feesEmployee;
    map["benefit"] = _benefit;
    map["fees_employer"] = _feesEmployer;
    map["effective_date"] = _effectiveDate;
    map["installment"] = _installment;
    map["expire_date"] = _expireDate;
    map["deduction_per_month"] = _deductionPerMonth;
    if (_insuranceLines != null) {
      map["insurance_lines"] = _insuranceLines.map((v) => v.toJson()).toList();
    }
    map["total_amount"] = _totalAmount;
    map["total_paid_amount"] = _totalPaidAmount;
    map["balance_amount"] = _balanceAmount;
    map["policy_coverage"] = _poilcy_coverage;
    return map;
  }

}

/// date : "2021-03-01"
/// state : "open"
/// amount : 100000.0

class Insurance_lines {
  String _date;
  String _state;
  double _amount;

  String get date => _date;
  String get state => _state;
  double get amount => _amount;

  Insurance_lines({
      String date, 
      String state, 
      double amount}){
    _date = date;
    _state = state;
    _amount = amount;
}

  Insurance_lines.fromJson(dynamic json) {
    _date = json["date"];
    _state = json["state"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    map["state"] = _state;
    map["amount"] = _amount;
    return map;
  }

}

/// id : 2

class Insurance_type_id {
  int _id;
  String _policy_type;

  int get id => _id;
  String get policy_type => _policy_type;

  Insurance_type_id({
      int id,String policy_type}){
    _id = id;
    _policy_type = policy_type;

}

  Insurance_type_id.fromJson(dynamic json) {
    _id = json["id"];
    _policy_type = json["policy_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["policy_type"] = _policy_type;
    return map;
  }

}

/// id : 6115
/// name : "Ahr Yu"

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