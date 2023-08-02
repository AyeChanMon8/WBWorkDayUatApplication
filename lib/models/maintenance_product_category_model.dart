// @dart=2.9

/// id : 15
/// name : "Maintenance"
/// display_name : "Maintenance"
/// parent_id : {"id":null,"name":null}
/// delivery : null
/// fuel : null
/// day_trip : null
/// plan_trip : null
/// out_of_pocket_expense : null
/// travel_expense : null
/// trip_expense : null
/// vehicle_cost : null
/// maintenance : true
/// hr : null
/// admin : null
/// purchase : null
/// property_cost_method : "standard"
/// property_valuation : "manual_periodic"

class Maintenance_product_category_model {
  int _id;
  String _name;
  String _displayName;
  Parent_id _parentId;
  dynamic _delivery;
  dynamic _fuel;
  dynamic _dayTrip;
  dynamic _planTrip;
  dynamic _outOfPocketExpense;
  dynamic _travelExpense;
  dynamic _tripExpense;
  dynamic _vehicleCost;
  bool _maintenance;
  dynamic _hr;
  dynamic _admin;
  dynamic _purchase;
  String _propertyCostMethod;
  String _propertyValuation;

  int get id => _id;
  String get name => _name;
  String get displayName => _displayName;
  Parent_id get parentId => _parentId;
  dynamic get delivery => _delivery;
  dynamic get fuel => _fuel;
  dynamic get dayTrip => _dayTrip;
  dynamic get planTrip => _planTrip;
  dynamic get outOfPocketExpense => _outOfPocketExpense;
  dynamic get travelExpense => _travelExpense;
  dynamic get tripExpense => _tripExpense;
  dynamic get vehicleCost => _vehicleCost;
  bool get maintenance => _maintenance;
  dynamic get hr => _hr;
  dynamic get admin => _admin;
  dynamic get purchase => _purchase;
  String get propertyCostMethod => _propertyCostMethod;
  String get propertyValuation => _propertyValuation;

  Maintenance_product_category_model({
      int id, 
      String name, 
      String displayName, 
      Parent_id parentId, 
      dynamic delivery, 
      dynamic fuel, 
      dynamic dayTrip, 
      dynamic planTrip, 
      dynamic outOfPocketExpense, 
      dynamic travelExpense, 
      dynamic tripExpense, 
      dynamic vehicleCost, 
      bool maintenance, 
      dynamic hr, 
      dynamic admin, 
      dynamic purchase, 
      String propertyCostMethod, 
      String propertyValuation}){
    _id = id;
    _name = name;
    _displayName = displayName;
    _parentId = parentId;
    _delivery = delivery;
    _fuel = fuel;
    _dayTrip = dayTrip;
    _planTrip = planTrip;
    _outOfPocketExpense = outOfPocketExpense;
    _travelExpense = travelExpense;
    _tripExpense = tripExpense;
    _vehicleCost = vehicleCost;
    _maintenance = maintenance;
    _hr = hr;
    _admin = admin;
    _purchase = purchase;
    _propertyCostMethod = propertyCostMethod;
    _propertyValuation = propertyValuation;
}

  Maintenance_product_category_model.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _displayName = json["display_name"];
    _parentId = json["parent_id"] != null ? Parent_id.fromJson(json["parent_id"]) : null;
    _delivery = json["delivery"];
    _fuel = json["fuel"];
    _dayTrip = json["day_trip"];
    _planTrip = json["plan_trip"];
    _outOfPocketExpense = json["out_of_pocket_expense"];
    _travelExpense = json["travel_expense"];
    _tripExpense = json["trip_expense"];
    _vehicleCost = json["vehicle_cost"];
    _maintenance = json["maintenance"];
    _hr = json["hr"];
    _admin = json["admin"];
    _purchase = json["purchase"];
    _propertyCostMethod = json["property_cost_method"];
    _propertyValuation = json["property_valuation"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["display_name"] = _displayName;
    if (_parentId != null) {
      map["parent_id"] = _parentId.toJson();
    }
    map["delivery"] = _delivery;
    map["fuel"] = _fuel;
    map["day_trip"] = _dayTrip;
    map["plan_trip"] = _planTrip;
    map["out_of_pocket_expense"] = _outOfPocketExpense;
    map["travel_expense"] = _travelExpense;
    map["trip_expense"] = _tripExpense;
    map["vehicle_cost"] = _vehicleCost;
    map["maintenance"] = _maintenance;
    map["hr"] = _hr;
    map["admin"] = _admin;
    map["purchase"] = _purchase;
    map["property_cost_method"] = _propertyCostMethod;
    map["property_valuation"] = _propertyValuation;
    return map;
  }

}

/// id : null
/// name : null

class Parent_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Parent_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  Parent_id.fromJson(dynamic json) {
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