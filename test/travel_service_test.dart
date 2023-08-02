// @dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/travel_expense/create/travel_expense_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/create/travel_line_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_list_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/out_of_pocket_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/out_of_pocket_response.dart';
import 'package:winbrother_hr_app/models/travel_expense/pocket_model.dart';
import 'package:winbrother_hr_app/models/travel_expense_category.dart';
import 'package:winbrother_hr_app/models/travel_line.dart';
import 'package:winbrother_hr_app/models/travel_request.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'Validator.dart';

void main() async {
  test('travelRequest', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();

    List<TravelLine> travel_list = new List<TravelLine>();
    travel_list.add(TravelLine(
        date: "2020-10-01", destination: "YGN-Paegu", purpose: "Survey"));
    travel_list.add(TravelLine(
        date: "2020-10-01", destination: "Paegu-MDY", purpose: "Survey"));
    TravelRequest travelRequest = TravelRequest(
        employee_id: 2,
        start_date: "2020-10-01",
        end_date: "2020-10-02",
        city_from: "Ygn",
        city_to: "Mdy",
        duration: 2,
        travel_line: travel_list);
    int travel_id = await employeeService.travelRequest(travelRequest);
    expect(validator.checkIdReturn(travel_id), ValiationResult.VALID);
  });

  test('travelRequestList', () async {
    final validator = Validator();
    TravelRequestService employeeService = await TravelRequestService().init();
    List<TravelRequestListResponse> travelList =
        await employeeService.getTravelRequestListForEmp('5420',"5");
    expect(validator.checkListNotEmpty(travelList), ValiationResult.VALID);
  });
  test('travelToApproveList', () async {
    final validator = Validator();
    TravelRequestService employeeService = await TravelRequestService().init();
    List<TravelRequestListResponse> travelList =
        await employeeService.getTravelRequestToApprove('5191',"");
    expect(validator.checkListNotEmpty(travelList), ValiationResult.VALID);
  });

  test('checkApprovalIdforTravel', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    int employee_id = 2;
    String state = "submit";
    List<dynamic> emp_id = await travelService.getTravelIDsList("2");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });
  test('fetchExpenseCategory', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    List<TravelExpenseCategory> list = await travelService.getExpenseCategory(7);
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });
  test('createPocket', () async {
    final validator = Validator();
    TravelRequestService travelRequestService =
        await TravelRequestService().init();

    List<PockectModel> pocket_list = new List<PockectModel>();

    pocket_list.add(PockectModel(
        date: "2020-10-01",
        categ_id: 1,
        product_id: 1,
        description: "Test Desc",
        qty: 2,
        price_unit: 100.0,
        price_subtotal: 200.0,
        attached_file: ""));

    OutofPocketModel pocket = OutofPocketModel(
      date: "2020-10-01",
      employee_id: 5420,
      company_id: 7,
      pocket_line: pocket_list,
    );
    int id = await travelRequestService.createOutofPocket(pocket);
    expect(validator.checkIdReturn(id), ValiationResult.VALID);
  });

  test('createTravelList', () async {
    final validator = Validator();
    TravelRequestService travelRequestService =
        await TravelRequestService().init();

    List<TravelLineModel> pocket_list = new List<TravelLineModel>();

    pocket_list.add(TravelLineModel(
        date: "2020-10-01",
        categ_id: 1,
        product_id: 1,
        description: "Test Desc",
        qty: 2,
        price_unit: 100.0,
        price_subtotal: 200.0,));

    TravelExpenseModel pocket = TravelExpenseModel(
      date: "2020-10-01",
      employee_id: 5420,
      company_id: 7,
      travel_line: pocket_list,
    );
    int id = await travelRequestService.createTravelRequest(pocket);
    expect(validator.checkIdReturn(id), ValiationResult.VALID);
  });
  test('checkToApproveOutOfPocketIDS', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    int employee_id = 2;
    String state = "submit";
    List<dynamic> emp_id = await travelService.getOutOfPocketIDsList("5624");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });

  test('checkToApproveOutOfPocket', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    int employee_id = 2;
    String state = "submit";
    List<OutofPocketResponse> list = await travelService.getOutOfPocketApproved("5624",'8');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });
  test('checkToApproveTravelExpenseIDS', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    int employee_id = 2;
    String state = "submit";
    List<dynamic> emp_id = await travelService.getTravelExpenseIDsList("5624");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });

  test('checkToApproveTravelExpense', () async {
    final validator = Validator();
    TravelRequestService travelService = await TravelRequestService().init();
    int employee_id = 2;
    String state = "submit";
    List<TravelExpenseList> list = await travelService.getTravelExpenseApproved("5624","");
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('TravelRequestListResponse', () async {
    final validator = Validator();
    TravelRequestService masterService = await TravelRequestService().init();
    List<TravelRequestListResponse> list = await masterService.getTravelRequestApproved("6115");
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

}
