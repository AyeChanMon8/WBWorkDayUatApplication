// @dart=2.9

import 'fleet_model.dart';

/// id : 2
/// name : "Ygn - Mdy"
/// state : "draft"
/// from_datetime : "2021-01-30 02:39:53"
/// to_datetime : "2021-01-30 16:39:53"
/// duration : 0.5
/// vehicle_id : {"id":4,"name":"Opel/Corsa/4Q/5478"}
/// fuel_type : null
/// odometer : 0
/// odometer_unit : "kilometers"
/// driver_id : {"id":7,"name":"BE GROUP"}
/// spare1_id : {"id":6282,"name":"Shine Aung Kyaw"}
/// spare2_id : {"id":6277,"name":"Sitt Oo"}
/// advanced_request : 100000
/// expense_ids : [{"product_id":{"id":24,"name":"Fuel Expense"},"name":"Fuel Expense","amount":50000}]

class DayTripModel {
  int _id;
  String _code;
  String _state;
  String _fromDatetime;
  String _toDatetime;
  double _duration;
  Vehicle_id _vehicleId;
  dynamic _fuelType;
  double _odometer;
  String _odometerUnit;
  Driver_id _driverId;
  Spare1_id _spare1Id;
  Spare2_id _spare2Id;
  double _advancedRequest;
  List<DayTrip_Expense_ids> _expenseIds;
  List<FuelIn_ids> _fuelInIds;
  List<Product_ids> _product_lines;
  List<Advance_ids> _advance_lines;
  List<Consumption_ids> _consumption_ids;

  int get id => _id;
  String get code => _code;
  String get state => _state;
  String get fromDatetime => _fromDatetime;
  String get toDatetime => _toDatetime;
  double get duration => _duration;
  Vehicle_id get vehicleId => _vehicleId;
  dynamic get fuelType => _fuelType;
  double get odometer => _odometer;
  String get odometerUnit => _odometerUnit;
  Driver_id get driverId => _driverId;
  Spare1_id get spare1Id => _spare1Id;
  Spare2_id get spare2Id => _spare2Id;
  double get advancedRequest => _advancedRequest;
  List<DayTrip_Expense_ids> get expenseIds => _expenseIds;
  List<FuelIn_ids> get fuelInIds => _fuelInIds;
  List<Product_ids> get product_lines => _product_lines;
  List<Advance_ids> get advance_lines => _advance_lines;
  List<Consumption_ids> get consumption_ids => _consumption_ids;
  DayTripModel({
      int id,
      String code,
      String state,
      String fromDatetime,
      String toDatetime,
      double duration,
      Vehicle_id vehicleId,
      dynamic fuelType,
      double odometer,
      String odometerUnit,
      Driver_id driverId,
      Spare1_id spare1Id,
      Spare2_id spare2Id,
      double advancedRequest,
      List<DayTrip_Expense_ids> expenseIds}){
    _id = id;
    _code = code;
    _state = state;
    _fromDatetime = fromDatetime;
    _toDatetime = toDatetime;
    _duration = duration;
    _vehicleId = vehicleId;
    _fuelType = fuelType;
    _odometer = odometer;
    _odometerUnit = odometerUnit;
    _driverId = driverId;
    _spare1Id = spare1Id;
    _spare2Id = spare2Id;
    _advancedRequest = advancedRequest;
    _expenseIds = expenseIds;
}

  DayTripModel.fromJson(dynamic json) {
    _id = json["id"];
    _code = json["code"];
    _state = json["state"];
    _fromDatetime = DateTime.parse(json["from_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _toDatetime = DateTime.parse(json["to_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _duration = json["duration"];
    _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
    _fuelType = json["fuel_type"];
    _odometer = json["odometer"];
    _odometerUnit = json["odometer_unit"];
    _driverId = json["driver_id"] != null ? Driver_id.fromJson(json["driver_id"]) : null;
    _spare1Id = json["spare1_id"] != null ? Spare1_id.fromJson(json["spare1_id"]) : null;
    _spare2Id = json["spare2_id"] != null ? Spare2_id.fromJson(json["spare2_id"]) : null;
    _advancedRequest = json["advance_allowed"];
    if (json["expense_ids"] != null) {
      _expenseIds = [];
      json["expense_ids"].forEach((v) {
        _expenseIds.add(DayTrip_Expense_ids.fromJson(v));
      });
    }
    if(json["fuelin_ids"]!=null){
      _fuelInIds = [];
      json["fuelin_ids"].forEach((v) {
        _fuelInIds.add(FuelIn_ids.fromJson(v));
      });
    }
    if(json["product_lines"]!=null){
      _product_lines = [];
      json["product_lines"].forEach((v) {
        _product_lines.add(Product_ids.fromJson(v));
      });
    }
    if(json["request_allowance_lines"]!=null){
      _advance_lines = [];
      json["request_allowance_lines"].forEach((v) {
        _advance_lines.add(Advance_ids.fromJson(v));
      });
    }
    if(json["consumption_ids"]!=null){
      _consumption_ids = [];
      json["consumption_ids"].forEach((v) {
        _consumption_ids.add(Consumption_ids.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["code"] = _code;
    map["state"] = _state;
    map["from_datetime"] = _fromDatetime;
    map["to_datetime"] = _toDatetime;
    map["duration"] = _duration;
    if (_vehicleId != null) {
      map["vehicle_id"] = _vehicleId.toJson();
    }
    map["fuel_type"] = _fuelType;
    map["odometer"] = _odometer;
    map["odometer_unit"] = _odometerUnit;
    if (_driverId != null) {
      map["driver_id"] = _driverId.toJson();
    }
    if (_spare1Id != null) {
      map["spare1_id"] = _spare1Id.toJson();
    }
    if (_spare2Id != null) {
      map["spare2_id"] = _spare2Id.toJson();
    }
    map["advanced_request"] = _advancedRequest;
    if (_expenseIds != null) {
      map["expense_ids"] = _expenseIds.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : {"id":24,"name":"Fuel Expense"}
/// name : "Fuel Expense"
/// amount : 50000

class DayTrip_Expense_ids {
  DayTrip_Product_id _productId;
  String _name;
  double _amount;
  int _id;
  String _attachement_image;
  DayTrip_Product_id get productId => _productId;
  String get name => _name;
  double get amount => _amount;
  int get id => _id;
  String get attachement_image => _attachement_image;
  DayTrip_Expense_ids({
    DayTrip_Product_id productId,
      String name,
      double amount}){
    _productId = productId;
    _name = name;
    _amount = amount;
}

  DayTrip_Expense_ids.fromJson(dynamic json) {
    _productId = json["product_id"] != null ? DayTrip_Product_id.fromJson(json["product_id"]) : null;
    _name = json["name"];
    _amount = json["amount"];
    _id = json["id"];
    _attachement_image = json['attached_file'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_productId != null) {
      map["product_id"] = _productId.toJson();
    }
    map["name"] = _name;
    map["amount"] = _amount;

    return map;
  }

}
class FuelIn_ids {

  DayTrip_Product_id _productId;
  String _date;
  String _shop;
  double _amount;
  Location_id _location_id;
  String _slip_no;
  double _liter;
  double _price_unit;
  int _id;
  bool _add_from_office;

  DayTrip_Product_id get productId => _productId;
  String get shop => _shop;
  double get amount => _amount;
  double get liter => _liter;
  double get price_unit => _price_unit;
  String get slip_no => _slip_no;
  String get date => _date;
  Location_id get location_id => _location_id;
  int get id => _id;
  bool get add_from_office => _add_from_office;

  FuelIn_ids({
    DayTrip_Product_id productId,
    String date,
    String shop,double amount,Location_id location_id,String slip_no,double liter,double price_unit}){
    _productId = productId;
    _date = date;
    _shop = shop;
    _amount = amount;
    _location_id = location_id;
    _slip_no = slip_no;
    _liter = liter;
    _price_unit = price_unit;

  }

  FuelIn_ids.fromJson(dynamic json) {

    _date = json["date"];
    _shop = json["shop"];
    _productId = json["product_id"] != null ? DayTrip_Product_id.fromJson(json["product_id"]) : null;
    _location_id = json["location_id"] != null ? Location_id.fromJson(json["location_id"]) : null;
    _slip_no = json["slip_no"];
    _liter = json["liter"];
    _price_unit = json["price_unit"];
    _amount = json["amount"];
    _id = json["id"];
    _add_from_office = json["add_from_office"];
  }


}

class Product_ids {

  DayTrip_Product_id _productId;
  double _quantity;
  int _id;
  DayTrip_uom _uom;


  DayTrip_Product_id get productId => _productId;
  double get quantity => _quantity;
  int get id => _id;
  DayTrip_uom get uom => _uom;
  Product_ids({
    DayTrip_Product_id productId,
    double quantity,}){
    _productId = productId;
    _quantity = quantity;
  }

  Product_ids.fromJson(dynamic json) {

    _productId = json["product_id"] != null ? DayTrip_Product_id.fromJson(json["product_id"]) : null;
    _quantity = json["quantity"];
    _id = json["id"];
    _uom = json["product_uom"] != null ? DayTrip_uom.fromJson(json["product_uom"]) : null;

  }
}
/// id : 24
/// name : "Fuel Expense"

class DayTrip_uom {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  DayTrip_uom({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  DayTrip_uom.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}
/// id : 24
/// name : "Fuel Expense"

class DayTrip_Product_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  DayTrip_Product_id({
      int id,
      String name}){
    _id = id;
    _name = name;
}

  DayTrip_Product_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}
class Location_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Location_id({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  Location_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : 6277
/// name : "Sitt Oo"

class Spare2_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Spare2_id({
      int id,
      String name}){
    _id = id;
    _name = name;
}

  Spare2_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : 6282
/// name : "Shine Aung Kyaw"

class Spare1_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Spare1_id({
      int id,
      String name}){
    _id = id;
    _name = name;
}

  Spare1_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : 7
/// name : "BE GROUP"

class Driver_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Driver_id({
      int id,
      String name}){
    _id = id;
    _name = name;
}

  Driver_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : 4
/// name : "Opel/Corsa/4Q/5478"

class Vehicle_id {
  int _id;
  String _name;
  Incharge_id _inchargeId;

  int get id => _id;
  String get name => _name;
  dynamic get inchargeId => _inchargeId;

  Vehicle_id({
      int id,
      String name,
      dynamic inchargeId}){
    _id = id;
    _name = name;
    _inchargeId = inchargeId;
}

  Vehicle_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _inchargeId = json["incharge_id"] != null ? Incharge_id.fromJson(json["incharge_id"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    if (_inchargeId != null) {
      map["incharge_id"] = _inchargeId.toJson();
    }
    return map;
  }

}
class Consumption_ids {

  double _last_odometer;
  double _current_odometer;
  double _trip_distance;
  int _standard_liter;
  double _consumed_liter;
  double _avg_calculation;
  dynamic _description;
  int _id;

  double get last_odometer => _last_odometer;
  double get current_odometer => _current_odometer;
  double get trip_distance => _trip_distance;
  int get standard_liter => _standard_liter;
  double get consumed_liter => _consumed_liter;
  double get avg_calculation => _avg_calculation;
  dynamic get description => _description;
  int get id => _id;

  Consumption_ids.fromJson(dynamic json) {
    _last_odometer = json["last_odometer"];
    _current_odometer = json["current_odometer"];
    _trip_distance = json["trip_distance"];
    _standard_liter = json["standard_liter"];
    _consumed_liter = json["consumed_liter"];
    _avg_calculation = json["avg_calculation"];
    _description = json["description"];
    _id = json["id"];
  }

}
class Advance_ids {

  ExpenseCategory_id _expense_categ_id;
  double _quantity;
  double _amount;
  double _total_amount;
  String _remark;
  int _id;

  ExpenseCategory_id get expense_categ_id => _expense_categ_id;
  double get quantity => _quantity;
  double get amount => _amount;
  double get total_amount => _total_amount;
  String get remark => _remark;
  int get id => _id;

  Advance_ids({
    ExpenseCategory_id expense_categ_id,
    double quantity,
    double amount,double total_amount,String remark,int id}){
    _expense_categ_id = expense_categ_id;
    _quantity = quantity;
    _amount = amount;
    _total_amount = total_amount;
    _remark = remark;
    _id = id;

  }

  Advance_ids.fromJson(dynamic json) {

    _expense_categ_id = json["expense_categ_id"] != null ? ExpenseCategory_id.fromJson(json["expense_categ_id"]) : null;
    _quantity = json["quantity"];
    _amount = json["amount"];
    _total_amount = json["total_amount"];
    _remark = json["remark"];
    _id = json["id"];
  }

}
class ExpenseCategory_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  ExpenseCategory_id({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  ExpenseCategory_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}