// @dart=2.9

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/models/base_route.dart';
import 'package:winbrother_hr_app/models/daytrip_expense.dart';
import 'package:winbrother_hr_app/models/depart_empids.dart';
import 'package:winbrother_hr_app/models/department.dart';
import 'package:winbrother_hr_app/models/employee_category.dart';
import 'package:winbrother_hr_app/models/leave_type.dart';
import 'package:winbrother_hr_app/models/overtime_category.dart';
import 'package:winbrother_hr_app/models/rating_config.dart';
import 'package:winbrother_hr_app/models/stock_location.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_expense_approve_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_category.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_product.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';

class MasterService extends OdooService {
  Dio dioClient;

  Future<MasterService> init() async {
    dioClient = await client();
    return this;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<List<LeaveType>> getLeaveType() async {
    String url = Globals.baseURL +
        "/hr.leave.type?filters=[('show_in_mobile_app','=','t')]&order=code";
    Response response = await dioClient.get(url);
    List<LeaveType> states = new List<LeaveType>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(LeaveType.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseCategory>> getTravelExpenseCategory(int companyID) async {
    String url = Globals.baseURL +
        "/product.category?filters=[('travel_expense','=',True),'|',('company_id', '=', "+companyID.toString()+"), ('company_id', '=', False)]";
    Response response = await dioClient.get(url);
    List<TravelExpenseCategory> states = new List<TravelExpenseCategory>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(TravelExpenseCategory.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseCategory>> getOutofPocketExpenseCategory(int companyID) async {
    String url = Globals.baseURL +
        "/product.category?filters=[('out_of_pocket_expense','=',True),'|', ('company_id', '=', "+companyID.toString()+"), ('company_id', '=', False)]";
    Response response = await dioClient.get(url);
    List<TravelExpenseCategory> states = new List<TravelExpenseCategory>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(TravelExpenseCategory.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseProduct>> getTravelExpenseProduct(int id,String companyID) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('product_tmpl_id.categ_id','=',$id),'|',('product_tmpl_id.company_id','=',"+companyID.toString()+"),('product_tmpl_id.company_id','=','false')]";

    Response response = await dioClient.get(url);
    List<TravelExpenseProduct> states = new List<TravelExpenseProduct>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if(response.data['count']!=0){
        list.forEach((v) {
          states.add(TravelExpenseProduct.fromMap(v));
        });
      }
    }
    return states;
  }

  Future<List<TravelRequestListResponse>> getTravelApproveList(
      int empID) async {
    http://54.254.62.118:8069/api/travel.request?filters=%5B('state','in',('approve',in_progress','advance_request','advance_withdraw')),('employee_id','=',6029)%5D
    //String url = "/travel.request?filters=[('state','not in',('draft','submit','cancel')),('employee_id',"=",6115)]";
    String url = Globals.baseURL+ "/travel.request?filters=[('state','in',('approve','advance_request','advance_withdraw')),('employee_id','=',"+empID.toString()+")]";
    Response response = await dioClient.get(url);
    List<TravelRequestListResponse> travel_list =
        new List<TravelRequestListResponse>();
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<TravelRequestListResponse>> getOneTravelApprove(
      int empID,int travel_id) async {
    http://54.254.62.118:8069/api/travel.request?filters=%5B('state','in',('approve','advance_request','advance_withdraw')),('employee_id','=',6029)%5D
    //String url = "/travel.request?filters=[('state','not in',('draft','submit','cancel')),('employee_id',"=",6115)]";
    String url = Globals.baseURL+ "/travel.request/"+travel_id.toString()+"?filters=[('employee_id','=',"+empID.toString()+")]";
    Response response = await dioClient.get(url);
    List<TravelRequestListResponse> travel_list =
    new List<TravelRequestListResponse>();
    if (response.statusCode == 200) {
      print(response.toString());
      travel_list.add(TravelRequestListResponse.fromMap(response.data));
      /*var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }*/
    }
    return travel_list;
  }



  Future<List<EmployeeCategory>> getEmployeeCategoryList() async {
    String url = Globals.baseURL + "/hr.employee.category";
    Response response = await dioClient.get(url);
    List<EmployeeCategory> category_list = new List<EmployeeCategory>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        category_list.add(EmployeeCategory.fromMap(v));
      });
    }
    return category_list;
  }

  Future<List<Department>> getDepartmentList(int empID) async {
    String url = Globals.baseURL + "/ot.request/1/get_department_filter";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<Department> department_list = new List<Department>();
    // List<DepartmentEmpIds> department_list = response.data;
    // print(department_list);
    // print("Test");
    if (response.statusCode == 200) {
      var list = response.data;
      list.forEach((v) {
        department_list.add(Department.fromMap(v));
      });
    }
    return department_list;
  }
  Future<List<OvertimeCategory>> getOvertimeCategoryList(int empID) async {
    String url = Globals.baseURL + "/ot.request/1/get_overtime_category";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<OvertimeCategory> category_list = new List<OvertimeCategory>();
    // List<DepartmentEmpIds> department_list = response.data;
    // print(department_list);
    // print("Test");
    if (response.statusCode == 200) {
      var list = response.data;
      list.forEach((v) {
        category_list.add(OvertimeCategory.fromMap(v));
      });
    }
    return category_list;
  }
  
  getRouteIDsList(String trip_id,String tripType) async {
    String url = Globals.baseURL + "/hr.employee/2/get_route_list";
    Response response = await dioClient.put(url, data: jsonEncode({'trip_id': int.tryParse(trip_id),'trip_type': tripType}));
    List<dynamic> travel_ids = response.data;
    print(response.data);
    return travel_ids;
  }
  Future<List<BaseRoute>> getRouteList(String tripID,String tripType) async {
    List<dynamic> route_ids = await getRouteIDsList(tripID,tripType);
    String url = Globals.baseURL + "/route.plan";
    String filter = "[('id','in'," + route_ids.toString() + ")]";
    Response response =
    await dioClient.get(url, queryParameters: {"filters": filter});
    // String url = Globals.baseURL + "/route.plan?filters=[('state', 'in', ('approve', 'verify')), ('company_id', '=', "+companyID.toString()+"), ('branch_id', '=', "+branchID.toString()+")]";
    // Response response = await dioClient.get(url);
    List<BaseRoute> route_list = new List<BaseRoute>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if(response.data['count']!=0){
        list.forEach((v) {
          route_list.add(BaseRoute.fromMap(v));
        });
      }

    }
    return route_list;
  }

  Future<List<RatingConfig>> getRatingConfig() async {
    String url = Globals.baseURL +
        "/rating.structure?filters=&order=point desc";
    Response response = await dioClient.get(url);
    List<RatingConfig> states = new List<RatingConfig>();
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(RatingConfig.fromMap(v));
      });
    }
    return states;
  }

}
