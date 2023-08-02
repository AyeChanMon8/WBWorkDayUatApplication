// @dart=2.9
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/document.dart';
import 'package:winbrother_hr_app/models/document_detail.dart';
import 'package:winbrother_hr_app/models/document_folder.dart';
import 'package:winbrother_hr_app/models/document_list_model.dart';
import 'package:winbrother_hr_app/services/document_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../services/employee_service.dart';
import 'package:get/get.dart';
class DoucmentController extends GetxController {
  static DoucmentController to = Get.find();
  EmployeeService employeeService;
  var docList = List<DocumentListModel>().obs;
  var doc = Document_detail().obs;
  var showDocList = false.obs;
  final box = GetStorage();
  DocumentService docService;
  @override
  void onReady() async {
    super.onReady();
    this.docService = await DocumentService().init();
    _getDocList();
  }

  @override
  void onInit() {
    super.onInit();
  }
  _getDocList() async {
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
    await docService.getDocNameList(employee_id).then((data) {
      docList.value = data;
      Get.back();
    });
  }

  Future<File> getDoc(int documentId,String type) async {
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
    await this.docService.getDocD(documentId.toString()).then((data){
      doc.value = data;
      Get.back();
    });
    return  _createFileFromString(type);
  }

  Future<File> _createFileFromString(String type) async {
    String encodedStr = doc.value.datas;
    print("displayname");
    print(doc.value.displayName);
   // return AppUtils.createPDF(encodedStr, "${doc.value.name}","${doc.value.displayName}");
    return AppUtils.createPDF(encodedStr,"${doc.value.name}",type);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
