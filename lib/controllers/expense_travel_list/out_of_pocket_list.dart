// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/expense_attachment.dart';
import 'package:winbrother_hr_app/models/leave_list_response.dart';
import 'package:winbrother_hr_app/models/travel_expense/out_of_pocket_response.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OutofPocketList extends GetxController {
  final box = GetStorage();
  var button_submit_show = false.obs;
  var button_approve_show = false.obs;
  TravelRequestService travelRequestService;
  var outofpocketExpenseList = List<OutofPocketResponse>().obs;
  var attachment_list = List<Expense_attachment>().obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var show_attachment = false.obs;
  @override
  void onReady() async {
    super.onReady();
    this.travelRequestService = await TravelRequestService().init();
    getExpenseListForEmp();
  }

  @override
  void onInit() {
    super.onInit();
  }

  deleteOutofPocket(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService.deleteOutofPocket(id).then((data) {
      //Get.back();
      // Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
      button_approve_show.value = false;
      offset.value = 0;
      getExpenseListForEmp();
      Get.back();
      Get.back();
      Get.back();
    });
  }

  Future<void> getExpenseListForEmp() async {
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
    await travelRequestService.getOutofPocketModel(employee_id,offset.toString()).then((data) {
      print("offset");
      print(offset);
      if(offset!=0){
        isLoading.value = false;
        //outofpocketExpenseList.value.addAll(data);
        data.forEach((element) {
          outofpocketExpenseList.add(element);
        });

      }else{
        outofpocketExpenseList.value = data;
      }
      update();
      Get.back();
    });
  }

  submitRequest(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService.submitOutofPocketRequst(id).then((data) {
      Get.back();
      button_submit_show.value = data;
      AppUtils.showConfirmDialog('Information', 'Successful Submitted', (){
        offset.value = 0;
        getExpenseListForEmp();
        Get.back();
        Get.back(result: true);
      });
      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }
 double getTotalAmount(int index){
    double totalAmount = 0.0;
   outofpocketExpenseList[index].pocket_line.forEach((element) {
     totalAmount += element.price_subtotal;
   });
   return totalAmount;
 }
  @override
  void onClose() {
    super.onClose();
  }
  getAttachment(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelRequestService.getAttachment(id,"pocket").then((data) {
      Get.back();
      attachment_list.value = data;
      show_attachment.value =true;
    });
  }
}
