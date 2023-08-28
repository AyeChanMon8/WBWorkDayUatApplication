// @dart=2.9


import 'fleet_model.dart';

class Plantrip_waybill {
  int _id;
  dynamic _name;
  String _code;
  String _state;
  String _fromDatetime;
  String _toDatetime;
  double _duration;
  Vehicle_id _vehicleId;
  Create_uid _createUid;
  Driver_id _driverId;
  Trailer_id _trailerId;
  Spare_id _spareId;
  List<WayBill_Route_plan_ids> _routePlanIds;
  List<Waybill_ids> _waybillIds;
  List<WayBill_Expense_ids> _expenseIds;
  List<Consumption_ids> _consumptionIds;
  double _lastOdometer;
  double _currentOdometer;
  double _tripDistance;
  int _totalStandardLiter;
  double _totalConsumedLiter;
  double _avgCalculation;
  List<Commission_ids> _commissionIds;
  List<WayBill_Fuelin_ids> _fuelinIds;
  List<WayBill_Request_allowance_lines> _requestAllowanceLines;
  double _totalAdvance;
  double _duration_hours;

  int get id => _id;
  String get name => _name;
  String get code => _code;
  String get state => _state;
  String get fromDatetime => _fromDatetime;
  String get toDatetime => _toDatetime;
  double get duration => _duration;
  double get duration_hours => _duration_hours;
  Vehicle_id get vehicleId => _vehicleId;
  Create_uid get createUid => _createUid;
  Driver_id get driverId => _driverId;
  Trailer_id get trailerId => _trailerId;
  Spare_id get spareId => _spareId;
  List<WayBill_Route_plan_ids> get routePlanIds => _routePlanIds;
  List<Waybill_ids> get waybillIds => _waybillIds;
  List<WayBill_Expense_ids> get expenseIds => _expenseIds;
  List<Consumption_ids> get consumptionIds => _consumptionIds;
  double get lastOdometer => _lastOdometer;
  double get currentOdometer => _currentOdometer;
  double get tripDistance => _tripDistance;
  int get totalStandardLiter => _totalStandardLiter;
  double get totalConsumedLiter => _totalConsumedLiter;
  double get avgCalculation => _avgCalculation;
  List<Commission_ids> get commissionIds => _commissionIds;
  List<WayBill_Fuelin_ids> get fuelinIds => _fuelinIds;
  List<WayBill_Request_allowance_lines> get requestAllowanceLines => _requestAllowanceLines;
  double get totalAdvance => _totalAdvance;

  Plantrip_waybill({
      int id, 
      dynamic name,
      String code,
      String state, 
      String fromDatetime, 
      String toDatetime, 
      double duration, 
      Vehicle_id vehicleId, 
      Create_uid createUid, 
      Driver_id driverId, 
      Trailer_id trailerId, 
      Spare_id spareId, 
      List<WayBill_Route_plan_ids> routePlanIds,
      List<Waybill_ids> waybillIds, 
      List<WayBill_Expense_ids> expenseIds,
      List<Consumption_ids> consumptionIds, 
      double lastOdometer, 
      double currentOdometer, 
      double tripDistance, 
      int totalStandardLiter, 
      double totalConsumedLiter, 
      double avgCalculation, 
      List<Commission_ids> commissionIds, 
      List<WayBill_Fuelin_ids> fuelinIds,
      List<WayBill_Request_allowance_lines> requestAllowanceLines,
      double totalAdvance}){
    _id = id;
    _name = name;
    _code = code;
    _state = state;
    _fromDatetime = fromDatetime;
    _toDatetime = toDatetime;
    _duration = duration;
    _vehicleId = vehicleId;
    _createUid = createUid;
    _driverId = driverId;
    _trailerId = trailerId;
    _spareId = spareId;
    _routePlanIds = routePlanIds;
    _waybillIds = waybillIds;
    _expenseIds = expenseIds;
    _consumptionIds = consumptionIds;
    _lastOdometer = lastOdometer;
    _currentOdometer = currentOdometer;
    _tripDistance = tripDistance;
    _totalStandardLiter = totalStandardLiter;
    _totalConsumedLiter = totalConsumedLiter;
    _avgCalculation = avgCalculation;
    _commissionIds = commissionIds;
    _fuelinIds = fuelinIds;
    _requestAllowanceLines = requestAllowanceLines;
    _totalAdvance = totalAdvance;
}

  Plantrip_waybill.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _code = json["code"];
    _state = json["state"];
    _fromDatetime = DateTime.parse(json["from_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _toDatetime = DateTime.parse(json["to_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
    _duration = json["duration"];
    _duration_hours = json["duration_hrs"];
    _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
    _createUid = json["create_uid"] != null ? Create_uid.fromJson(json["create_uid"]) : null;
    _driverId = json["driver_id"] != null ? Driver_id.fromJson(json["driver_id"]) : null;
    _trailerId = json["trailer_id"] != null ? Trailer_id.fromJson(json["trailer_id"]) : null;
    _spareId = json["spare_id"] != null ? Spare_id.fromJson(json["spare_id"]) : null;
    if (json["route_plan_ids"] != null) {
      _routePlanIds = [];
      json["route_plan_ids"].forEach((v) {
        _routePlanIds.add(WayBill_Route_plan_ids.fromJson(v));
      });
    }
    if (json["waybill_ids"] != null) {
      _waybillIds = [];
      json["waybill_ids"].forEach((v) {
        _waybillIds.add(Waybill_ids.fromJson(v));
      });
    }
    if (json["expense_ids"] != null) {
      _expenseIds = [];
      json["expense_ids"].forEach((v) {
        _expenseIds.add(WayBill_Expense_ids.fromJson(v));
      });
    }
    if (json["consumption_ids"] != null) {
      _consumptionIds = [];
      json["consumption_ids"].forEach((v) {
        _consumptionIds.add(Consumption_ids.fromJson(v));
      });
    }
    _lastOdometer = json["last_odometer"];
    _currentOdometer = json["current_odometer"];
    _tripDistance = json["trip_distance"];
    _totalStandardLiter = json["total_standard_liter"];
    _totalConsumedLiter = json["total_consumed_liter"];
    _avgCalculation = json["avg_calculation"];
    if (json["commission_ids"] != null) {
      _commissionIds = [];
      json["commission_ids"].forEach((v) {
        _commissionIds.add(Commission_ids.fromJson(v));
      });
    }
    if (json["fuelin_ids"] != null) {
      _fuelinIds = [];
      json["fuelin_ids"].forEach((v) {
        _fuelinIds.add(WayBill_Fuelin_ids.fromJson(v));
      });
    }
    if (json["request_allowance_lines"] != null) {
      _requestAllowanceLines = [];
      json["request_allowance_lines"].forEach((v) {
        _requestAllowanceLines.add(WayBill_Request_allowance_lines.fromJson(v));
      });
    }
    _totalAdvance = json["advance_allowed"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["code"] = _code;
    map["state"] = _state;
    map["from_datetime"] = _fromDatetime;
    map["to_datetime"] = _toDatetime;
    map["duration"] = _duration;
    if (_vehicleId != null) {
      map["vehicle_id"] = _vehicleId.toJson();
    }
    if (_createUid != null) {
      map["create_uid"] = _createUid.toJson();
    }
    if (_driverId != null) {
      map["driver_id"] = _driverId.toJson();
    }
    if (_trailerId != null) {
      map["trailer_id"] = _trailerId.toJson();
    }
    if (_spareId != null) {
      map["spare_id"] = _spareId.toJson();
    }
    if (_routePlanIds != null) {
      map["route_plan_ids"] = _routePlanIds.map((v) => v.toJson()).toList();
    }
    if (_waybillIds != null) {
      map["waybill_ids"] = _waybillIds.map((v) => v.toJson()).toList();
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
    if (_commissionIds != null) {
      map["commission_ids"] = _commissionIds.map((v) => v.toJson()).toList();
    }
    if (_fuelinIds != null) {
      map["fuelin_ids"] = _fuelinIds.map((v) => v.toJson()).toList();
    }
    if (_requestAllowanceLines != null) {
      map["request_allowance_lines"] = _requestAllowanceLines.map((v) => v.toJson()).toList();
    }
    map["total_advance"] = _totalAdvance;
    return map;
  }

}

/// expense_categ_id : {"id":7,"name":"Transportation"}
/// quantity : 1.0
/// amount : 3900.0
/// total_amount : 3900.0
/// remark : "erererere"

class WayBill_Request_allowance_lines {
  WayBill_Expense_categ_id _expenseCategId;
  double _quantity;
  double _amount;
  double _totalAmount;
  String _remark;
  int _id;


  WayBill_Expense_categ_id get expenseCategId => _expenseCategId;
  double get quantity => _quantity;
  double get amount => _amount;
  double get totalAmount => _totalAmount;
  String get remark => _remark;
  int get id => _id;
  WayBill_Request_allowance_lines({
    WayBill_Expense_categ_id expenseCategId,
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

  WayBill_Request_allowance_lines.fromJson(dynamic json) {
    _expenseCategId = json["expense_categ_id"] != null ? WayBill_Expense_categ_id.fromJson(json["expense_categ_id"]) : null;
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

/// id : 7
/// name : "Transportation"

class WayBill_Expense_categ_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  WayBill_Expense_categ_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  WayBill_Expense_categ_id.fromJson(dynamic json) {
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
/// date : "2021-03-19"
/// shop : "wwwww"
/// product_id : {"id":null,"name":null}
/// slip_no : "22222"
/// liter : 1.0
/// price_unit : 30000.0
/// amount : 30000.0

class WayBill_Fuelin_ids {
  String _date;
  String _shop;
  WayBill_Product_id _productId;
  String _slipNo;
  double _liter;
  double _priceUnit;
  double _amount;
  Location_id _location_id;
  int _id;
  bool _add_from_office;

  String get date => _date;
  String get shop => _shop;
  WayBill_Product_id get productId => _productId;
  String get slipNo => _slipNo;
  double get liter => _liter;
  double get priceUnit => _priceUnit;
  double get amount => _amount;
  Location_id get location_id => _location_id;
  bool get add_from_office => _add_from_office;
  int get id=> _id;

  WayBill_Fuelin_ids({
      String date, 
      String shop,
    WayBill_Product_id productId,
      String slipNo, 
      double liter, 
      double priceUnit, 
      double amount,int id,
      Location_id location_id}){
    _date = date;
    _shop = shop;
    _productId = productId;
    _slipNo = slipNo;
    _liter = liter;
    _priceUnit = priceUnit;
    _amount = amount;
    _id = id;
    _location_id = location_id;
}

  WayBill_Fuelin_ids.fromJson(dynamic json) {
    _date = json["date"];
    _shop = json["shop"];
    _productId = json["product_id"] != null ? WayBill_Product_id.fromJson(json["product_id"]) : null;
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
    if (_location_id != null) {
      map["location_id"] = _location_id.toJson();
    }
    map["slip_no"] = _slipNo;
    map["liter"] = _liter;
    map["price_unit"] = _priceUnit;
    map["amount"] = _amount;
    return map;
  }

}

/// id : null
/// name : null

class WayBill_Product_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  WayBill_Product_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  WayBill_Product_id.fromJson(dynamic json) {
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

/// route_id : {"id":15,"name":"Mandalay - Yangon"}
/// commission_driver : 10000
/// commission_spare : 0

class Commission_ids {
  Route_id _routeId;
  int _commissionDriver;
  int _commissionSpare;

  Route_id get routeId => _routeId;
  int get commissionDriver => _commissionDriver;
  int get commissionSpare => _commissionSpare;

  Commission_ids({
      Route_id routeId, 
      int commissionDriver, 
      int commissionSpare}){
    _routeId = routeId;
    _commissionDriver = commissionDriver;
    _commissionSpare = commissionSpare;
}

  Commission_ids.fromJson(dynamic json) {
    _routeId = json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
    _commissionDriver = json["commission_driver"];
    _commissionSpare = json["commission_spare"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_routeId != null) {
      map["route_id"] = _routeId.toJson();
    }
    map["commission_driver"] = _commissionDriver;
    map["commission_spare"] = _commissionSpare;
    return map;
  }

}

/// id : 15
/// name : "Mandalay - Yangon"

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

/// is_required : null
/// route_id : {"id":15,"name":"Mandalay - Yangon"}
/// standard_liter : 100
/// consumed_liter : 0
/// description : null

class Consumption_ids {
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
  dynamic get description => _description;
  int get id => _id;
  Consumption_ids({
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

  Consumption_ids.fromJson(dynamic json) {
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


/// route_expense_id : {"id":8,"name":"Toll Gate"}
/// standard_amount : 5000.0
/// actual_amount : 0.0

class WayBill_Expense_ids {
  Route_expense_id _routeExpenseId;
  ERoute_id _eRouteId;
  double _standardAmount;
  double _actualAmount;
  double _overAmount;
  int _id;
  String _description;
  String _attachement;
  Route_expense_id get routeExpenseId => _routeExpenseId;
  ERoute_id get eRouteId => _eRouteId;
  double get standardAmount => _standardAmount;
  double get actualAmount => _actualAmount;
  double get overAmount => _overAmount;
  int get id => _id;
  String get attachement => _attachement;
  String get description => _description;
  WayBill_Expense_ids({
      Route_expense_id routeExpenseId, 
      ERoute_id eRouteId,
      double standardAmount, 
      double actualAmount}){
    _routeExpenseId = routeExpenseId;
    _standardAmount = standardAmount;
    _actualAmount = actualAmount;
}

  WayBill_Expense_ids.fromJson(dynamic json) {
    _routeExpenseId = json["route_expense_id"] != null ? Route_expense_id.fromJson(json["route_expense_id"]) : null;
    _eRouteId = json["route_id"] != null ? ERoute_id.fromJson(json["route_id"]) : null;
    _standardAmount = json["standard_amount"];
    _actualAmount = json["actual_amount"];
     _overAmount = json["over_amount"];
    _id = json["id"];
    _attachement = json["attached_file"];
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
    map["attached_file"] = _attachement;

    return map;
  }

}

/// id : 8
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

/// account_move_id : {"id":null,"name":null}
/// partner_id : {"id":null,"name":null}
/// date : null
/// amount : 0.0
/// state : null

class Waybill_ids {
  Account_move_id _accountMoveId;
  Partner_id _partnerId;
  dynamic _date;
  double _amount;
  dynamic _state;

  Account_move_id get accountMoveId => _accountMoveId;
  Partner_id get partnerId => _partnerId;
  dynamic get date => _date;
  double get amount => _amount;
  dynamic get state => _state;

  Waybill_ids({
      Account_move_id accountMoveId, 
      Partner_id partnerId, 
      dynamic date, 
      double amount, 
      dynamic state}){
    _accountMoveId = accountMoveId;
    _partnerId = partnerId;
    _date = date;
    _amount = amount;
    _state = state;
}

  Waybill_ids.fromJson(dynamic json) {
    _accountMoveId = json["account_move_id"] != null ? Account_move_id.fromJson(json["account_move_id"]) : null;
    _partnerId = json["partner_id"] != null ? Partner_id.fromJson(json["partner_id"]) : null;
    _date = json["date"];
    _amount = json["amount"];
    _state = json["state"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_accountMoveId != null) {
      map["account_move_id"] = _accountMoveId.toJson();
    }
    if (_partnerId != null) {
      map["partner_id"] = _partnerId.toJson();
    }
    map["date"] = _date;
    map["amount"] = _amount;
    map["state"] = _state;
    return map;
  }

}

/// id : null
/// name : null

class Partner_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Partner_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  Partner_id.fromJson(dynamic json) {
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

class Account_move_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Account_move_id({
      dynamic id, 
      dynamic name}){
    _id = id;
    _name = name;
}

  Account_move_id.fromJson(dynamic json) {
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

/// route_id : {"id":15,"name":"Mandalay - Yangon"}

class WayBill_Route_plan_ids {
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


  WayBill_Route_plan_ids({
      dynamic id, Route_id routeId,dynamic startActualDate, dynamic endActualDate,dynamic status}){
    _id = id;
    _routeId = routeId;
    _startActualDate = startActualDate;
    _endActualDate = endActualDate;
    _status = status;
}

  WayBill_Route_plan_ids.fromJson(dynamic json) {
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

/// id : 5155
/// name : "Ar Kar Kyaw"

class Spare_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Spare_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Spare_id.fromJson(dynamic json) {
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
/// name : "Trailer A"

class Trailer_id {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Trailer_id({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Trailer_id.fromJson(dynamic json) {
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

class Driver_id {
  dynamic _id;
  dynamic _name;

  dynamic get id => _id;
  dynamic get name => _name;

  Driver_id({
      dynamic id, 
      dynamic name}){
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

/// id : 1
/// name : "OdooBot"

class Create_uid {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Create_uid({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Create_uid.fromJson(dynamic json) {
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

/// id : 8
/// name : "Daung Feng/2020/5R/7234"

class Vehicle_id {
  int _id;
  String _name;
  Incharge_id _inchargeId;

  int get id => _id;
  String get name => _name;
  Incharge_id get inchargeId => _inchargeId;

  Vehicle_id({
      int id, 
      String name,
      Incharge_id inchargeId}){
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