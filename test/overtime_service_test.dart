// @dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/category_id.dart';
import 'package:winbrother_hr_app/models/department.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/employee_id.dart';
import 'package:winbrother_hr_app/models/overtime_request.dart';
import 'package:winbrother_hr_app/models/overtime_request_line.dart';
import 'package:winbrother_hr_app/models/overtime_request_response.dart';
import 'package:winbrother_hr_app/models/overtime_response.dart';
import 'package:winbrother_hr_app/services/overtime_service.dart';
import 'Validator.dart';

void main() async {

  test('overtimeRequest', () async {
    final validator = Validator();
    OvertimeService overtimeService = await OvertimeService().init();

    List<OvertimeRequestLine> requestLine_list =
    new List<OvertimeRequestLine>();

    requestLine_list.add(OvertimeRequestLine(
        employee_id: 5053,
        duration: 3,
        start_date: "2021-02-06 12:00",
        end_date: "2021-02-06 12:00",
        email: "hnin.7thcomputing@gmail.com",
        state: "draft"));

    List<Department> dept_list = new List<Department>();

    dept_list.add(Department(
      id: 233
    ));

    var over = OvertimeRequest(
      name: "OT TEST",
      //category_ids: cate4gory_list,
      start_date: "2021-03-03 09:00",
      end_date: "2021-03-03 12:00",
      duration: 5,
      reason: "Win Brother",
      requested_employee_id:6029,
      department_ids:dept_list,
      request_line: requestLine_list,
    );
    String result = await overtimeService.overtimeRequest(2, over);
    //expect(validator.checkIdReturn(result), ValiationResult.VALID);
  });

  test('getEmployeeOvertimeResponseList', () async {
    final validator = Validator();
    OvertimeService overtimeService = await OvertimeService().init();
    List<OvertimeResponse> overtime_list =
    await overtimeService.getEmployeeOvertimeResponseList("10");
    expect(validator.checkListNotEmpty(overtime_list), ValiationResult.VALID);
  });

  test('getManagerOvertimeResponseList', () async {
    final validator = Validator();
    OvertimeService overtimeService = await OvertimeService().init();
    List<OvertimeResponse> overtime_list =
    await overtimeService.getManagerOvertimeResponseList("2");
    expect(validator.checkListNotEmpty(overtime_list), ValiationResult.VALID);
  });
  test('getOvertimeRequestList', () async {
    final validator = Validator();
    OvertimeService overtimeService = await OvertimeService().init();
    List<OvertimeRequestResponse> overtime_list =
    await overtimeService.getOvertimeRequestList("6029",'8');
    expect(validator.checkListNotEmpty(overtime_list), ValiationResult.VALID);
  });

}
