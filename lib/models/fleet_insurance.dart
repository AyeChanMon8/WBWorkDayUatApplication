// @dart=2.9

/// id : 1
/// vehicle_id : {"id":7,"name":"Mitsubishi /Canter/3H/2417"}
/// insurance_type_id : {"id":1,"name":"FULL COVER"}
/// insurance_company : "GGI"
/// start_date : "2021-01-01"
/// end_date : "2021-12-31"
/// contact_person : "PHYO"
/// contact_phone : "09425014884"
/// by : "ABC"
/// attachment_id : [{"id":32957,"name":"Invoice_703411077.pdf","type":"binary","url":null,"datas":"image","mimetype":"application/pdf","index_content":"application"}]

class Fleet_insurance {
  int _id;
  Vehicle_id _vehicleId;
  Insurance_type_id _insuranceTypeId;
  String _insuranceCompany;
  String _startDate;
  String _endDate;
  String _contactPerson;
  String _contactPhone;
  String _by;
  List<Attachment_id> _attachmentId;

  int get id => _id;
  Vehicle_id get vehicleId => _vehicleId;
  Insurance_type_id get insuranceTypeId => _insuranceTypeId;
  String get insuranceCompany => _insuranceCompany;
  String get startDate => _startDate;
  String get endDate => _endDate;
  String get contactPerson => _contactPerson;
  String get contactPhone => _contactPhone;
  String get by => _by;
  List<Attachment_id> get attachmentId => _attachmentId;

  Fleet_insurance({
      int id, 
      Vehicle_id vehicleId, 
      Insurance_type_id insuranceTypeId, 
      String insuranceCompany, 
      String startDate, 
      String endDate, 
      String contactPerson, 
      String contactPhone, 
      String by, 
      List<Attachment_id> attachmentId}){
    _id = id;
    _vehicleId = vehicleId;
    _insuranceTypeId = insuranceTypeId;
    _insuranceCompany = insuranceCompany;
    _startDate = startDate;
    _endDate = endDate;
    _contactPerson = contactPerson;
    _contactPhone = contactPhone;
    _by = by;
    _attachmentId = attachmentId;
}

  Fleet_insurance.fromJson(dynamic json) {
    _id = json["id"];
    _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
    _insuranceTypeId = json["insurance_type_id"] != null ? Insurance_type_id.fromJson(json["insurance_type_id"]) : null;
    _insuranceCompany = json["insurance_company"];
    _startDate = json["start_date"];
    _endDate = json["end_date"];
    _contactPerson = json["contact_person"];
    _contactPhone = json["contact_phone"];
    _by = json["by"];
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
    if (_vehicleId != null) {
      map["vehicle_id"] = _vehicleId.toJson();
    }
    if (_insuranceTypeId != null) {
      map["insurance_type_id"] = _insuranceTypeId.toJson();
    }
    map["insurance_company"] = _insuranceCompany;
    map["start_date"] = _startDate;
    map["end_date"] = _endDate;
    map["contact_person"] = _contactPerson;
    map["contact_phone"] = _contactPhone;
    map["by"] = _by;
    if (_attachmentId != null) {
      map["attachment_id"] = _attachmentId.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

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

/// id : 1
/// name : "FULL COVER"

class Insurance_type_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Insurance_type_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Insurance_type_id.fromJson(dynamic json) {
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
/// name : "Mitsubishi /Canter/3H/2417"

class Vehicle_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Vehicle_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Vehicle_id.fromJson(dynamic json) {
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