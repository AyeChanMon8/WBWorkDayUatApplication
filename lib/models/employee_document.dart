// @dart=2.9

/// id : 8
/// name : "P001_WB Employee Information"
/// employee_ref : {"id":5098,"name":"Kham Nandar Phe"}
/// document_type : {"id":6,"name":"WB Employee Information"}
/// issue_date : "2020-12-10"
/// expiry_date : null
/// notification_type : null
/// before_days : 0
/// description : null

class Employee_document {
  int _id;
  String _name;
  Employee_ref _employeeRef;
  Document_type _documentType;
  String _issueDate;
  dynamic _expiryDate;
  dynamic _notificationType;
  int _beforeDays;
  dynamic _description;

  int get id => _id;
  String get name => _name;
  Employee_ref get employeeRef => _employeeRef;
  Document_type get documentType => _documentType;
  String get issueDate => _issueDate;
  dynamic get expiryDate => _expiryDate;
  dynamic get notificationType => _notificationType;
  int get beforeDays => _beforeDays;
  dynamic get description => _description;

  Employee_document({
      int id, 
      String name, 
      Employee_ref employeeRef, 
      Document_type documentType, 
      String issueDate, 
      dynamic expiryDate, 
      dynamic notificationType, 
      int beforeDays, 
      dynamic description}){
    _id = id;
    _name = name;
    _employeeRef = employeeRef;
    _documentType = documentType;
    _issueDate = issueDate;
    _expiryDate = expiryDate;
    _notificationType = notificationType;
    _beforeDays = beforeDays;
    _description = description;
}

  Employee_document.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _employeeRef = json['employee_ref'] != null ? Employee_ref.fromJson(json['employee_ref']) : null;
    _documentType = json['document_type'] != null ? Document_type.fromJson(json['document_type']) : null;
    _issueDate = json['issue_date'];
    _expiryDate = json['expiry_date'];
    _notificationType = json['notification_type'];
    _beforeDays = json['before_days'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_employeeRef != null) {
      map['employee_ref'] = _employeeRef.toJson();
    }
    if (_documentType != null) {
      map['document_type'] = _documentType.toJson();
    }
    map['issue_date'] = _issueDate;
    map['expiry_date'] = _expiryDate;
    map['notification_type'] = _notificationType;
    map['before_days'] = _beforeDays;
    map['description'] = _description;
    return map;
  }

}

/// id : 6
/// name : "WB Employee Information"

class Document_type {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Document_type({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Document_type.fromJson(dynamic json) {
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

/// id : 5098
/// name : "Kham Nandar Phe"

class Employee_ref {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Employee_ref({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Employee_ref.fromJson(dynamic json) {
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