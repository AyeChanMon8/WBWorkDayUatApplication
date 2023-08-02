// @dart=2.9

import 'dart:convert';

/// day_trip_id : 2
/// consumed_liter : 500
/// description : "Testing"

class Daytrip_fuel_consumption {
  int _dayTripId;
  double _consumedLiter;
  String _description;
  int _vehicleId;
  int _employeeId;
  String _sourceDoc;
  String _date;
  int _fillingLiter;

  int get dayTripId => _dayTripId;
  double get consumedLiter => _consumedLiter;
  String get description => _description;
  int get vehicleId => _vehicleId;
  int get employeeId=> _employeeId;
  String get sourceDoc => _sourceDoc;
  String get fillingDate => _date;
  int get fillingLiter => _fillingLiter;

  Daytrip_fuel_consumption({
      int dayTripId,
    double consumedLiter,
      String description,
      int vehicleId,
      int employeeId,
      String sourceDoc,
      String date,
      int fillingLiter,
  }){
    _dayTripId = dayTripId;
    _consumedLiter = consumedLiter;
    _description = description;
    _vehicleId = vehicleId;
    _employeeId = employeeId;
    _sourceDoc = sourceDoc;
    _date = date;
    _fillingLiter = fillingLiter;
}

  Daytrip_fuel_consumption.fromJson(dynamic json) {
    _dayTripId = json["day_trip_id"];
    _consumedLiter = json["consumed_liter"];
    _description = json["description"];
    _vehicleId = json["vehicle_id"];
    _employeeId = json["employee_id"];
    _sourceDoc = json['source_doc'];
    _date = json['filling_date'];
    _fillingLiter = json['filling_liter'];
  }


  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'day_trip_id':_dayTripId,
      'consumed_liter': _consumedLiter,
      'description': _description,
      // 'vehicle_id' : _vehicleId,
      // 'employee_id' : _employeeId,
      // 'source_doc' : _sourceDoc,
      'date' : _date,
      // 'filling_liter' : _fillingLiter,
    };
  }

}