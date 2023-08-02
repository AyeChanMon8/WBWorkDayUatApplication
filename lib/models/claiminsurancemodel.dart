// @dart=2.9
/// id : 1
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// insurance_type_id : {"id":2,"policy_type":"Testing"}
/// insurance_id : {"id":null,"name":null}
/// date : "2021-04-01"
/// description : "Test"
/// claim_amount : 100000.0
/// coverage_amount : 0.0
/// balance : -100000.0
/// attachment_id : [{"id":32964,"name":"MicrosoftTeams-image (8).png","type":"binary","url":null,"datas":"image","mimetype":"image/png","index_content":"image"}]

class Claiminsurancemodel {
  int _id;
  Employee_id _employeeId;
  Insurance_type_id _insuranceTypeId;
  Insurance_id _insuranceId;
  String _date;
  String _description;
  double _claimAmount;
  double _coverageAmount;
  double _balance;
  String _attached_file;
  List<Insurance_id> _insurance_ids;

  int get id => _id;
  Employee_id get employeeId => _employeeId;
  Insurance_type_id get insuranceTypeId => _insuranceTypeId;
  Insurance_id get insuranceId => _insuranceId;
  String get date => _date;
  String get description => _description;
  double get claimAmount => _claimAmount;
  double get coverageAmount => _coverageAmount;
  double get balance => _balance;
  String get attachmentId => _attached_file;
  List<Insurance_id> get insurance_ids => _insurance_ids;

  Claiminsurancemodel({
      int id, 
      Employee_id employeeId, 
      Insurance_type_id insuranceTypeId, 
      Insurance_id insuranceId, 
      String date, 
      String description, 
      double claimAmount, 
      double coverageAmount, 
      double balance, 
      String attachmentId}){
    _id = id;
    _employeeId = employeeId;
    _insuranceTypeId = insuranceTypeId;
    _insuranceId = insuranceId;
    _date = date;
    _description = description;
    _claimAmount = claimAmount;
    _coverageAmount = coverageAmount;
    _balance = balance;
    _attached_file = attachmentId;
}

  Claiminsurancemodel.fromJson(dynamic json) {
    _id = json["id"];
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _insuranceTypeId = json["insurance_type_id"] != null ? Insurance_type_id.fromJson(json["insurance_type_id"]) : null;
    _insuranceId = json["insurance_id"] != null ? Insurance_id.fromJson(json["insurance_id"]) : null;
    _date = json["date"];
    _description = json["description"];
    _claimAmount = json["claim_amount"];
    _coverageAmount = json["coverage_amount"];
    _balance = json["balance"];
    _attached_file = json["attached_file"];
    if (json["insurance_ids"] != null) {
      _insurance_ids = [];
      json["insurance_ids"].forEach((v) {
        _insurance_ids.add(Insurance_id.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.toJson();
    }
    if (_insuranceTypeId != null) {
      map["insurance_type_id"] = _insuranceTypeId.toJson();
    }
    if (_insuranceId != null) {
      map["insurance_id"] = _insuranceId.toJson();
    }
    map["date"] = _date;
    map["description"] = _description;
    map["claim_amount"] = _claimAmount;
    map["coverage_amount"] = _coverageAmount;
    map["balance"] = _balance;
    map["attached_file"] = _attached_file;
    return map;
  }

}

/// id : 32964
/// name : "MicrosoftTeams-image (8).png"
/// type : "binary"
/// url : null
/// datas : "image"
/// mimetype : "image/png"
/// index_content : "image"

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

/// id : null
/// name : null

class Insurance_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Insurance_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  Insurance_id.fromJson(dynamic json) {
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

/// id : 2
/// policy_type : "Testing"

class Insurance_type_id {
  int _id;
  String _policyType;

  int get id => _id;
  String get policyType => _policyType;

  Insurance_type_id({
      int id, 
      String policyType}){
    _id = id;
    _policyType = policyType;
}

  Insurance_type_id.fromJson(dynamic json) {
    _id = json["id"];
    _policyType = json["policy_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["policy_type"] = _policyType;
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