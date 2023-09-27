// @dart=2.9
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_attach.dart';
import 'package:winbrother_hr_app/models/pms_attachment.dart';
import 'package:winbrother_hr_app/models/pms_attachments.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/models/rating_config.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
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
MasterService masterService;
final RxBool isShowAttachment = false.obs;
final RxBool isShowImageAttachment = false.obs;
final RxList<PlatformFile> imageList = List<PlatformFile>().obs;
var ratingConfig_list = List<RatingConfig>().obs;
final RxList<PMSattachment> attachment_list = List<PMSattachment>().obs;
Rx<RatingConfig> _selectedRatingConfig = RatingConfig().obs;
RatingConfig get selectedRatingConfig => _selectedRatingConfig.value;
set selectedRatingConfig(RatingConfig type) => _selectedRatingConfig.value = type;
Rx<RatingConfig> _selectedCompetenciesRatingConfig = RatingConfig().obs;
RatingConfig get selectedCompetenciesRatingConfig => _selectedCompetenciesRatingConfig.value;
set selectedCompetenciesRatingConfig(RatingConfig type) => _selectedCompetenciesRatingConfig.value = type;
List<PMSAttach> image_base64_list =[];
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
  this.masterService = await MasterService().init();
  getRatingConfig();
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

  getRatingConfig() async {
    await masterService.getRatingConfig().then((data) {
      if(data.length > 0){
        this.selectedRatingConfig = data[0];
        this.selectedCompetenciesRatingConfig = data[0];
      }
      ratingConfig_list.value = data;
      // ratingConfig_list.value = [];
      // RatingConfig config = new RatingConfig();
      // config.id = 0;
      // config.name = '-';
      // config.rating_description = '-';
      // this.selectedRatingConfig = config;
      // this.selectedCompetenciesRatingConfig = config;
      // ratingConfig_list.value.add(config);
      // for(var i=0;i<data.length;i++){
      //   ratingConfig_list.value.add(data[i]);
      // }
    });
}

void onChangeRatingConfigDropdown(RatingConfig ratingConfig) async {
    this.selectedRatingConfig = ratingConfig;
    update();
}

void onChangeRatingCompetenciesConfigDropdown(RatingConfig ratingConfig) async {
    this.selectedCompetenciesRatingConfig = ratingConfig;
    update();
}

 void setAttachmentFile() {
    isShowAttachment.value = true;
}

void selectImage(List<PlatformFile> files){
  isShowAttachment.value = true;
}

  clickAcknowledge(String pmsId) async{
     Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    String message = await pmsService.sendAcknowledge(pmsId);
    if(message == 'Success'){
      Get.back();
      var pmsList =  await pmsListController.getPmsList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      AppUtils.showConfirmDialog('Information', message, (){
        showAcknowledge.value = false;
        Get.back();
        // Get.back();
      });
    }
    // else{
    //   AppUtils.showDialog("Information", message);
    // }
  }

clickDone(String pmsId,String status) async{
  String state = detailModel.value.state;
  if(detailModel.value.keyPerformanceIds.any((element) => (element.managerRating.id==0 || element.managerRating.id==null)))
    AppUtils.showDialog("Information", 'Please all fill Manager Rating in WHAT');
  else if(detailModel.value.competenciesIds.any((element) => (element.rating.id==0 || element.rating.id==null)))
    AppUtils.showDialog("Information", 'Please all fill Manager Rating in HOW');
  else{
    String message = '';
     Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    message = await pmsService.pmsManagerApprove(pmsId,status);
    if(message == 'Success'){
      Get.back();
      AppUtils.showConfirmDialog('Information', message, (){
        pmsListController.getPmsApprovalList();
        // Get.back();
        Get.back();
        Get.back();
      });
    }
    // else{
    //   AppUtils.showDialog("Information", message);
    // }
  }
}

clickSubmit(String pmsId) async{
  if(detailModel.value.keyPerformanceIds.any((element) => (element.employeeRating.id==0 || element.employeeRating.id==null))){
    AppUtils.showDialog("Information", 'Please all fill Employee Rating in WHAT');
  }else if(detailModel.value.competenciesIds.any((element) => (element.employee_rating.id==0 || element.employee_rating.id==null))){
    AppUtils.showDialog("Information", 'Please all fill Employee Rating in HOW');
  }
  else {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    String message =detailModel.value.state == 'acknowledge'? await pmsService.sendMidYearSelfAssessment(pmsId) : await pmsService.sendYearEndSelfAssessment(pmsId);
    if (message == 'Success') {
      Get.back();
      AppUtils.showConfirmDialog('Information', message, () {
        pmsListController.getPmsList();
        showAcknowledge.value = false;
        // Get.back();
        Get.back();
        Get.back();
      });
    } 
    // else {
    //   Get.back();
    //   AppUtils.showDialog("Information", message);
    // }
  }

}
  refreshData(int index) async{
    var pmsList =await pmsListController.getPmsList();
    detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
    //calculateTotalEmployeeRate();
    //calculateTotalFinalRate();
  }
refreshToApproveData(int index) async{
  var pmsList =await pmsListController.getPmsApprovalList();
  detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
  //calculateTotalEmployeeRate();
  //calculateTotalFinalRate();
}

editEmployeeRateAndRate(int index) async{
  if(selectedRatingConfig.id==0){
    AppUtils.showDialog("Information", 'Please fill Employee Rating');
  }else{
    var pmsAttach = List<PMSAttach>();
  if(attachment_list.value.length > 0){
    for(var i=0;i<attachment_list.value.length;i++){
      pmsAttach.add(PMSAttach(name: attachment_list[i].name,attachment_file: attachment_list[i].attach_file));
    }
  }
  if(image_base64_list.length > 0){
    for(var j=0;j<image_base64_list.length;j++){
      pmsAttach.add(PMSAttach(name: image_base64_list[j].name, attachment_file: image_base64_list[j].attachment_file));
    }
  }
  Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
  String message= await pmsService.editEmployeeRate(detailModel.value.keyPerformanceIds[index].id.toString(), selectedRatingConfig.id, detailModel.value.keyPerformanceIds[index].employeeRemark,pmsAttach);
  if(message == 'Success'){
    Get.back();
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      if(ratingConfig_list.length>0){
        selectedRatingConfig = ratingConfig_list.value[0];
      }
      isShowImageAttachment.value = false;
      isShowAttachment.value = false;
      imageList.value = [];
      image_base64_list =[];
      attachment_list.value = [];
      //calculateTotalEmployeeRate();
      //calculateTotalFinalRate();
      Get.back();
      Get.back();
    });
  }
  }
  
  // else{
  //   AppUtils.showDialog("Information", message);
  // }
}

editManagerRateAndRate(int index) async{
  if(selectedRatingConfig.id==0){
    AppUtils.showDialog("Information", 'Please fill Manager Rating');
  }else{
    print('editManagerRateAndRate');
  print(detailModel.value.keyPerformanceIds[index].managerRate.toString());
  var pmsAttach = List<PMSAttach>();
  if(attachment_list.value.length > 0){
    for(var i=0;i<attachment_list.value.length;i++){
      pmsAttach.add(PMSAttach(name: attachment_list[i].name,attachment_file: attachment_list[i].attach_file));
    }
  }
  if(image_base64_list.length > 0){
    for(var j=0;j<image_base64_list.length;j++){
      pmsAttach.add(PMSAttach(name: image_base64_list[j].name, attachment_file: image_base64_list[j].attachment_file));
    }
  }
   Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
  String message= await pmsService.editManagerRate(detailModel.value.keyPerformanceIds[index].id.toString(), selectedRatingConfig.id, detailModel.value.keyPerformanceIds[index].managerRemark,pmsAttach);
  if(message == 'Success'){
    Get.back();
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsApprovalList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      if(ratingConfig_list.value.length > 0){
        selectedRatingConfig = ratingConfig_list.value[0];
      }
      isShowImageAttachment.value = false;
      isShowAttachment.value = false;
      imageList.value = [];
      image_base64_list =[];
      attachment_list.value = [];
      //calculateTotalEmployeeRate();
      //calculateTotalFinalRate();
      Get.back();
      Get.back();
    });
  }
  }
  
}

editCompetenciesScore(int index) async{
  if(selectedCompetenciesRatingConfig.id==0){
    AppUtils.showDialog("Information", 'Please fill Manager Rating');
  }else{
    print("editCompetenciesScore");
  print(detailModel.value.competenciesIds[index].score);
  String message= await pmsService.editCompetencyScore(detailModel.value.competenciesIds[index].id.toString(), selectedCompetenciesRatingConfig.id, detailModel.value.competenciesIds[index].comment);
  if(message == 'Success'){
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsApprovalList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      if(ratingConfig_list.value.length>0){
        selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
      }
      calculateTotalScoreAverage();
      Get.back();
      Get.back();
    });
  }else{
    AppUtils.showDialog("Information", message);
  }
  }
}

editEmployeeCompetenciesScore(int index) async{
  if(selectedCompetenciesRatingConfig.id==0){
    AppUtils.showDialog("Information", 'Please fill Employee Rating');
  }else{
    print("editCompetenciesScore");
  print(detailModel.value.competenciesIds[index].score);
  String message= await pmsService.editEmployeeCompetencyScore(detailModel.value.competenciesIds[index].id.toString(), selectedCompetenciesRatingConfig.id, detailModel.value.competenciesIds[index].comment);
  if(message == 'Success'){
    AppUtils.showConfirmDialog('Information', message, () async{
      var pmsList =await pmsListController.getPmsList();
      detailModel.value = pmsList.where((element) => element.id == detailModel.value.id).toList()[0];
      if(ratingConfig_list.value.length>0){
        selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
      }
      calculateTotalScoreAverage();
      Get.back();
      Get.back();
    });
  }else{
    AppUtils.showDialog("Information", message);
  }
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

getAttachment(List<PMSattachments> data) async {
  isShowImageAttachment.value = true;
  attachment_list.value = [];
  for(var i=0;i<data.length;i++){
    PMSattachment data1 =  new PMSattachment();
    data1.name =data[i].name;
    data1.attach_file = data[i].datas;
    attachment_list.value.add(data1);
  }
}

void setCameraImage(File image, String image64,String fileName) {
    image_base64_list.add(PMSAttach(name: fileName, attachment_file: image64));
  }

}