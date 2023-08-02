// @dart=2.9
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/purchase_order_approval_response.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/services/purchase_order_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class PurchaseOrderController extends GetxController {
  final box = GetStorage();
  PurchaseOrderService purchaseOrderService;
  var purchaseOrderApprovalList = List<PurchaseOrderApprovalResponse>().obs;
  var button_approve_show = false.obs;
  @override
  void onReady() async {
    super.onReady();
    this.purchaseOrderService = await PurchaseOrderService().init();
    _purchaseOrderList();
  }

  @override
  void onInit() {
    super.onInit();
  }
  _purchaseOrderList() async {
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
    await purchaseOrderService.getEmployeePurchaseOrderList(employee_id).then((data) {
      purchaseOrderApprovalList.value = data;
      Get.back();
    });
  }

  approvePurchaseOrder(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await purchaseOrderService.approvePurchaseOrder(id,employee_id).then((data) {
      Get.back();
      if(data){
        AppUtils.showConfirmDialog('Information', 'Successfully Approved!',(){
        _purchaseOrderList();
        Get.back();
        Get.back();
      });
      }
      
      
    });
  }

  declinedPurchaseOrder(int id, String reason) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await purchaseOrderService.cancelPurchaseOrder(id, reason.toString()).then((data) {
      Get.back();
      if(data){
        AppUtils.showConfirmDialog('Information', 'Successfully Declined!',(){
        _purchaseOrderList();
        Get.back();
        Get.back();
      });
  }
  });
  }
}
