// @dart=2.9

import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/announcement.dart';
import 'package:winbrother_hr_app/models/depart_empids.dart';
import 'package:winbrother_hr_app/models/department.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/insurance.dart';
import 'package:winbrother_hr_app/models/insurancemodel.dart';
import 'package:winbrother_hr_app/models/loan.dart';
import 'package:winbrother_hr_app/models/odoo_instance.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
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
    Employee emp = await employeeService.getEmployeeProfile("5191");
    expect(validator.checkEmp(emp), ValiationResult.VALID);
  });

  test('checkLogin', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    String barcode = '90179';
    String password = '90179';
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
    List<PaySlips> list = await empService.fetchPayslip("3",'3');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('insuranceList', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    List<Insurancemodel> list = await employeeService.insuranceList('10');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('announcement', () async {
    final validator = Validator();
    final box = GetStorage();
    EmployeeService employeeService = await EmployeeService().init();
    List<Announcement> list =
        await employeeService.announcement("3",'9');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('fetchDepartmentList', () async {
    final validator = Validator();
    MasterService masterService = await MasterService().init();
    List<Department> list = await masterService.getDepartmentList(5191);
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('changePassword', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    bool success =
        await employeeService.changePassword("2", "111111", "444444");
    expect(validator.checkSuccessCreate(success), ValiationResult.VALID);
  });

  test('updatePhone', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    bool success =
    await employeeService.updateEmployeePhone("5191","0955555555");
    expect(validator.checkSuccessCreate(success), ValiationResult.VALID);
  });
  test('updateEmail', () async {
    final validator = Validator();
    EmployeeService employeeService = await EmployeeService().init();
    bool success =
    await employeeService.updateEmployeeEmail("5191","testmail.com");
    expect(validator.checkSuccessCreate(success), ValiationResult.VALID);
  });


}
