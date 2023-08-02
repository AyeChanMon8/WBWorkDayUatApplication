// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/overtime_request_response.dart';
import 'package:winbrother_hr_app/services/overtime_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class OverTimeListController extends GetxController {
  static OverTimeListController to = Get.find();
  OvertimeService overtimeService;
  var otList = List<OvertimeRequestResponse>().obs;
  var otAcceptedList = List<OvertimeRequestResponse>().obs;
  var otDeclinedList = List<OvertimeRequestResponse>().obs;
  final box = GetStorage();
  var button_submit_show = true.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.overtimeService = await OvertimeService().init();
    getOtList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getOtList() async {
    // print("OT list controller");
    var emp_id = box.read("emp_id");
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
    await overtimeService.getOvertimeRequestList(emp_id.toString(),offset.toString()).then((data) {
      data.sort(
          (name1, name2) => name2.start_date.compareTo(name1.start_date));
      if(offset!=0){
        isLoading.value = false;
        //otList.addAll(data);
        data.forEach((element) {
          otList.add(element);
        });
      }else{
        otList.value = data;
      }

      Get.back();
    });
  }
  submitOvertime(int id) async {
    // print("OT list controller");
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await overtimeService.submitOvertime(id).then((data) {
      Get.back();

      if (data == 'true') {
        button_submit_show.value = false;
        getOtList();
        AppUtils.showConfirmDialog('Information', "Successfully Submitted!",(){
          Get.back();
          Get.back();
        });
      } else {
        AppUtils.showDialog('Information', data);
      }

      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  cancelOvertime(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await overtimeService.cancelOvertime(id).then((data) {
      Get.back();
      if (data == 'true') {
        button_submit_show.value = true;
        getOtList();
        AppUtils.showConfirmDialog('Information', 'Successfully Deleted!',(){
          Get.back();
          Get.back();
        });
      } else {
        AppUtils.showDialog('Information', data);
      }
      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
