// @dart=2.9
import 'dart:convert';

class DayTripExpenseLine {
  List<Expense> _expenseIds;

  List<Expense> get expenseIds => _expenseIds;

  DayTripExpenseLine({
      List<Expense> expenseIds}){
    _expenseIds = expenseIds;
}

  DayTripExpenseLine.fromJson(dynamic json) {
    if (json["expense_ids"] != null) {
      _expenseIds = [];
      json["expense_ids"].forEach((v) {
        _expenseIds.add(Expense.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_expenseIds != null) {
      map["expense_ids"] = _expenseIds.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Expense {
  int _productId;
  String _name;
  double _amount;
  int _day_trip_id;
  String _image;

  int get productId => _productId;
  String get name => _name;
  double get amount => _amount;
  int get day_trip_id => _day_trip_id;

  Expense({
      int productId, 
      String name, 
      double amount,int day_trip_id,String image}){
    _productId = productId;
    _name = name;
    _amount = amount;
    _day_trip_id = day_trip_id;
    _image = image;
}

  Expense.fromJson(dynamic json) {
    _productId = json["product_id"];
    _name = json["name"];
    _amount = json["amount"];
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'product_id': _productId,
      'name': _name,
      'amount': _amount,
      'day_trip_id': _day_trip_id,
      'attached_file' : _image,
    };
  }

}