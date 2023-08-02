// @dart=2.9
import 'dart:convert';

class Advance_line {
  int _dayTripId;
  int _expenseCategId;
  int _quantity;
  int _amount;
  int _total_amount;
  String _remark;

  int get dayTripId => _dayTripId;
  int get expenseCategId => _expenseCategId;
  int get quantity => _quantity;
  int get amount => _amount;
  int get total_amount => _total_amount;
  String get remark => _remark;

  Advance_line({
      int dayTripId, 
      int expenseCategId, 
      int quantity, 
      int amount,
      int total_amount,
    String remark}){
    _dayTripId = dayTripId;
    _expenseCategId = expenseCategId;
    _quantity = quantity;
    _amount = amount;
    _total_amount = total_amount;
    _remark = remark;
}

  Advance_line.fromJson(dynamic json) {
    _dayTripId = json["day_trip_id"];
    _expenseCategId = json["expense_categ_id"];
    _quantity = json["quantity"];
    _amount = json["amount"];
    _total_amount = json['total_amount'];
    _remark = json["remark"];
  }
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'day_trip_id': _dayTripId,
      'expense_categ_id': _expenseCategId,
      'quantity': _quantity,
      'amount': _amount,
      'total_amount' : _total_amount,
      'remark': _remark,
    };
  }

}