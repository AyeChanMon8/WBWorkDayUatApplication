// @dart=2.9

import 'dart:convert';

/// plan_trip_id : 2
/// consumed_liter : 500
/// description : "Testing"

class Plantrip_fuel_consumption {
  int _planTripId;
  double _consumedLiter;
  String _description;
  int _route_id;
  int _vehicleId;
  int _employeeId;
  String _sourceDoc;
  String _date;
  int _fillingLiter;
  int _line_id;

  int get planTripId => _planTripId;
  double get consumedLiter => _consumedLiter;
  String get description => _description;
  int get vehicleId => _vehicleId;
  int get employeeId=> _employeeId;
  String get sourceDoc => _sourceDoc;
  String get fillingDate => _date;
  int get fillingLiter => _fillingLiter;

  Plantrip_fuel_consumption({
      int planTripId, 
      double consumedLiter,
      String description,
      int route_id,
    int vehicleId,
    int employeeId,
    String sourceDoc,
    String date,
    int fillingLiter,
    int line_id
  }){
    _planTripId = planTripId;
    _consumedLiter = consumedLiter;
    _description = description;
    _route_id = route_id;
    _vehicleId = vehicleId;
    _employeeId = employeeId;
    _sourceDoc = sourceDoc;
    _date = date;
    _fillingLiter = fillingLiter;
    _line_id = line_id;

}

  Plantrip_fuel_consumption.fromJson(dynamic json) {
    _planTripId = json["plan_trip_id"];
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
      'plan_trip_id':_planTripId,
      'consumed_liter': _consumedLiter,
      'description': _description,
      'route_id': _route_id,
      // 'vehicle_id' : _vehicleId,
     'employee_id' : _employeeId,
      // 'source_doc' : _sourceDoc,
      'date' : _date,
       'line_id' : _line_id,
    };
  }
}