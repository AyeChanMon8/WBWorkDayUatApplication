// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/hr_rule.dart';
import 'package:winbrother_hr_app/models/loan.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class PayslipController extends GetxController {
  static PayslipController to = Get.find();
  EmployeeService employeeService;
  var paySlips = List<PaySlips>().obs;
  var rulesList = List<Hr_rule>().obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();

    this.employeeService = await EmployeeService().init();
    // _getloanList();
    getPaySlips();
  }

  @override
  void onInit() {
    super.onInit();
    // _getloanList();
  }

  getPaySlips() async {
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
    var employee_id = box.read('emp_id');
    await employeeService.fetchPayslip(employee_id,offset.toString()).then((data) {
      print("payslipLength");
      print(data.length);
      if(offset!=0){
        isLoading.value = false;
        data.forEach((element) {
          paySlips.add(element);
        });
      }else{
        paySlips.value = data;
      }
      Get.back();
    });

  }

  @override
  void onClose() {
    super.onClose();
  }
}
