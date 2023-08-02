// @dart=2.9

class Daytrip_advance_expense_category {
  int _id;
  String _displayName;
  dynamic _outOfPocketExpense;
  bool _travelExpense;
  dynamic _tripExpense;

  int get id => _id;
  String get displayName => _displayName;
  dynamic get outOfPocketExpense => _outOfPocketExpense;
  bool get travelExpense => _travelExpense;
  dynamic get tripExpense => _tripExpense;

  Daytrip_advance_expense_category({
      int id, 
      String displayName, 
      dynamic outOfPocketExpense, 
      bool travelExpense, 
      dynamic tripExpense}){
    _id = id;
    _displayName = displayName;
    _outOfPocketExpense = outOfPocketExpense;
    _travelExpense = travelExpense;
    _tripExpense = tripExpense;
}

  Daytrip_advance_expense_category.fromJson(dynamic json) {
    _id = json["id"];
    _displayName = json["display_name"];
    _outOfPocketExpense = json["out_of_pocket_expense"];
    _travelExpense = json["travel_expense"];
    _tripExpense = json["trip_expense"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["display_name"] = _displayName;
    map["out_of_pocket_expense"] = _outOfPocketExpense;
    map["travel_expense"] = _travelExpense;
    map["trip_expense"] = _tripExpense;
    return map;
  }

}