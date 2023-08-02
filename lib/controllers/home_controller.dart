import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var title = 'HiHIHI';
  static HomeController to = Get.find();
  final EmployeeService employeeService = EmployeeService();

  //HomeController({@required this.employeeService}) : assert(employeeService != null);
  @override
  void onReady() async {
    super.onReady();
    //run every time auth state changes
    // super.onInit();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
