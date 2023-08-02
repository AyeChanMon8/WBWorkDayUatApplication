// @dart=2.9

import 'package:winbrother_hr_app/models/warning_attach_model.dart';

/// id : 39
/// employee_id : [{"id":6115,"name":"Ahr Yu","warning_carried_forward":0.0,"warning_this_year":-3.0,"warning_total":-3.0}]
/// warning_type_id : [{"id":14,"name":"W11_Small Case Workplace/SOP"}]
/// warning_title_id : [{"id":4,"name":"ဂျူတီအဝင်/အထွက် Fingerprint မရိုက်နှိပ်ခြင်း။"}]
/// manager_warning_ids : []
/// temp_lines : []
/// state : "submit"
/// date : "2021-01-07"
/// description : "TESTING 2"
/// mark : -1.0

class Warning_model {
  int _id;
  List<Employee_id> _employeeId;
  List<Warning_type_id> _warningTypeId;
  List<Warning_title_id> _warningTitleId;
  //List<dynamic> _managerWarningIds;
  List<ManagerWarning> _managerWarningIds;
  List<WarningAttachModel> _warningAttachId;
  List<dynamic> _tempLines;
  String _state;
  String _date;
  String _description;
  double _mark;
  String _code;

  int get id => _id;
  List<Employee_id> get employeeId => _employeeId;
  List<Warning_type_id> get warningTypeId => _warningTypeId;
  List<Warning_title_id> get warningTitleId => _warningTitleId;
  List<ManagerWarning> get managerWarningIds => _managerWarningIds;
  List<WarningAttachModel> get warningAttachId => _warningAttachId;
  List<dynamic> get tempLines => _tempLines;
  String get state => _state;
  String get date => _date;
  String get description => _description;
  double get mark => _mark;
  String get code => _code;

  Warning_model(
      {int id,
      List<Employee_id> employeeId,
      List<Warning_type_id> warningTypeId,
      List<Warning_title_id> warningTitleId,
      List<dynamic> managerWarningIds,
      List<dynamic> tempLines,
      String state,
      String date,
      String description,
      double mark,
      String code}) {
    _id = id;
    _employeeId = employeeId;
    _warningTypeId = warningTypeId;
    _warningTitleId = warningTitleId;
    _managerWarningIds = managerWarningIds;
    _warningAttachId = warningAttachId;
    _tempLines = tempLines;
    _state = state;
    _date = date;
    _description = description;
    _mark = mark;
    _code = code;
  }

  Warning_model.fromJson(dynamic json) {
    _id = json["id"];
    if (json["employee_id"] != null) {
      _employeeId = [];
      json["employee_id"].forEach((v) {
        _employeeId.add(Employee_id.fromJson(v));
      });
    }
    if (json["warning_type_id"] != null) {
      _warningTypeId = [];
      json["warning_type_id"].forEach((v) {
        _warningTypeId.add(Warning_type_id.fromJson(v));
      });
    }
    if (json["warning_title_id"] != null) {
      _warningTitleId = [];
      json["warning_title_id"].forEach((v) {
        _warningTitleId.add(Warning_title_id.fromJson(v));
      });
    }
    if (json["manager_warning_ids"] != null) {
      _managerWarningIds = [];
      json["manager_warning_ids"].forEach((v) {
        _managerWarningIds.add(ManagerWarning.fromJson(v));
      });
    }
    if (json["warning_attach_id"] != null) {
      _warningAttachId = [];
      json["warning_attach_id"].forEach((v) {
        _warningAttachId.add(WarningAttachModel.fromMap(v));
      });
    }
    // if (json["temp_lines"] != null) {
    //   _tempLines = [];
    //   json["temp_lines"].forEach((v) {
    //     _tempLines.add(dynamic.fromJson(v));
    //   });
    // }
    _state = json["state"];
    _date = json["date"];
    _description = json["description"];
    _mark = json["mark"];
    _code = json["name"] == null ? '' : json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.map((v) => v.toJson()).toList();
    }
    if (_warningTypeId != null) {
      map["warning_type_id"] = _warningTypeId.map((v) => v.toJson()).toList();
    }
    if (_warningTitleId != null) {
      map["warning_title_id"] = _warningTitleId.map((v) => v.toJson()).toList();
    }
    if (_managerWarningIds != null) {
      map["manager_warning_ids"] =
          _managerWarningIds.map((v) => v.toJson()).toList();
    }
    if (_warningAttachId != null) {
      map["warning_attach_id"] =
          _warningAttachId.map((v) => v.toMap()).toList();
    }
    if (_tempLines != null) {
      map["temp_lines"] = _tempLines.map((v) => v.toJson()).toList();
    }
    map["state"] = _state;
    map["date"] = _date;
    map["description"] = _description;
    map["mark"] = _mark;
    map["name"] = _code;
    return map;
  }
}

/// id : 4
/// name : "ဂျူတီအဝင်/အထွက် Fingerprint မရိုက်နှိပ်ခြင်း။"

class Warning_title_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Warning_title_id({int id, String name}) {
    _id = id;
    _name = name;
  }

  Warning_title_id.fromJson(dynamic json) {
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

class ManagerWarning {
  Warning_title_id _employee;
  double _mark;

  Warning_title_id get employee => _employee;
  double get mark => _mark;

  ManagerWarning({Warning_title_id employee, double mark}) {
    _employee = employee;
    _mark = mark;
  }

  ManagerWarning.fromJson(dynamic json) {
    _employee = Warning_title_id.fromJson(json["employee_id"]);
    _mark = json["mark"] == null ? 0.0 : json["mark"];
  }
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["employee_id"] = _employee;
    map["mark"] = _mark;

    return map;
  }
}

/// id : 14
/// name : "W11_Small Case Workplace/SOP"

class Warning_type_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Warning_type_id({int id, String name}) {
    _id = id;
    _name = name;
  }

  Warning_type_id.fromJson(dynamic json) {
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

/// id : 6115
/// name : "Ahr Yu"
/// warning_carried_forward : 0.0
/// warning_this_year : -3.0
/// warning_total : -3.0

class Employee_id {
  int _id;
  String _name;
  double _warningCarriedForward;
  double _warningThisYear;
  double _warningTotal;

  int get id => _id;
  String get name => _name;
  double get warningCarriedForward => _warningCarriedForward;
  double get warningThisYear => _warningThisYear;
  double get warningTotal => _warningTotal;

  Employee_id(
      {int id,
      String name,
      double warningCarriedForward,
      double warningThisYear,
      double warningTotal}) {
    _id = id;
    _name = name;
    _warningCarriedForward = warningCarriedForward;
    _warningThisYear = warningThisYear;
    _warningTotal = warningTotal;
  }

  Employee_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _warningCarriedForward = json["warning_carried_forward"];
    _warningThisYear = json["warning_this_year"];
    _warningTotal = json["warning_total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["warning_carried_forward"] = _warningCarriedForward;
    map["warning_this_year"] = _warningThisYear;
    map["warning_total"] = _warningTotal;
    return map;
  }
}
