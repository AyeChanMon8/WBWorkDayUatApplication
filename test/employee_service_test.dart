// @dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/depart_empids.dart';
import 'package:winbrother_hr_app/models/department.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/insurance.dart';
import 'package:winbrother_hr_app/models/insurancemodel.dart';
import 'package:winbrother_hr_app/models/loan.dart';
import 'package:winbrother_hr_app/models/odoo_instance.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/models/reward.dart';
import 'package:winbrother_hr_app/models/warning.dart';
import 'package:winbrother_hr_app/models/warning_model.dart';
import 'package:winbrother_hr_app/services/attendance_service.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'package:winbrother_hr_app/services/overtime_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'Validator.dart';

void main() async {
  test('Testing odoo Services', () async {
    OdooService odooService = OdooService();
    OdooInstance odooInstance = await odooService.getOdooInstance();
    print(odooInstance.user.access_token);
    expect(odooInstance.connected, true);
    expect(odooInstance.user.uid, 2);
  });

  test('getEmpInfo', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    String empID = '2';
    Employee emp = await employeeService.getEmployeeProfile(empID);
    expect(validator.checkEmp(emp), ValiationResult.VALID);
  });

  test('checkLogin', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    String barcode = 'WB0001';
    String password = '11223';
    String emp_id = await employeeService.checkLogin(barcode, password);
    expect(validator.checkEmpID(int.tryParse(emp_id)), ValiationResult.VALID);
  });

  test('forgetPassword', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    String barcode = 'WB0121';
    String pinCode = await employeeService.forgetPassword(barcode);
    expect(validator.checkPinCode(pinCode), ValiationResult.VALID);
  });

  test('getEmployeeIds', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    List<dynamic> emp_ids = await employeeService.getEmployeeList(2);

    expect(validator.checkListNotEmpty(emp_ids), ValiationResult.VALID);
  });

  test('getEmployeeCategoryList', () async {
    final validator = Validator();
    MasterService masterService = await MasterService().init();
    List<dynamic> list = await masterService.getEmployeeCategoryList();

    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('checkRole', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    String role = await employeeService.checkRole(2);
    expect(validator.checkStringIfEmpty(role), ValiationResult.VALID);
  });

  test('fetchLoan', () async {
    final validator = Validator();
    EmployeeService empService = await EmployeeService().init();
    List<Loan> list = await empService.fetchLoan('2','3');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('fetchPayslip', () async {
    final validator = Validator();
    EmployeeService empService = await EmployeeService().init();
    List<PaySlips> list = await empService.fetchPayslip("3",'8');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('insuranceList', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    List<Insurancemodel> list = await employeeService.insuranceList('10');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('fetchDepartmentList', () async {
    final validator = Validator();
    MasterService masterService = await MasterService().init();
    List<Department> list = await masterService.getDepartmentList(5191);
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('checkApprovalId', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    int employee_id = 2;
    String state = "submit";
    List<dynamic> emp_id = await leaveService.getLeaveIDsList("2");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });

  test('checkApprovalIdforAttendance', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    int employee_id = 2;
    String state = "draft";
    List<dynamic> emp_id = await attendanceService.getAttanIDsList("2");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });

  test('changePassword', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    bool success =
        await employeeService.changePassword("2", "111111", "444444");
    expect(validator.checkSuccessCreate(success), ValiationResult.VALID);
  });

  test('rewardList', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    List<Reward> list = await employeeService.rewardList('2','3');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('warningList', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    List<Warning_model> list = await employeeService.warningList('2',"0");
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });
}
