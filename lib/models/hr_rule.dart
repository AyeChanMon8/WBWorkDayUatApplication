// @dart=2.9

import 'package:winbrother_hr_app/models/line_ids.dart';

/// name : 1
/// line_ids : [{"name":"Basic Salary","code":"BASIC","total":4600000.0}]

class Hr_rule {
  int _id;
  String _name;
  List<LineIDs> _lineIds;
  int get id => _id;
  String get name => _name;
  List<LineIDs> get lineIds => _lineIds;

  Hr_rule({
    String name,
      List<LineIDs> lineIds}){
    _name = name;
    _lineIds = lineIds;
}

  Hr_rule.fromJson(dynamic json) {
    _name = json['name'];
    if (json['line_ids'] != null) {
      _lineIds = [];
      json['line_ids'].forEach((v) {
        _lineIds.add(LineIDs.fromJson(v));
      });
    }
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    if (_lineIds != null) {
      map['line_ids'] = _lineIds.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Basic Salary"
/// code : "BASIC"
/// total : 4600000.0

// class Line_ids {
//   String _name;
//   String _code;
//   double _total;
//
//   String get name => _name;
//   String get code => _code;
//   double get total => _total;
//
//   Line_ids({
//       String name,
//       String code,
//       double total}){
//     _name = name;
//     _code = code;
//     _total = total;
// }
//
//   Line_ids.fromJson(dynamic json) {
//     _name = json['name'];
//     _code = json['code'];
//     _total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['name'] = _name;
//     map['code'] = _code;
//     map['total'] = _total;
//     return map;
//   }
//
// }