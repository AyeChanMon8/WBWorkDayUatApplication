// @dart=2.9

class Plan_trip_product {
  int _id;
  String _name;
  String _state;
  String _fromDatetime;
  String _toDatetime;
  double _duration;
  double _duration_hours;
  Vehicle_id _vehicleId;
  Driver_id _driverId;
  Spare1_id _spare1Id;
  Spare2_id _spare2Id;
  List<Route_plan_ids> _routePlanIds;
  List<Expense_ids> _expenseIds;
  List<PlanTrip_Consumption_ids> _consumptionIds;
  double _lastOdometer;
  double _currentOdometer;
  double _tripDistance;
  int _totalStandardLiter;
  int _totalConsumedLiter;
  double _avgCalculation;
  List<Fuelin_ids> _fuelinIds;
  List<Advanced_ids> _advancedIds;
  List<Request_allowance_lines> _requestAllowanceLines;
  double _totalAdvance;
  List<Product_ids> _productIds;

  int get id => _id;
  String get name => _name;
  String get state => _state;
  String get fromDatetime => _fromDatetime;
  String get toDatetime => _toDatetime;
  double get duration => _duration;
  double get duration_hours => _duration_hours;
  Vehicle_id get vehicleId => _vehicleId;
  Driver_id get driverId => _driverId;
  Spare1_id get spare1Id => _spare1Id;
  Spare2_id get spare2Id => _spare2Id;
  List<Route_plan_ids> get routePlanIds => _routePlanIds;
  List<Expense_ids> get expenseIds => _expenseIds;
  List<PlanTrip_Consumption_ids> get consumptionIds => _consumptionIds;
  double get lastOdometer => _lastOdometer;
  double get currentOdometer => _currentOdometer;
  double get tripDistance => _tripDistance;
  int get totalStandardLiter => _totalStandardLiter;
  int get totalConsumedLiter => _totalConsumedLiter;
  double get avgCalculation => _avgCalculation;
  List<Fuelin_ids> get fuelinIds => _fuelinIds;
  List<Advanced_ids> get advancedIds => _advancedIds;
  List<Request_allowance_lines> get requestAllowanceLines => _requestAllowanceLines;
  double get totalAdvance => _totalAdvance;
  List<Product_ids> get productIds => _productIds;

  Plan_trip_product({
      int id, 
      String name, 
      String state, 
      String fromDatetime, 
      String toDatetime, 
      double duration, 
      Vehicle_id vehicleId, 
      Driver_id driverId, 
      Spare1_id spare1Id, 
      Spare2_id spare2Id, 
      List<Route_plan_ids> routePlanIds, 
      List<Expense_ids> expenseIds, 
      List<PlanTrip_Consumption_ids> consumptionIds,
      double lastOdometer, 
      double currentOdometer, 
      double tripDistance, 
      int totalStandardLiter, 
      int totalConsumedLiter, 
      double avgCalculation, 
      List<Fuelin_ids> fuelinIds, 
      List<Advanced_ids> advancedIds, 
      List<Request_allowance_lines> requestAllowanceLines, 
      double totalAdvance, 
      List<Product_ids> productIds,double duration_hours}){
    _id = id;
    _name = name;
    _state = state;
    _fromDatetime = fromDatetime;
    _toDatetime = toDatetime;
    _duration = duration;
    _vehicleId = vehicleId;
    _driverId = driverId;
    _spare1Id = spare1Id;
    _spare2Id = spare2Id;
    _routePlanIds = routePlanIds;
    _expenseIds = expenseIds;
    _consumptionIds = consumptionIds;
    _lastOdometer = lastOdometer;
    _currentOdometer = currentOdometer;
    _tripDistance = tripDistance;
    _totalStandardLiter = totalStandardLiter;
    _totalConsumedLiter = totalConsumedLiter;
    _avgCalculation = avgCalculation;
    _fuelinIds = fuelinIds;
    _advancedIds = advancedIds;
    _requestAllowanceLines = requestAllowanceLines;
    _totalAdvance = totalAdvance;
    _productIds = productIds;
    _duration_hours = duration_hours;
}

  Plan_trip_product.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["code"];
    _state = json["state"];
    _fromDatetime = DateTime.parse(json["from_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _toDatetime = DateTime.parse(json["to_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _duration = json["duration"];
    _duration_hours = json["duration_hrs"];
    _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
    _driverId = json["driver_id"] != null ? Driver_id.fromJson(json["driver_id"]) : null;
    _spare1Id = json["spare1_id"] != null ? Spare1_id.fromJson(json["spare1_id"]) : null;
    _spare2Id = json["spare2_id"] != null ? Spare2_id.fromJson(json["spare2_id"]) : null;
    if (json["route_plan_ids"] != null) {
      _routePlanIds = [];
      json["route_plan_ids"].forEach((v) {
        _routePlanIds.add(Route_plan_ids.fromJson(v));
      });
    }
    if (json["expense_ids"] != null) {
      _expenseIds = [];
      json["expense_ids"].forEach((v) {
        _expenseIds.add(Expense_ids.fromJson(v));
      });
    }
    if (json["consumption_ids"] != null) {
      _consumptionIds = [];
      json["consumption_ids"].forEach((v) {
        _consumptionIds.add(PlanTrip_Consumption_ids.fromJson(v));
      });
    }
    _lastOdometer = json["last_odometer"];
    _currentOdometer = json["current_odometer"];
    _tripDistance = json["trip_distance"];
    _totalStandardLiter = json["total_standard_liter"];
    _totalConsumedLiter = json["total_consumed_liter"];
    _avgCalculation = json["avg_calculation"];
    if (json["fuelin_ids"] != null) {
      _fuelinIds = [];
      json["fuelin_ids"].forEach((v) {
        _fuelinIds.add(Fuelin_ids.fromJson(v));
      });
    }
    if (json["advanced_ids"] != null) {
      _advancedIds = [];
      json["advanced_ids"].forEach((v) {
        _advancedIds.add(Advanced_ids.fromJson(v));
      });
    }
    if (json["request_allowance_lines"] != null) {
      _requestAllowanceLines = [];
      json["request_allowance_lines"].forEach((v) {
        _requestAllowanceLines.add(Request_allowance_lines.fromJson(v));
      });
    }
    _totalAdvance = json["advance_allowed"];

    if (json["product_ids"] != null) {
      _productIds = [];
      json["product_ids"].forEach((v) {
        _productIds.add(Product_ids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["state"] = _state;
    map["from_datetime"] = _fromDatetime;
    map["to_datetime"] = _toDatetime;
    map["duration"] = _duration;
    if (_vehicleId != null) {
      map["vehicle_id"] = _vehicleId.toJson();
    }
    if (_driverId != null) {
      map["driver_id"] = _driverId.toJson();
    }
    if (_spare1Id != null) {
      map["spare1_id"] = _spare1Id.toJson();
    }
    if (_spare2Id != null) {
      map["spare2_id"] = _spare2Id.toJson();
    }
    if (_routePlanIds != null) {
      map["route_plan_ids"] = _routePlanIds.map((v) => v.toJson()).toList();
    }
    if (_expenseIds != null) {
      map["expense_ids"] = _expenseIds.map((v) => v.toJson()).toList();
    }
    if (_consumptionIds != null) {
      map["consumption_ids"] = _consumptionIds.map((v) => v.toJson()).toList();
    }
    map["last_odometer"] = _lastOdometer;
    map["current_odometer"] = _currentOdometer;
    map["trip_distance"] = _tripDistance;
    map["total_standard_liter"] = _totalStandardLiter;
    map["total_consumed_liter"] = _totalConsumedLiter;
    map["avg_calculation"] = _avgCalculation;
    if (_fuelinIds != null) {
      map["fuelin_ids"] = _fuelinIds.map((v) => v.toJson()).toList();
    }
    if (_advancedIds != null) {
      map["advanced_ids"] = _advancedIds.map((v) => v.toJson()).toList();
    }
    if (_requestAllowanceLines != null) {
      map["request_allowance_lines"] = _requestAllowanceLines.map((v) => v.toJson()).toList();
    }
    map["total_advance"] = _totalAdvance;
    if (_productIds != null) {
      map["product_ids"] = _productIds.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : {"id":null,"name":null}
/// quantity : 1.0
/// price_unit : 1.0

class Product_ids {
  Product_id _productId;
  double _quantity;
  double _priceUnit;
  int _id;
  Product_uom _productUom;

  Product_id get productId => _productId;
  double get quantity => _quantity;
  double get priceUnit => _priceUnit;
  int get id => _id;
  Product_uom get productUom => _productUom;
  void setQuantity(double qty){
    _quantity = qty;
  }
  Product_ids({
      Product_id productId, 
      double quantity, 
      double priceUnit}){
    _productId = productId;
    _quantity = quantity;
    _priceUnit = priceUnit;
}

  Product_ids.fromJson(dynamic json) {
    _productId = json["product_id"] != null ? Product_id.fromJson(json["product_id"]) : null;
    _quantity = json["quantity"];
    _priceUnit = json["price_unit"];
    _id = json["id"];
    _productUom = json["product_uom"] != null ? Product_uom.fromJson(json["product_uom"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_productId != null) {
      map["product_id"] = _productId.toJson();
    }
    map["quantity"] = _quantity;
    map["price_unit"] = _priceUnit;
    return map;
  }

}
/// id : null
/// name : null

class Product_uom {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Product_uom({
    int id,
    String name}){
    _id = id;
    _name = name;
  }

  Product_uom.fromJson(dynamic json) {
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
/// id : null
/// name : null

class Product_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Product_id({
    int id,
    String name}){
    _id = id;
    _name = name;
}

  Product_id.fromJson(dynamic json) {
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

/// expense_categ_id : {"id":8,"name":"Meal and Entertainment"}
/// quantity : 1.0
/// amount : 1000.0
/// total_amount : 1000.0
/// remark : "dddddd"

class Request_allowance_lines {
  Expense_categ_id _expenseCategId;
  double _quantity;
  double _amount;
  double _totalAmount;
  String _remark;
  int _id;

  Expense_categ_id get expenseCategId => _expenseCategId;
  double get quantity => _quantity;
  double get amount => _amount;
  double get totalAmount => _totalAmount;
  String get remark => _remark;
  int get id => _id;

  Request_allowance_lines({
      Expense_categ_id expenseCategId, 
      double quantity, 
      double amount, 
      double totalAmount, 
      String remark,int id}){
    _expenseCategId = expenseCategId;
    _quantity = quantity;
    _amount = amount;
    _totalAmount = totalAmount;
    _remark = remark;
    _id = id;
}

  Request_allowance_lines.fromJson(dynamic json) {
    _expenseCategId = json["expense_categ_id"] != null ? Expense_categ_id.fromJson(json["expense_categ_id"]) : null;
    _quantity = json["quantity"];
    _amount = json["amount"];
    _totalAmount = json["total_amount"];
    _remark = json["remark"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_expenseCategId != null) {
      map["expense_categ_id"] = _expenseCategId.toJson();
    }
    map["quantity"] = _quantity;
    map["amount"] = _amount;
    map["total_amount"] = _totalAmount;
    map["remark"] = _remark;
    return map;
  }

}

/// id : 8
/// name : "Meal and Entertainment"

class Expense_categ_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Expense_categ_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Expense_categ_id.fromJson(dynamic json) {
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

/// route_id : {"id":14,"name":"Yangon - Mandalay"}
/// approved_advance : 100000.0

class Advanced_ids {
  Route_id _routeId;
  double _approvedAdvance;

  Route_id get routeId => _routeId;
  double get approvedAdvance => _approvedAdvance;

  Advanced_ids({
      Route_id routeId, 
      double approvedAdvance}){
    _routeId = routeId;
    _approvedAdvance = approvedAdvance;
}

  Advanced_ids.fromJson(dynamic json) {
    _routeId = json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
    _approvedAdvance = json["approved_advance"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_routeId != null) {
      map["route_id"] = _routeId.toJson();
    }
    map["approved_advance"] = _approvedAdvance;
    return map;
  }

}

/// id : 14
/// name : "Yangon - Mandalay"

class Route_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Route_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Route_id.fromJson(dynamic json) {
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
/// date : "2020-12-31"
/// shop : "Max Energy"
/// product_id : {"id":null,"name":null}
/// slip_no : null
/// liter : 30.0
/// price_unit : 500.0
/// amount : 15000.0

class Fuelin_ids {
  String _date;
  String _shop;
  Product_id _productId;
  dynamic _slipNo;
  double _liter;
  double _priceUnit;
  double _amount;
  Location_id _location_id;
  int _id;
  bool _add_from_office;

  String get date => _date;
  String get shop => _shop;
  Product_id get productId => _productId;
  dynamic get slipNo => _slipNo;
  double get liter => _liter;
  double get priceUnit => _priceUnit;
  double get amount => _amount;
  Location_id get location_id => _location_id;
  int get id => _id;
  bool get add_from_office => _add_from_office;

  Fuelin_ids({
      String date, 
      String shop, 
      Product_id productId, 
      dynamic slipNo, 
      double liter, 
      double priceUnit, 
      double amount,int id}){
    _date = date;
    _shop = shop;
    _productId = productId;
    _slipNo = slipNo;
    _liter = liter;
    _priceUnit = priceUnit;
    _amount = amount;
    _id = id;
}

  Fuelin_ids.fromJson(dynamic json) {
    _date = json["date"];
    _shop = json["shop"];
    _productId = json["product_id"] != null ? Product_id.fromJson(json["product_id"]) : null;
    _slipNo = json["slip_no"];
    _liter = json["liter"];
    _priceUnit = json["price_unit"];
    _amount = json["amount"];
    _location_id = json["location_id"]!= null ? Location_id.fromJson(json["location_id"]) : null;
    _id = json["id"];
    _add_from_office = json["add_from_office"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    map["shop"] = _shop;
    if (_productId != null) {
      map["product_id"] = _productId.toJson();
    }
    map["slip_no"] = _slipNo;
    map["liter"] = _liter;
    map["price_unit"] = _priceUnit;
    map["amount"] = _amount;
    return map;
  }

}


/// is_required : null
/// route_id : {"id":null,"name":null}
/// standard_liter : 0
/// consumed_liter : 0
/// description : null

class PlanTrip_Consumption_ids {
  dynamic _isRequired;
  Route_id _routeId;
  int _standardLiter;
  double _consumedLiter;
  dynamic _description;
  int _id;

  dynamic get isRequired => _isRequired;
  Route_id get routeId => _routeId;
  int get standardLiter => _standardLiter;
  double get consumedLiter => _consumedLiter;
  int get id => _id;
  dynamic get description => _description;

  PlanTrip_Consumption_ids({
      dynamic isRequired, 
      Route_id routeId, 
      int standardLiter, 
      double consumedLiter,
      dynamic description}){
    _isRequired = isRequired;
    _routeId = routeId;
    _standardLiter = standardLiter;
    _consumedLiter = consumedLiter;
    _description = description;
}

  PlanTrip_Consumption_ids.fromJson(dynamic json) {
    _isRequired = json["is_required"];
    _routeId = json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
    _standardLiter = json["standard_liter"];
    _consumedLiter = json["consumed_liter"];
    _description = json["description"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["is_required"] = _isRequired;
    if (_routeId != null) {
      map["route_id"] = _routeId.toJson();
    }
    map["standard_liter"] = _standardLiter;
    map["consumed_liter"] = _consumedLiter;
    map["description"] = _description;
    return map;
  }

}

/// route_expense_id : {"id":6,"name":"Toll Gate"}
/// standard_amount : 2000.0
/// actual_amount : 0.0

class Expense_ids {
  Route_expense_id _routeExpenseId;
  ERoute_id _eRouteId;
  double _standardAmount;
  double _actualAmount;
  double _overAmount;
  int _id;
  String _attachement_image;
  String _description;

  Route_expense_id get routeExpenseId => _routeExpenseId;
  ERoute_id get eRouteId => _eRouteId;
  double get standardAmount => _standardAmount;
  double get actualAmount => _actualAmount;
  double get overAmount => _overAmount;
  int get id => _id;
  String get attachement_image => _attachement_image;
  String get description => _description;

  Expense_ids({
      Route_expense_id routeExpenseId, 
      ERoute_id eRouteId,
      double standardAmount, 
      double actualAmount}){
    _routeExpenseId = routeExpenseId;
    _standardAmount = standardAmount;
    _actualAmount = actualAmount;
}

  Expense_ids.fromJson(dynamic json) {
    _routeExpenseId = json["route_expense_id"] != null ? Route_expense_id.fromJson(json["route_expense_id"]) : null;
    _eRouteId = json["route_id"] != null ? ERoute_id.fromJson(json["route_id"]) : null;
    _standardAmount = json["standard_amount"];
    _actualAmount = json["actual_amount"];
    _overAmount = json["over_amount"];
    _id = json['id'];
    _attachement_image = json['attached_file'];
    _description = json['description']!=null?json['description']:'';
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_routeExpenseId != null) {
      map["route_expense_id"] = _routeExpenseId.toJson();
    }
    if (_eRouteId != null) {
      map["route_id"] = _eRouteId.toJson();
    }
    map["standard_amount"] = _standardAmount;
    map["actual_amount"] = _actualAmount;
    return map;
  }

}

/// id : 6
/// name : "Toll Gate"

class Route_expense_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Route_expense_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Route_expense_id.fromJson(dynamic json) {
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

/// route_id : {"id":14,"name":"Yangon - Mandalay"}

class Route_plan_ids {
  dynamic _id;
  Route_id _routeId;
  dynamic _startActualDate;
  dynamic _endActualDate;
  dynamic _status;

  dynamic get id => _id;
  Route_id get routeId => _routeId;
  dynamic get startActualDate => _startActualDate;
  dynamic get endActualDate => _endActualDate;
  dynamic get status => _status;

  Route_plan_ids({
      Route_id routeId}){
    _id = id;
    _routeId = routeId;
    _startActualDate = startActualDate;
    _endActualDate = endActualDate;
    _status = status;
}

  Route_plan_ids.fromJson(dynamic json) {
    _id = json["id"];
    _routeId = json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
    _startActualDate = json["start_actual_date"];
    _endActualDate = json["end_actual_date"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
     var map = <String, dynamic>{};
    map["id"] = _id;
    if (_routeId != null) {
      map["route_id"] = _routeId.toJson();
    }
    map["start_actual_date"] = _startActualDate;
    map["end_actual_date"] = _endActualDate;
    map['status'] = _status;
    return map;
  }

}

/// id : null
/// name : null

class Spare2_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Spare2_id({
      dynamic id, 
      dynamic name}){
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

/// id : 5053
/// name : "Akar Phyo"

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

/// id : 5162
/// name : "Aung Myo#1"

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

/// id : 2
/// name : "Opel/Ampera/9a-2786"

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

class ERoute_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  ERoute_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  ERoute_id.fromJson(dynamic json) {
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

