// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/OrganizationChart.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrganizationalChartController extends GetxController {
  static OrganizationalChartController to = Get.find();
  final box = GetStorage();
  EmployeeService employeeService;
  var empData = Employee().obs;
  RxString orgList = "".obs;
  var array = List().obs;

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    _getUserInfo();
  }

  @override
  void onInit() {
    super.onInit();
  }

  _getUserInfo() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    final box = GetStorage();
    var employee_id = box.read('emp_id');
    await employeeService.getEmployeeProfile(employee_id).then((data) {
      empData.value = data;
      //fetchChildEmp(data);
      Get.back();
    });
  }

  Future<Employee> getEmployeeInfo(String employee_id) async {
   /* Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));*/
    return await employeeService.getEmployeeProfile(employee_id);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchChildEmp(Employee data) {
    List<String> emp_name_list = List<String>();
    List<String> parent_name_list = List<String>();
    parent_name_list.add(data.name);

    for (int i = 0; i < data.child_ids.length; i++) {
      emp_name_list.add(data.child_ids[i].name);
    }
    var parent_data = OrganizationChart(
            id: data.parent_id.name, email: '', next: parent_name_list)
        .toJson();
    //array.add(parent_data);
    var child_data = OrganizationChart(
            id: data.name, email: data.work_email, next: emp_name_list)
        .toJson();
    array.add(parent_data);
    array.add(child_data);
    //orgList = array.toString();
    orgList.value = array.toString();
  }
}
