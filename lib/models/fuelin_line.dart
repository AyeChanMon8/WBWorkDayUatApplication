// @dart=2.9

import 'dart:convert';

/// date : "2021-03-16"
/// shop : "Trip"
/// product_id : 24
/// location_id : 22
/// slip_no : "SN-0001"
/// liter : 2
/// price_unit : 2500
/// day_trip_id : 2

class Fuelin_line {
  String _date;
  String _shop;
  int _productId;
  int _locationId;
  String _slipNo;
  double _liter;
  int _priceUnit;
  int _dayTripId;
  String _status;

  String get date => _date;
  String get shop => _shop;
  int get productId => _productId;
  int get locationId => _locationId;
  String get slipNo => _slipNo;
  double get liter => _liter;
  int get priceUnit => _priceUnit;
  int get dayTripId => _dayTripId;

  Fuelin_line({
      String date, 
      String shop, 
      int productId, 
      int locationId, 
      String slipNo, 
      double liter,
      int priceUnit, 
      int dayTripId,String status}){
    _date = date;
    _shop = shop;
    _productId = productId;
    _locationId = locationId;
    _slipNo = slipNo;
    _liter = liter;
    _priceUnit = priceUnit;
    _dayTripId = dayTripId;
    _status = status;
}

  Fuelin_line.fromJson(dynamic json) {
    _date = json["date"];
    _shop = json["shop"];
    _productId = json["product_id"];
    _locationId = json["location_id"];
    _slipNo = json["slip_no"];
    _liter = json["liter"];
    _priceUnit = json["price_unit"];
    _dayTripId = json["day_trip_id"];
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'date': _date,
      'shop': _shop,
      'product_id': _productId,
      'location_id': _locationId,
      'slip_no': _slipNo,
      'liter': _liter,
      'price_unit': _priceUnit,
      'parent_id': _dayTripId,
      'status':_status
    };
  }

}