// @dart=2.9

/// id : 1
/// vehicle_id : {"id":1,"name":"Audi/A6/s3333"}
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// odometer : 1000.0
/// previous_odometer : 0.0
/// liter : 10.0
/// fuel_tank_id : {"id":null,"name":null}
/// price_per_liter : 520.0
/// amount : 5200.0
/// date : "2020-08-26"
/// inv_ref : null
/// shop : null

class Fuel_log_model {
  int _id;
  Vehicle_id _vehicleId;
  Employee_id _employeeId;
  double _odometer;
  double _previousOdometer;
  double _liter;
  Fuel_tank_id _fuelTankId;
  double _pricePerLiter;
  double _amount;
  String _date;
  dynamic _invRef;
  dynamic _shop;

  int get id => _id;
  Vehicle_id get vehicleId => _vehicleId;
  Employee_id get employeeId => _employeeId;
  double get odometer => _odometer;
  double get previousOdometer => _previousOdometer;
  double get liter => _liter;
  Fuel_tank_id get fuelTankId => _fuelTankId;
  double get pricePerLiter => _pricePerLiter;
  double get amount => _amount;
  String get date => _date;
  dynamic get invRef => _invRef;
  dynamic get shop => _shop;

  Fuel_log_model({
      int id, 
      Vehicle_id vehicleId, 
      Employee_id employeeId, 
      double odometer, 
      double previousOdometer, 
      double liter, 
      Fuel_tank_id fuelTankId, 
      double pricePerLiter, 
      double amount, 
      String date, 
      dynamic invRef, 
      dynamic shop}){
    _id = id;
    _vehicleId = vehicleId;
    _employeeId = employeeId;
    _odometer = odometer;
    _previousOdometer = previousOdometer;
    _liter = liter;
    _fuelTankId = fuelTankId;
    _pricePerLiter = pricePerLiter;
    _amount = amount;
    _date = date;
    _invRef = invRef;
    _shop = shop;
}

  Fuel_log_model.fromJson(dynamic json) {
    _id = json["id"];
    _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
    _employeeId = json["employee_id"] != null ? Employee_id.fromJson(json["employee_id"]) : null;
    _odometer = json["odometer"];
    _previousOdometer = json["previous_odometer"];
    _liter = json["liter"];
    _fuelTankId = json["fuel_tank_id"] != null ? Fuel_tank_id.fromJson(json["fuel_tank_id"]) : null;
    _pricePerLiter = json["price_per_liter"];
    _amount = json["amount"];
    _date = json["date"];
    _invRef = json["inv_ref"];
    _shop = json["shop"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    if (_vehicleId != null) {
      map["vehicle_id"] = _vehicleId.toJson();
    }
    if (_employeeId != null) {
      map["employee_id"] = _employeeId.toJson();
    }
    map["odometer"] = _odometer;
    map["previous_odometer"] = _previousOdometer;
    map["liter"] = _liter;
    if (_fuelTankId != null) {
      map["fuel_tank_id"] = _fuelTankId.toJson();
    }
    map["price_per_liter"] = _pricePerLiter;
    map["amount"] = _amount;
    map["date"] = _date;
    map["inv_ref"] = _invRef;
    map["shop"] = _shop;
    return map;
  }

}

/// id : null
/// name : null

class Fuel_tank_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Fuel_tank_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  Fuel_tank_id.fromJson(dynamic json) {
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

/// id : 6115
/// name : "Ahr Yu"

class Employee_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Employee_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Employee_id.fromJson(dynamic json) {
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

/// id : 1
/// name : "Audi/A6/s3333"

class Vehicle_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Vehicle_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Vehicle_id.fromJson(dynamic json) {
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