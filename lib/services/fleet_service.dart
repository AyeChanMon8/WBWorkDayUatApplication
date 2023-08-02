// @dart=2.9

import 'package:dio/dio.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/models/fleet_insurance.dart';
import 'package:winbrother_hr_app/models/fleet_model.dart';
import 'package:winbrother_hr_app/models/fuel_log_model.dart';
import 'package:winbrother_hr_app/models/fuel_tank.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class FleetService extends OdooService{
  Dio dioClient;
  @override
  Future<FleetService> init() async {
    dioClient = await client();
    return this;
  }
  Future<List<Fleet_model>> getFleetList(var empId)async{
    List<Fleet_model> fleetList = [];
    String url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId})]";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
      list.forEach((v) {
        fleetList.add(Fleet_model.fromJson(v));
      });
    }
    return fleetList;
  }

  Future<List<Fleet_insurance>> getFleetInsuranceList(var vehicleId)async{
    List<Fleet_insurance> fleetList = [];
    String url = Globals.baseURL+"/fleet.insurance?filters=[('vehicle_id','=',${vehicleId})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fleetList.add(Fleet_insurance.fromJson(v));
        });
    }
    return fleetList;
  }

  Future<List<Fuel_log_model>> getFuelLogList(var vehicleId)async{
    List<Fuel_log_model> fuelLogList = [];
    String url = Globals.baseURL+"/fleet.vehicle.log.fuel?filters=[('vehicle_id','=',${vehicleId})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fuelLogList.add(Fuel_log_model.fromJson(v));
        });
    }
    return fuelLogList;
  }

  Future<List<Fuel_tank>> getFuelTankList(String tankID)async{
    List<Fuel_tank> fuelLogList = [];
    String datebefore = AppUtils.onemonthago();
    String url = Globals.baseURL+"/fuel.tank?filters=[('id','=',${tankID})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fuelLogList.add(Fuel_tank.fromJson(v));
        });
    }
    return fuelLogList;
  }
  Future<String> show_current_localize(int vehicleId)async{
    var url_reponsne = "";
    String url = Globals.baseURL+"/fleet.vehicle/"+vehicleId.toString()+"/show_current_localize";

    Response response = await dioClient.put(url);
    if(response.statusCode == 200){
      url_reponsne = response.data['url'];
    }
    return url_reponsne;
  }
}