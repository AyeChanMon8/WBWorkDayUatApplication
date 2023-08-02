// @dart=2.9

/// trip_product_id : 4
/// route_expense_id : 6
/// actual_amount : 4500
/// description : "business trip"

class Plantrip_product_expense_line {
  int _tripProductId;
  int _routeExpenseId;
  double _actualAmount;
  String _description;
  int _id;
  String _image;

  int get tripProductId => _tripProductId;
  int get routeExpenseId => _routeExpenseId;
  double get actualAmount => _actualAmount;
  String get description => _description;

  Plantrip_product_expense_line({
      int tripProductId, 
      int routeExpenseId, 
      double actualAmount,
      String description,int id,String image}){
   // _tripProductId = tripProductId;
    _routeExpenseId = routeExpenseId;
    _actualAmount = actualAmount;
    _description = description;
    _id = id;
    _image = image;
}

  Plantrip_product_expense_line.fromJson(dynamic json) {
    _tripProductId = json["trip_product_id"];
    _routeExpenseId = json["route_expense_id"];
    _actualAmount = json["actual_amount"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
   // map["trip_product_id"] = _tripProductId;
    map["route_expense_id"] = _routeExpenseId;
    map["actual_amount"] = _actualAmount;
    map["description"] = _description;
    map["attached_file"] = _image;
    return map;
  }

}