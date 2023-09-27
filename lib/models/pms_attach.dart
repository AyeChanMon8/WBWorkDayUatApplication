// @dart=2.9

import 'dart:convert';

class PMSAttach {
  String _name;
  String _attachment_file;

  String get name => _name;
  String get attachment_file => _attachment_file;

  PMSAttach({
    String name,
    String attachment_file}){
    _name = name;
    _attachment_file = attachment_file;
  }


  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["attachment_file"] = _attachment_file;
    map["name"] = _name;
    return map;
  }

}
