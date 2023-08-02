// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/services/pms_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class PMSEmployeeDetailController extends GetxController{
var detailModel= PMSDetailModel.name().obs;
var showAcknowledge = true.obs;
var showApprove = false.obs;
PmsListController pmsListController;
var totalFinalRate = 0.0.obs;
var totalEmployeeRate = 0.0.obs;
var totalScoreAverage = 0.0.obs;
TextEditingController managerRateTextController;
TextEditingController empRateTextController;
PMSService pmsService;
var approve_or_not = 0.obs;
@override
  void onInit() {

    super.onInit();
    managerRateTextController = TextEditingController();
    empRateTextController = TextEditingController();
}
@override
void onReady() async {
  super.onReady();
  this.pmsService = await PMSService().init();
  pmsListController= Get.find();

}

  Future<int> checkApproveOrNote(PMSDetailModel value) async{
    this.pmsService = await PMSService().init();
    await pmsService.pmsApproveorNot(value.employeeId.id.toString(),value.state).then((value){
      print("Status#");
      print(value);
      approve_or_not.value = value;
      return value;
    });

  }
  clickAcknowledge(String pmsId) async{
    String message = await pmsService.sendAcknowledge(pmsId);
    if(message == 'Success'){
      var pmsList =  await pmsListController.getPmsList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      AppUtils.showConfirmDialog('Information', message, (){
        showAcknowledge.value = false;
        Get.back();
      });
    }else{
      AppUtils.showDialog("Information", message);
    }
  }

clickDone(String pmsId,String status) async{
  String state = detailModel.value.state;
  if(detailModel.value.keyPerformanceIds.any((element) => element.managerRate<=0))
    AppUtils.showDialog("Information", 'Please all fill Final Rating');
  else if(detailModel.value.competenciesIds.any((element) => element.score<=0))
    AppUtils.showDialog("Information", 'Please all fill Competencies Score');
  else{
    String message = '';
    message = await pmsService.pmsManagerApprove(pmsId,status);
    if(message == 'Success'){
      AppUtils.showConfirmDialog('Information', message, (){
        pmsListController.getPmsApprovalList();
        Get.back();
        Get.back();
      });
    }else{
      AppUtils.showDialog("Information", message);
    }
  }
}

clickSubmit(String pmsId) async{
  if(detailModel.value.keyPerformanceIds.any((element) => element.employeeRate<=0))
    AppUtils.showDialog("Information", 'Please all fill Employee Rating');
  else {
    String message =detailModel.value.state == 'acknowledge'? await pmsService.sendMidYearSelfAssessment(pmsId) : await pmsService.sendYearEndSelfAssessment(pmsId);
    if (message == 'Success') {
      AppUtils.showConfirmDialog('Information', message, () {
        pmsListController.getPmsList();
        showAcknowledge.value = false;
        Get.back();
        Get.back();
      });
    } else {
      AppUtils.showDialog("Information", message);
    }
  }

}
  refreshData(int index) async{
    var pmsList =await pmsListController.getPmsList();
    detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
    calculateTotalEmployeeRate();
    calculateTotalFinalRate();
  }
refreshToApproveData(int index) async{
  var pmsList =await pmsListController.getPmsApprovalList();
  detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
  calculateTotalEmployeeRate();
  calculateTotalFinalRate();
}

editEmployeeRateAndRate(int index) async{
  String message= await pmsService.editEmployeeRate(detailModel.value.keyPerformanceIds[index].id.toString(), detailModel.value.keyPerformanceIds[index].employeeRate, detailModel.value.keyPerformanceIds[index].employeeRemark);
  if(message == 'Success'){
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      calculateTotalEmployeeRate();
      calculateTotalFinalRate();
      Get.back();
      Get.back();
    });
  }else{
    AppUtils.showDialog("Information", message);
  }
}

editManagerRateAndRate(int index) async{
  print('editManagerRateAndRate');
  print(detailModel.value.keyPerformanceIds[index].managerRate.toString());
  String message= await pmsService.editManagerRate(detailModel.value.keyPerformanceIds[index].id.toString(), detailModel.value.keyPerformanceIds[index].managerRate, detailModel.value.keyPerformanceIds[index].managerRemark);
  if(message == 'Success'){
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsApprovalList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      calculateTotalEmployeeRate();
      calculateTotalFinalRate();
      Get.back();
      Get.back();
    });
  }else{
    AppUtils.showDialog("Information", message);
  }
}

editCompetenciesScore(int index) async{
  print("editCompetenciesScore");
  print(detailModel.value.competenciesIds[index].score);
  String message= await pmsService.editCompetencyScore(detailModel.value.competenciesIds[index].id.toString(), detailModel.value.competenciesIds[index].score, detailModel.value.competenciesIds[index].comment);
  if(message == 'Success'){
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsApprovalList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      calculateTotalScoreAverage();
      Get.back();
      Get.back();
    });
  }else{
    AppUtils.showDialog("Information", message);
  }
}

  calculateTotalEmployeeRate(){
  var total = 0.0;
    if(detailModel.value!=null){
      detailModel.value.keyPerformanceIds.forEach((value) {
        total += (value.weightage * value.employeeRate)/100;
      });
      totalEmployeeRate.value = total;
    }
  }
calculateTotalScoreAverage(){
  var total = 0.0;
  if(detailModel.value!=null){
  detailModel.value.competenciesIds.forEach((value) {
    total += value.score;
  });
  totalScoreAverage.value = total/ detailModel.value.competenciesIds.length;}
}
calculateTotalFinalRate(){
  var total = 0.0;
  if(detailModel.value!=null){
  detailModel.value.keyPerformanceIds.forEach((value) {
    total += (value.weightage * value.managerRate)/100;
  });
  totalFinalRate.value = total;}
}

bool allowEditEmployeeRate(){
  DateTime startDate = DateTime.parse(detailModel.value.startDate());
  DateTime endDate = DateTime.parse(detailModel.value.endDate());
  if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate) && (detailModel.value.state == 'acknowledge' || detailModel.value.state == 'mid_year_hr_approve' || detailModel.value.state == 'mid_year_self_assessment'||detailModel.value.state == 'year_end_self_assessment')){
    return true;
  }
  return false;
}
bool allowSelfEditEmployeeRate(){
  // DateTime startDate = DateTime.parse(detailModel.value.startDate());
  // DateTime endDate = DateTime.parse(detailModel.value.endDate());
  // if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate) && (detailModel.value.state == 'acknowledge' || detailModel.value.state == 'mid_year_hr_approve')){
  //   return true;
  // }
  // return false;
  if(detailModel.value.state == 'acknowledge'){
    DateTime startDate = DateTime.parse(detailModel.value.midFromDate);
    DateTime endDate = DateTime.parse(detailModel.value.midToDate);
    if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
      return true;
    }else{
      return false;
    }
  }else if(detailModel.value.state == 'mid_year_hr_approve'){ //mid_year_hr_approve //mid_year_self_assessment
    DateTime startDate = DateTime.parse(detailModel.value.endFromDate);
    DateTime endDate = DateTime.parse(detailModel.value.endToDate);
    if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
      return true;
    }else{
      return false;
    }
  }
  return false;
}
bool checkMidDate(){
  DateTime startDate = DateTime.parse(detailModel.value.midFromDate);
  DateTime endDate = DateTime.parse(detailModel.value.midToDate);
  if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    return true;
  }
  return false;
}
bool checkYearEndDate(){
  DateTime startDate = DateTime.parse(detailModel.value.endFromDate);
  DateTime endDate = DateTime.parse(detailModel.value.endToDate);
  if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    return true;
  }
  return false;
}
bool showSubmitOrNot(){
  if(detailModel.value.state=='acknowledge'){
    return checkMidDate();
  }else if(detailModel.value.state=='mid_year_hr_approve'){
    return checkYearEndDate();
  }
}

bool allowEditManagerRate(){
 String state = detailModel.value.state;
   return state == 'mid_year_self_assessment'|| state == 'year_end_self_assessment' ? allowEditManagersRate() : allowEditDottedManagerRate();
}

bool isAllowEditManagerRate(){
  bool isAllow = false;
  String state = detailModel.value.state;
  if(state == 'mid_year_self_assessment' || state == 'mid_year_manager_approve'){
    DateTime startDate = DateTime.parse(detailModel.value.midFromDate);
    DateTime endDate = DateTime.parse(detailModel.value.midToDate);
    if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
      isAllow =  true;
    }else{
      isAllow = false;
    }
  } else if(state == 'year_end_self_assessment' || state == 'year_end_manager_approve'){
    DateTime startDate = DateTime.parse(detailModel.value.endFromDate);
    DateTime endDate = DateTime.parse(detailModel.value.endToDate);
    if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
      isAllow = true;
    }else{
      isAllow = false;
    }
  }
  return isAllow;
}

bool allowEditManagersRate(){
  if(detailModel.value.startDate()!=null&&detailModel.value.endDate()!= null){
    DateTime startDate = DateTime.parse(detailModel.value.startDate());
    DateTime endDate = DateTime.parse(detailModel.value.endDate());
    if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate) && (detailModel.value.state == 'mid_year_self_assessment' || detailModel.value.state == 'year_end_self_assessment')){
      return true;
    }
  }
  return false;
}

bool allowEditDottedManagerRate(){
  DateTime startDate = DateTime.parse(detailModel.value.startDate());
  DateTime endDate = DateTime.parse(detailModel.value.endDate());
  if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate) && (detailModel.value.state == 'mid_year_manager_approve' || detailModel.value.state == 'year_end_manager_approve')){
    return true;
  }
  return false;
}

}