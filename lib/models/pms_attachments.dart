// @dart=2.9

class PMSattachments {
  String _name;
  String _datas;
  
  String get name => _name;
  String get datas => _datas;

  PMSattachments({
      String name,
      String datas}){
    _name = name;
    _datas = datas;
}

  PMSattachments.fromJson(dynamic json) {
    _name = json["name"];
    _datas = json["datas"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["datas"] = _datas;
    return map;
  }

}