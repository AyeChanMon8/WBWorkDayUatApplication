// @dart=2.9

import 'dart:convert';

class Palntrip_with_product_fuelin_line {
  int _tripProductId;
  String _date;
  String _shop;
  int _productId;
  int _locationId;
  String _slipNo;
  double _liter;
  int _priceUnit;
  double _amount;
  String _status;

  int get tripProductId => _tripProductId;
  String get date => _date;
  String get shop => _shop;
  int get productId => _productId;
  int get locationId => _locationId;
  String get slipNo => _slipNo;
  double get liter => _liter;
  int get priceUnit => _priceUnit;

  Palntrip_with_product_fuelin_line({
      int tripProductId, 
      String date, 
      String shop, 
      int productId, 
      int locationId, 
      String slipNo, 
      double liter,
      int priceUnit,double amount,String status}){
    _tripProductId = tripProductId;
    _date = date;
    _shop = shop;
    _productId = productId;
    _locationId = locationId;
    _slipNo = slipNo;
    _liter = liter;
    _priceUnit = priceUnit;
    _amount = amount;
    _status = status;
}

  Palntrip_with_product_fuelin_line.fromJson(dynamic json) {
    _tripProductId = json["trip_product_id"];
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
      'parent_id':_tripProductId,
      'date': _date,
      'shop': _shop,
      'product_id': _productId,
      'location_id': _locationId,
      'slip_no': _slipNo,
      'liter': _liter,
      'price_unit': _priceUnit,
      'status':_status

    };
  }

}