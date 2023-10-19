// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/employee_benefit.dart';
import 'package:winbrother_hr_app/services/benefit_service.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmployeeBenefitController extends GetxController {
  static EmployeeBenefitController to = Get.find();
  BenefitService benefitService;
  var employeeBenefitList = List<EmployeeBenefit>().obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.benefitService = await BenefitService().init();
  }

  @override
  void onInit() {
    super.onInit();
  }

  getEmployeeBenefitList() async {
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
    this.benefitService = await BenefitService().init();
    await benefitService.fetchEmployeeBenefit(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        print("offsetnotzero");
        print(data.length);
        isLoading.value = false;
        //loanList.value.addAll(data);
        data.forEach((element) {
          employeeBenefitList.add(element);
        });

      }else{
        employeeBenefitList.value = data;
      }
      update();
      Get.back();
    });
  }

  approveLeave(int id) async {
    print(id);
  }

  decllinedLeave(int id) async {
    print(id);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
