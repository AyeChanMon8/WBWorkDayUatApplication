// @dart=2.9

/// trip_waybill_id : 4
/// route_expense_id : 6
/// actual_amount : 4500
/// description : "Business Trip"

class Plantrip_waybill_expense_line {
  int _tripWaybillId;
  int _routeExpenseId;
  double _actualAmount;
  String _description;
  String _image;

  int get tripWaybillId => _tripWaybillId;
  int get routeExpenseId => _routeExpenseId;
  double get actualAmount => _actualAmount;
  String get description => _description;
  String get image => _image;

  Plantrip_waybill_expense_line({
      int tripWaybillId, 
      int routeExpenseId, 
      double actualAmount,
      String description,String image}){
    _tripWaybillId = tripWaybillId;
    _routeExpenseId = routeExpenseId;
    _actualAmount = actualAmount;
    _description = description;
    _image = image;
}

  Plantrip_waybill_expense_line.fromJson(dynamic json) {
    _tripWaybillId = json["trip_waybill_id"];
    _routeExpenseId = json["route_expense_id"];
    _actualAmount = json["actual_amount"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
  //  map["trip_waybill_id"] = _tripWaybillId;
    map["route_expense_id"] = _routeExpenseId;
    map["actual_amount"] = _actualAmount;
    map["description"] = _description;
    map["attached_file"] = _image;
    return map;
  }

}