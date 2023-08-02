// @dart=2.9

import 'dart:convert';

/// trip_waybill_id : 1
/// date : "2021-03-19"
/// shop : "Max Energy"
/// product_id : 23
/// location_id : 102
/// slip_no : "S0011"
/// liter : 2
/// price_unit : 4500

class Plantrip_waybill_fuelin_line {
  int _tripWaybillId;
  String _date;
  String _shop;
  int _productId;
  int _locationId;
  String _slipNo;
  double _liter;
  int _priceUnit;
  double _amount;

  int get tripWaybillId => _tripWaybillId;
  String get date => _date;
  String get shop => _shop;
  int get productId => _productId;
  int get locationId => _locationId;
  String get slipNo => _slipNo;
  double get liter => _liter;
  int get priceUnit => _priceUnit;

  Plantrip_waybill_fuelin_line({
      int tripWaybillId, 
      String date, 
      String shop, 
      int productId, 
      int locationId, 
      String slipNo, 
      double liter,
      int priceUnit,double amount}){
    _tripWaybillId = tripWaybillId;
    _date = date;
    _shop = shop;
    _productId = productId;
    _locationId = locationId;
    _slipNo = slipNo;
    _liter = liter;
    _priceUnit = priceUnit;
    _amount = amount;
}

  Plantrip_waybill_fuelin_line.fromJson(dynamic json) {
    _tripWaybillId = json["trip_waybill_id"];
    _date = json["date"];
    _shop = json["shop"];
    _productId = json["product_id"];
    _locationId = json["location_id"];
    _slipNo = json["slip_no"];
    _liter = json["liter"];
    _priceUnit = json["price_unit"];
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'trip_waybill_id':_tripWaybillId,
      'date': _date,
      'shop': _shop,
      'product_id': _productId,
      'location_id': _locationId,
      'slip_no': _slipNo,
      'liter': _liter,
      'price_unit': _priceUnit,
      'amount': _amount
    };
  }

}