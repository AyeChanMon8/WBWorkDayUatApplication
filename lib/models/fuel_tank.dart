// @dart=2.9

class Fuel_tank {
  int _id;
  String _name;
  double _capacity;
  dynamic _location;
  dynamic _lastCleanDate;
  double _liters;
  double _averagePrice;
  dynamic _lastFillingDate;
  double _lastFillingAmount;
  double _lastFillingPriceLiter;
  List<dynamic> _fuleFillingHistoryIds;
  String _percentageFuel;
  dynamic _lastFuelAddingDate;
  List<Fuel_History> _fuel_history;

  int get id => _id;
  String get name => _name;
  double get capacity => _capacity;
  dynamic get location => _location;
  dynamic get lastCleanDate => _lastCleanDate;
  double get liters => _liters;
  double get averagePrice => _averagePrice;
  dynamic get lastFillingDate => _lastFillingDate;
  double get lastFillingAmount => _lastFillingAmount;
  double get lastFillingPriceLiter => _lastFillingPriceLiter;
  List<dynamic> get fuleFillingHistoryIds => _fuleFillingHistoryIds;
  String get percentageFuel => _percentageFuel;
  dynamic get lastFuelAddingDate => _lastFuelAddingDate;
  List<Fuel_History> get fuel_history =>_fuel_history;

  Fuel_tank({
      int id, 
      String name, 
      double capacity, 
      dynamic location, 
      dynamic lastCleanDate, 
      double liters, 
      double averagePrice, 
      dynamic lastFillingDate, 
      double lastFillingAmount, 
      double lastFillingPriceLiter, 
      List<dynamic> fuleFillingHistoryIds, 
      String percentageFuel, 
      dynamic lastFuelAddingDate}){
    _id = id;
    _name = name;
    _capacity = capacity;
    _location = location;
    _lastCleanDate = lastCleanDate;
    _liters = liters;
    _averagePrice = averagePrice;
    _lastFillingDate = lastFillingDate;
    _lastFillingAmount = lastFillingAmount;
    _lastFillingPriceLiter = lastFillingPriceLiter;
    _fuleFillingHistoryIds = fuleFillingHistoryIds;
    _percentageFuel = percentageFuel;
    _lastFuelAddingDate = lastFuelAddingDate;
}

  Fuel_tank.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _capacity = json["capacity"];
    _location = json["location"];
    _lastCleanDate = json["last_clean_date"];
    _liters = json["liters"];
    _averagePrice = json["average_price"];
    _lastFillingDate = json["last_filling_date"];
    _lastFillingAmount = json["last_filling_amount"];
    _lastFillingPriceLiter = json["last_filling_price_liter"];

    _percentageFuel = json["percentage_fuel"];
    _lastFuelAddingDate = json["last_fuel_adding_date"];

    if (json["fule_filling_history_ids"] != null) {
      _fuel_history = [];
      json["fule_filling_history_ids"].forEach((v) {
        _fuel_history.add(Fuel_History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["capacity"] = _capacity;
    map["location"] = _location;
    map["last_clean_date"] = _lastCleanDate;
    map["liters"] = _liters;
    map["average_price"] = _averagePrice;
    map["last_filling_date"] = _lastFillingDate;
    map["last_filling_amount"] = _lastFillingAmount;
    map["last_filling_price_liter"] = _lastFillingPriceLiter;
    if (_fuleFillingHistoryIds != null) {
      map["fule_filling_history_ids"] = _fuleFillingHistoryIds.map((v) => v.toJson()).toList();
    }
    map["percentage_fuel"] = _percentageFuel;
    map["last_fuel_adding_date"] = _lastFuelAddingDate;
    return map;
  }

}
class Fuel_History {
  double _fuel_liter;
  double _price_per_liter;
  String _filling_date;
  String _source_doc;


  double get fuel_liter => _fuel_liter;
  double get price_per_liter => _price_per_liter;
  String get filling_date => _filling_date;
  String get source_doc => _source_doc;

  Fuel_History({
    double fuel_liter,
    double price_per_liter}){
    _fuel_liter = fuel_liter;
    _price_per_liter = price_per_liter;
  }

  Fuel_History.fromJson(dynamic json) {
    _fuel_liter = json["fuel_liter"];
    _price_per_liter = json["price_per_liter"];
    _filling_date = json["filling_date"];
    _source_doc = json["source_doc"];
  }
}