// @dart=2.9

class Stock_location {
  int _id;
  String _name;
  String _completeName;

  int get id => _id;
  String get name => _name;
  String get completeName => _completeName;

  Stock_location({
      int id, 
      String name, 
      String completeName}){
    _id = id;
    _name = name;
    _completeName = completeName;
}

  Stock_location.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _completeName = json["complete_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["complete_name"] = _completeName;
    return map;
  }

  factory Stock_location.fromMap(Map<String, dynamic> map) {
    return new Stock_location(
      id: map['id'] as int,
      name: map['name'] as String,
      completeName: map['completeName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': this._id,
      '_name': this._name,
      '_completeName': this._completeName,
    } as Map<String, dynamic>;
  }
}