// @dart=2.9

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import 'odoo_service.dart';

class PMSService extends OdooService{
  Dio dioClient;
  @override
  Future<PMSService> init() async {
    print('LeaveService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<PMSDetailModel>> getPMSDetailModelList(String empID,String offset) async {
    String datebefore = AppUtils.oneYearago();
    String url = Globals.baseURL + "/employee.performance?filters=[('employee_id','=',$empID),('state','not in',['draft','cancel']),('create_date','>=','$datebefore')]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=deadline asc";
    Response response = await dioClient.get(url);
    List<PMSDetailModel> pmsDetailModels = new List<PMSDetailModel>();
    if (response.statusCode == 200) {
      if(response.data["count"]>0){
      List list = response.data["results"];
      list.forEach((v) {
        pmsDetailModels.add(PMSDetailModel.fromJson(v));
      });}
    }
    return pmsDetailModels;
  }
  getSelfPMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_self_pms_ids";
    Response response = await dioClient.put(url,data: jsonEncode({'employee_id' : empID}));
    if (response.statusCode == 200) {
      if(response!=null){
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }
  getToApprovePMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_pms_approval_lists";
    Response response = await dioClient.put(url,data: jsonEncode({'employee_id' : empID}));
    if (response.statusCode == 200) {
      if(response!=null){
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }
  getApprovedPMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_pms_approve_lists";
    Response response = await dioClient.put(url,data: jsonEncode({'employee_id' : empID}));
    if (response.statusCode == 200) {
      if(response!=null){
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }

  Future<List<PMSDetailModel>> getPmsToApproveList(int empID,String offset) async{
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList = await getToApprovePMSIdsList(empID);//+Globals.pag_limit.toString()
    var limit = idsList.length;
    String url = Globals.baseURL + "/employee.performance?filters=[('id','in',${idsList.toString()})]&limit=${limit}"+"&offset="+offset+"&order=create_date desc";
    Response response = await dioClient.get(url);
    if(response.statusCode==200){
      var list = response.data['results'];
      var count = response.data['count'];
      if(count!=0){
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromJson(v));
        });
      }
    }
    return pmsList;
  }
  Future<List<PMSDetailModel>> getPmSelfList(int empID,String offset) async{
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList = await getSelfPMSIdsList(empID);
    String url = Globals.baseURL + "/employee.performance?filters=[('id','in',${idsList.toString()})]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=create_date desc";
    Response response = await dioClient.get(url);
    if(response.statusCode==200){
      var list = response.data['results'];
      var count = response.data['count'];
      if(count!=0){
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromJson(v));
        });
      }

    }
    return pmsList;
  }
  Future<List<PMSDetailModel>> getPmsApprovedList(int empID,String offset) async{
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList = await getApprovedPMSIdsList(empID);
    String url = Globals.baseURL + "/employee.performance?filters=[('id','in',${idsList.toString()})]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=create_date desc";
    Response response = await dioClient.get(url);
    if(response.statusCode==200){
      var list = response.data['results'];
      var count = response.data['count'];
      if(count!=0){
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromJson(v));
        });
      }

    }

    return pmsList;
  }
  Future<String> editEmployeeRate(String employeeRateId,double value,String remark) async{
    String url = Globals.baseURL + "/key.performance/$employeeRateId";
    Response response = await dioClient.put(url,data: jsonEncode({"employee_rate":value,"employee_remark":remark}));
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> editManagerRate(String managerRateId,double value,String remark) async{
    String url = Globals.baseURL + "/key.performance/$managerRateId";
    Response response = await dioClient.put(url,data: jsonEncode({"manager_rate":value,"manager_remark":remark}));
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> editCompetencyScore(String competenciesId,double value,String remark) async{
    String url = Globals.baseURL + "/key.competencies/$competenciesId";
    Response response = await dioClient.put(url,data: jsonEncode({"score":value,"comment":remark}));
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendAcknowledge(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_acknowledge";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<int> pmsApproveorNot(String empId,String status)async{
    int value = 0;
    String url = Globals.baseURL +"/hr.employee/2/get_respective_manager_id";
    Response response= await dioClient.put(url,data: jsonEncode({"employee_id":int.tryParse(empId),"status":status}));
    if(response.statusCode == 200){
      value = response.data;
      return value;
    }
  }

  Future<String> sendMidYearSelfAssessment(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_mid_year_self_assessment";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendYearEndSelfAssessment(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_year_end_self_assessment";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendToManager(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_sent_manager";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendDone(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_done";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> pmsManagerApprove(String pmsId,String status)async{
    String url = Globals.baseURL +"/hr.employee/2/action_pms_approve";
    Response response= await dioClient.put(url,data: jsonEncode({"parent_id":int.tryParse(pmsId.toString()),"state":status}));
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }
  Future<String> sendMidYearManagerApprove(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_mid_year_manager_approve";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendYearEndManagerApprove(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_year_end_manager_approve";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendMidYearDottedManagerApprove(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_mid_year_dotted_manager_approve";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }

  Future<String> sendYearEndDottedManagerApprove(String pmsId)async{
    String url = Globals.baseURL +"/employee.performance/$pmsId/action_year_end_dotted_manager_approve";
    Response response= await dioClient.put(url);
    if(response.statusCode == 200){
      return 'Success';
    }else{
      return response.statusMessage;
    }
  }
}