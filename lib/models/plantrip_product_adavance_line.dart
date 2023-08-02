// @dart=2.9

import 'dart:convert';
class Plantrip_product_adavance_line {
  int _tripProductId;
  int _expenseCategId;
  int _quantity;
  int _amount;
  int _total_amount;
  String _remark;

  int get tripProductId => _tripProductId;
  int get expenseCategId => _expenseCategId;
  int get quantity => _quantity;
  int get amount => _amount;
  int get totalAmount => _total_amount;
  String get remark => _remark;

  Plantrip_product_adavance_line({
      int tripProductId, 
      int expenseCategId, 
      int quantity, 
      int amount,
      int totalAmount,
      String remark}){
    _tripProductId = tripProductId;
    _expenseCategId = expenseCategId;
    _quantity = quantity;
    _amount = amount;
    _total_amount = totalAmount;
    _remark = remark;
}

  Plantrip_product_adavance_line.fromJson(dynamic json) {
    _tripProductId = json["trip_product_id"];
    _expenseCategId = json["expense_categ_id"];
    _quantity = json["quantity"];
    _amount = json["amount"];
    _total_amount = json["total_amount"];
    _remark = json["remark"];
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'trip_product_id': _tripProductId,
      'expense_categ_id': _expenseCategId,
      'quantity': _quantity,
      'amount': _amount,
      'total_amount' : _total_amount,
      'remark': _remark,
    };
  }

}