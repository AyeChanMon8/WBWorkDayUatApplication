// @dart=2.9

import 'package:winbrother_hr_app/models/warning_attach_model.dart';

/// id : 13
/// employee_id : [{"id":6115,"name":"Ahr Yu","reward_carried_forward":0,"reward_this_year":0,"reward_total":0}]
/// reward_type_id : [{"id":5,"name":"R01"}]
/// reward_title_id : [{"id":1,"name":"Full Attendance"}]
/// state : "draft"
/// date : "2021-02-05"
/// description : "Nice."
/// mark : 0

class Reward {
  int _id;
  List<Employee_id> _employeeId;
  List<Reward_type_id> _rewardTypeId;
  List<Reward_title_id> _rewardTitleId;
  List<RewardAction> _rewardActionId;
  List<WarningAttachModel> _warningAttachId;
  String _state;
  String _date;
  String _description;
  double _mark;
  String _code;

  int get id => _id;
  List<Employee_id> get employeeId => _employeeId;
  List<Reward_type_id> get rewardTypeId => _rewardTypeId;
  List<Reward_title_id> get rewardTitleId => _rewardTitleId;
  List<RewardAction> get rewardActionId => _rewardActionId;
  List<WarningAttachModel> get warningAttachId => _warningAttachId;
  String get state => _state;
  String get date => _date;
  String get description => _description;
  double get mark => _mark;
  String get code => _code;

  Reward({
      int id, 
      List<Employee_id> employeeId, 
      List<Reward_type_id> rewardTypeId, 
      List<Reward_title_id> rewardTitleId,
      List<RewardAction> rewardActionId,
    List<WarningAttachModel> warningAttachId,
    String state,
      String date, 
      String description, 
      double mark,String code}){
    _id = id;
    _employeeId = employeeId;
    _rewardTypeId = rewardTypeId;
    _rewardTitleId = rewardTitleId;
    _rewardActionId = rewardActionId;
    _warningAttachId= warningAttachId;
    _state = state;
    _date = date;
    _description = description;
    _mark = mark;
    _code = code;
}

  Reward.fromJson(dynamic json) {
    _id = json["id"];
    if (json["employee_id"] != null) {
      _employeeId = [];
      json["employee_id"].forEach((v) {
        _employeeId.add(Employee_id.fromJson(v));
      });
    }
    if (json["reward_type_id"] != null) {
      _rewardTypeId = [];
      json["reward_type_id"].forEach((v) {
        _rewardTypeId.add(Reward_type_id.fromJson(v));
      });
    }
    if (json["reward_title_id"] != null) {
      _rewardTitleId = [];
      json["reward_title_id"].forEach((v) {
        _rewardTitleId.add(Reward_title_id.fromJson(v));
      });
    }
    if (json["manager_reward_ids"] != null) {
      _rewardActionId = [];
      json["manager_reward_ids"].forEach((v) {
        _rewardActionId.add(RewardAction.fromJson(v));
      });
    }
    if (json["warning_attach_id"] != null) {
      _warningAttachId = [];
      json["warning_attach_id"].forEach((v) {
        _warningAttachId.add(WarningAttachModel.fromMap(v));
      });
    }
    _state = json["state"];
    _date = json["date"];
    _description = json["description"];
    _mark = json["mark"];
    _code = json["name"]==null?'':json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.map((v) => v.toJson()).toList();
    }
    if (_rewardTypeId != null) {
      map["reward_type_id"] = _rewardTypeId.map((v) => v.toJson()).toList();
    }
    if (_rewardTitleId != null) {
      map["reward_title_id"] = _rewardTitleId.map((v) => v.toJson()).toList();
    }
    if (_rewardActionId != null) {
      map["reward_title_id"] = _rewardActionId.map((v) => v.toJson()).toList();
    }
    if (_warningAttachId != null) {
      map["reward_title_id"] = _warningAttachId.map((v) => v.toJson()).toList();
    }
    map["state"] = _state;
    map["date"] = _date;
    map["description"] = _description;
    map["mark"] = _mark;
    map["name"] = _code;
    return map;
  }

}
class RewardAction {
  Reward_title_id _employee;
  double _mark;

  Reward_title_id get employee => _employee;
  double get mark => _mark;

  RewardAction({
    Reward_title_id employee,
    double mark}){
    _employee = employee;
    _mark = mark;
  }

  RewardAction.fromJson(dynamic json) {
    _employee = Reward_title_id.fromJson(json["employee_id"]);
    _mark = json["mark"]==null?0.0:json["mark"];
  }
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["employee_id"] = _employee;
    map["mark"] = _mark;

    return map;
  }

}
/// id : 1
/// name : "Full Attendance"

class Reward_title_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Reward_title_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Reward_title_id.fromJson(dynamic json) {
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
/// name : "R01"

class Reward_type_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Reward_type_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Reward_type_id.fromJson(dynamic json) {
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
/// reward_carried_forward : 0
/// reward_this_year : 0
/// reward_total : 0

class Employee_id {
  int _id;
  String _name;
  double _rewardCarriedForward;
  double _rewardThisYear;
  double _rewardTotal;

  int get id => _id;
  String get name => _name;
  double get rewardCarriedForward => _rewardCarriedForward;
  double get rewardThisYear => _rewardThisYear;
  double get rewardTotal => _rewardTotal;

  Employee_id({
      int id, 
      String name, 
      double rewardCarriedForward,
      double rewardThisYear,
      double rewardTotal}){
    _id = id;
    _name = name;
    _rewardCarriedForward = rewardCarriedForward;
    _rewardThisYear = rewardThisYear;
    _rewardTotal = rewardTotal;
}

  Employee_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _rewardCarriedForward = json["reward_carried_forward"];
    _rewardThisYear = json["reward_this_year"];
    _rewardTotal = json["reward_total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["reward_carried_forward"] = _rewardCarriedForward;
    map["reward_this_year"] = _rewardThisYear;
    map["reward_total"] = _rewardTotal;
    return map;
  }

}