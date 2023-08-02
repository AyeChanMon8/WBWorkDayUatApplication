// @dart=2.9

/// id : 2
/// policy_type : "Testing"
/// policy_number : 10
/// benefit : "Health care"
/// policy_coverage : "12345"
/// effective_date : "2021-03-01"
/// expire_date : "2022-02-01"
/// premium_amount : 1000000.0
/// coverage_amount : 1000000.0
/// fees_employee : 100000.0
/// fees_employer : 100000.0
/// installment : 10
/// deduction_per_month : 100000.0
/// attachment_id : [{"id":32963,"name":"20190912-23_ethnic_issue_unity-and-diversity-series-1_final.pdf","type":"binary","url":null,"datas":"image","mimetype":"application/pdf","index_content":"application"}]

class Insurancetypemodel {
  int _id;
  String _policyType;
  int _policyNumber;
  String _benefit;
  String _policyCoverage;
  String _effectiveDate;
  String _expireDate;
  double _premiumAmount;
  double _coverageAmount;
  double _feesEmployee;
  double _feesEmployer;
  int _installment;
  double _deductionPerMonth;
  List<Attachment_id> _attachmentId;

  int get id => _id;
  String get policyType => _policyType;
  int get policyNumber => _policyNumber;
  String get benefit => _benefit;
  String get policyCoverage => _policyCoverage;
  String get effectiveDate => _effectiveDate;
  String get expireDate => _expireDate;
  double get premiumAmount => _premiumAmount;
  double get coverageAmount => _coverageAmount;
  double get feesEmployee => _feesEmployee;
  double get feesEmployer => _feesEmployer;
  int get installment => _installment;
  double get deductionPerMonth => _deductionPerMonth;
  List<Attachment_id> get attachmentId => _attachmentId;

  Insurancetypemodel({
      int id, 
      String policyType, 
      int policyNumber, 
      String benefit, 
      String policyCoverage, 
      String effectiveDate, 
      String expireDate, 
      double premiumAmount, 
      double coverageAmount, 
      double feesEmployee, 
      double feesEmployer, 
      int installment, 
      double deductionPerMonth, 
      List<Attachment_id> attachmentId}){
    _id = id;
    _policyType = policyType;
    _policyNumber = policyNumber;
    _benefit = benefit;
    _policyCoverage = policyCoverage;
    _effectiveDate = effectiveDate;
    _expireDate = expireDate;
    _premiumAmount = premiumAmount;
    _coverageAmount = coverageAmount;
    _feesEmployee = feesEmployee;
    _feesEmployer = feesEmployer;
    _installment = installment;
    _deductionPerMonth = deductionPerMonth;
    _attachmentId = attachmentId;
}

  Insurancetypemodel.fromJson(dynamic json) {
    _id = json["id"];
    _policyType = json["policy_type"];
    _policyNumber = json["policy_number"]==null?0:json["policy_number"];
    _benefit = json["benefit"]==null?0:json["benefit"];
    _policyCoverage = json["policy_coverage"]==null?0:json["policy_coverage"];
    _effectiveDate = json["effective_date"];
    _expireDate = json["expire_date"];
    _premiumAmount = json["premium_amount"];
    _coverageAmount = json["coverage_amount"];
    _feesEmployee = json["fees_employee"];
    _feesEmployer = json["fees_employer"];
    _installment = json["installment"];
    _deductionPerMonth = json["deduction_per_month"]==null?0.0:json["deduction_per_month"];
    if (json["attachment_id"] != null) {
      _attachmentId = [];
      json["attachment_id"].forEach((v) {
        _attachmentId.add(Attachment_id.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["policy_type"] = _policyType;
    map["policy_number"] = _policyNumber;
    map["benefit"] = _benefit;
    map["policy_coverage"] = _policyCoverage;
    map["effective_date"] = _effectiveDate;
    map["expire_date"] = _expireDate;
    map["premium_amount"] = _premiumAmount;
    map["coverage_amount"] = _coverageAmount;
    map["fees_employee"] = _feesEmployee;
    map["fees_employer"] = _feesEmployer;
    map["installment"] = _installment;
    map["deduction_per_month"] = _deductionPerMonth;
    if (_attachmentId != null) {
      map["attachment_id"] = _attachmentId.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 32963
/// name : "20190912-23_ethnic_issue_unity-and-diversity-series-1_final.pdf"
/// type : "binary"
/// url : null
/// datas : "image"
/// mimetype : "application/pdf"
/// index_content : "application"

class Attachment_id {
  int _id;
  String _name;
  String _type;
  dynamic _url;
  String _datas;
  String _mimetype;
  String _indexContent;

  int get id => _id;
  String get name => _name;
  String get type => _type;
  dynamic get url => _url;
  String get datas => _datas;
  String get mimetype => _mimetype;
  String get indexContent => _indexContent;

  Attachment_id({
      int id, 
      String name, 
      String type, 
      dynamic url, 
      String datas, 
      String mimetype, 
      String indexContent}){
    _id = id;
    _name = name;
    _type = type;
    _url = url;
    _datas = datas;
    _mimetype = mimetype;
    _indexContent = indexContent;
}

  Attachment_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _type = json["type"];
    _url = json["url"];
    _datas = json["datas"];
    _mimetype = json["mimetype"];
    _indexContent = json["index_content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["type"] = _type;
    map["url"] = _url;
    map["datas"] = _datas;
    map["mimetype"] = _mimetype;
    map["index_content"] = _indexContent;
    return map;
  }

}