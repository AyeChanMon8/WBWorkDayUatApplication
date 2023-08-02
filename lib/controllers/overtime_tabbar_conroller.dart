// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/overtime_request_response.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';

class OverTimeTabController extends GetxController {
  static OverTimeTabController to = Get.find();
  EmployeeService employeeService;
  var otList = List<OvertimeRequestResponse>().obs;
  var otAcceptedList = List<OvertimeRequestResponse>().obs;
  var otDeclinedList = List<OvertimeRequestResponse>().obs;
  final box = GetStorage();
  var tabbarshow = 1.obs;

  var button_show = false;
  // UserProfileController({@required this.employeeService}) : assert(employeeService != null);

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // _getOtList();
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
