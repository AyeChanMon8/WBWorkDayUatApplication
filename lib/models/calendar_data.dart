// @dart=2.9
/// travel : [{"employee_id":6115,"start_date":"2021-01-29","end_date":"2021-01-29","name":"ff"}]
/// leave : []
/// training : []
/// trip_product : []
/// trip_bill : [{"employee_id":6115,"start_date":"2021-02-05","end_date":"2021-02-16","name":"Hello"}]

class CalendarData {
  List<Travel> _travel;
  List<Travel> _leave;
  List<Travel> _training;
  List<Travel> _tripProduct;
  List<Travel> _tripBill;
  List<Travel> _calendar;
  List<Travel> _pms;
  List<Travel> _attendance;
  List<Travel> _dayTrip;

  List<Travel> get travel => _travel;
  List<Travel> get leave => _leave;
  List<Travel> get training => _training;
  List<Travel> get tripProduct => _tripProduct;
  List<Travel> get tripBill => _tripBill;
  List<Travel> get calendar => _calendar;
  List<Travel> get pms => _pms;
  List<Travel> get attendance => _attendance;
  List<Travel> get dayTrip => _dayTrip;

  
  CalendarData({
      List<Travel> travel, 
      List<Travel> leave,
      List<Travel> training,
      List<Travel> tripProduct,
      List<Travel> tripBill,
      List<Travel> calendar,
      List<Travel> pms,
      List<Travel> attendance,
      List<Travel> dayTrip,

  }){
    _travel = travel;
    _leave = leave;
    _training = training;
    _tripProduct = tripProduct;
    _tripBill = tripBill;
    _calendar = calendar;
    _pms = pms;
    _attendance = attendance;
    _dayTrip = dayTrip;

}

  CalendarData.fromJson(dynamic json) {
    if (json["travel"] != null) {
      _travel = [];
      json["travel"].forEach((v) {
        _travel.add(Travel.fromJson(v));
      });
    }
    if (json["leave"] != null) {
      _leave = [];
      json["leave"].forEach((v) {
        _leave.add(Travel.fromJson(v));
      });
    }
    if (json["training"] != null) {
      _training = [];
      json["training"].forEach((v) {
        _training.add(Travel.fromJson(v));
      });
    }
    if (json["trip_product"] != null) {
      _tripProduct = [];
      json["trip_product"].forEach((v) {
        _tripProduct.add(Travel.fromJson(v));
      });
    }
    if (json["trip_bill"] != null) {
      _tripBill = [];
      json["trip_bill"].forEach((v) {
        _tripBill.add(Travel.fromJson(v));
      });
    }
    if (json["calendar"] != null) {
      _calendar = [];
      json["calendar"].forEach((v) {
        _calendar.add(Travel.fromJson(v));
      });
    }
        if (json["pms"] != null) {
      _pms = [];
      json["pms"].forEach((v) {
        _pms.add(Travel.fromJson(v));
      });
    }
    if (json["attendance"] != null) {
      _attendance = [];
      json["attendance"].forEach((v) {
        _attendance.add(Travel.fromJson(v));
      });
    }
    if (json["day_trip"] != null) {
      _dayTrip = [];
      json["day_trip"].forEach((v) {
        _dayTrip.add(Travel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_travel != null) {
      map["travel"] = _travel.map((v) => v.toJson()).toList();
    }
    if (_leave != null) {
      map["leave"] = _leave.map((v) => v.toJson()).toList();
    }
    if (_training != null) {
      map["training"] = _training.map((v) => v.toJson()).toList();
    }
    if (_tripProduct != null) {
      map["trip_product"] = _tripProduct.map((v) => v.toJson()).toList();
    }
    if (_tripBill != null) {
      map["trip_bill"] = _tripBill.map((v) => v.toJson()).toList();
    }
    if (_tripBill != null) {
      map["calendar"] = _calendar.map((v) => v.toJson()).toList();
    }
    if (_pms != null) {
      map["pms"] = _pms.map((v) => v.toJson()).toList();
    }
    if (_attendance != null) {
      map["attendance"] = _attendance.map((v) => v.toJson()).toList();
    }
    if (_dayTrip != null) {
      map["day_trip"] = _dayTrip.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


/// employee_id : 6115
/// start_date : "2021-01-29"
/// end_date : "2021-01-29"
/// name : "ff"
class Travel {
  int _employeeId;
  String _startDate;
  String _endDate;
  String _name;
  String _purpose;

  int get employeeId => _employeeId;
  String get startDate => _startDate;
  String get endDate => _endDate;
  String get name => _name;
  String get purpose => _purpose;

  Travel({
    int employeeId,
    String startDate,
    String endDate,
    String name}){
    _employeeId = employeeId;
    _startDate = startDate;
    _endDate = endDate;
    _name = name;
  }

  Travel.fromJson(dynamic json) {
    _employeeId = json["employee_id"];
    _startDate = json["start_date"];
    _endDate = json["end_date"];
    _name = json["name"];
    _purpose = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["employee_id"] = _employeeId;
    map["start_date"] = _startDate;
    map["end_date"] = _endDate;
    map["name"] = _name;
    return map;
  }

}