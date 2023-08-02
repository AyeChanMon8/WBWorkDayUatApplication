// @dart=2.9
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/models/fleet_model.dart';
import 'package:winbrother_hr_app/models/maintenance_product_category_model.dart';
import 'package:winbrother_hr_app/models/maintenance_request_model.dart';
import 'package:winbrother_hr_app/services/fleet_service.dart';
import 'package:winbrother_hr_app/services/maintenance_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class MaintenanceController extends GetxController{
TextEditingController selectedDateTextController;
TextEditingController qtyTextController;
TextEditingController descriptionTextController;
TextEditingController fromDateTimeTextController;
TextEditingController toDateTimeTextController;
MaintenanceService maintenanceService;
var maintenanceList = List<Maintenance_request_model>().obs;
var maintenanceProductCategorys = List<Maintenance_product_category_model>().obs;
var maintenanceProductList = List<Product_id>().obs;
var selectedProduct = Product_id().obs;
var selectedProductCategory = Maintenance_product_category_model().obs;
var selectedProductType = 'repair'.obs;
var maintenanceProductIdList = List<Maintenance_product_ids>().obs;
var maintenanceProductIds = List<Maintenance_product_ids>();
var maintenanceProductIdLists = List<Maintenance_product_id>();
var fleetList = List<Fleet_model>().obs;
var maintenanceWarehouseIdList = List<Warehouse_ids>().obs;
var addLine = false.obs;
Rx<Fleet_model> _selectedVehicle =
    Fleet_model().obs;
Fleet_model get selectedVehicle =>
    _selectedVehicle.value;
set selectedVehicle(Fleet_model type) =>
    _selectedVehicle.value = type;
var priority = 0.0;
List<Uint8List> imageList = [];
var box = GetStorage();
var image_base64 ='';
var before_image_one_base64 ='';
var before_image_two_base64 ='';
var before_image_three_base64 ='';

var after_image_one_base64 ='';
var after_image_two_base64 ='';
var after_image_three_base64 ='';

final Rx<File> before_img_one = File('').obs;
final RxBool isShowBeforeOne = false.obs;

final Rx<File> before_img_two = File('').obs;
final RxBool isShowBeforeTwo = false.obs;

final Rx<File> before_img_three = File('').obs;
final RxBool isShowBeforeThree = false.obs;

final Rx<File> after_img_one = File('').obs;
final RxBool isShowAfterOne = false.obs;

final Rx<File> after_img_two = File('').obs;
final RxBool isShowAfterTwo = false.obs;

final Rx<File> after_img_threee = File('').obs;
final RxBool isShowAfterThree= false.obs;
 //var bytes1 = "".obs;
var current_page = 'planned'.obs;
var selectedStartDate = "";
var selectedEndDate = "";
var selectedFromDate = "".obs;
var selectedToDate = "".obs;
@override
  void onInit(){
    super.onInit();
    maintenanceProductIds.clear();
    selectedDateTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    qtyTextController = TextEditingController();
    fromDateTimeTextController = TextEditingController();
    toDateTimeTextController = TextEditingController();
  }
FleetService fleetService;
  @override
  void onReady() async{
    super.onReady();
    fleetService = await FleetService().init();
    this.maintenanceService = await MaintenanceService().init();
    getMaintenanceList('planned');
    getFleetList(box.read("emp_id"));
  }

  @override
  void dispose() {
    selectedDateTextController.dispose();
    descriptionTextController.dispose();
    qtyTextController.dispose();
    super.dispose();
  }

getMaintenanceList(String status) async {
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
  this.maintenanceService = await MaintenanceService().init();
  await maintenanceService.getMaintenanceRequestList(int.tryParse(employee_id),status).then((data) {
   maintenanceList.value = data;
    Get.back();
  });
}

void createMaintenanceRequest() async{
  var formatter = new DateFormat('yyyy-MM-dd');
  var now = new DateTime.now();
  String formattedTodayDate = formatter.format(now); //
  String from_date_time = fromDateTimeTextController.text;
  String to_date_time = toDateTimeTextController.text;
  var employee_id = box.read('emp_id');
  if(from_date_time.isEmpty||to_date_time.isEmpty){
    Get.snackbar('Warning', "Please Choose Date!", snackPosition: SnackPosition.BOTTOM);
  }if(descriptionTextController.text==null || descriptionTextController.text==''){
    Get.snackbar('Warning', "Description is required!", snackPosition: SnackPosition.BOTTOM);
  }else{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await maintenanceService.createMaintenanceRequestModel(employee_id,selectedVehicle.id,from_date_time, to_date_time,maintenanceProductIdLists,priority.toInt(),descriptionTextController.text,imageList,before_image_one_base64,before_image_two_base64,
    before_image_three_base64,after_image_one_base64,after_image_two_base64,after_image_three_base64,selectedVehicle,formattedTodayDate).then((data) {
      if(data!=null){
      Get.back();
      AppUtils.showConfirmDialog('Information', "Successfully Created!",() async {
      maintenanceList.value = data;
      Get.back();
      Get.back();
      });
    };
      // if(data!=null){
      //     maintenanceList.value = data;
      //     Get.back();
      //     Get.back();
      // }
      // else{
      //   Get.back();
      //   Get.back();
      // }
    });
  }

}

void clickReproposeButton(int id) async{
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
  await maintenanceService.submitReproposeButton(employee_id,id,current_page.value).then((data) {
    maintenanceList.value = data;
    Get.back();
    Get.back();
  });
}
void updateEndDate(int id) async{

    if(selectedEndDate!=null){
      var start_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedEndDate.toString()).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
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
      await maintenanceService.updateEndDate(employee_id,id,start_date,current_page.value).then((data) {
        maintenanceList.value = data;
        Get.back();
        Get.back();
        selectedToDate.value = selectedEndDate.toString();
      });

    }else{
       AppUtils.showToast('Choose Required Date!');
    }

}
void updateStartDate(int id) async{
    if(selectedStartDate!=null){
      var start_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedStartDate.toString()).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
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
      await maintenanceService.updateStartDate(employee_id,id,start_date,current_page.value).then((data) {
        maintenanceList.value = data;
        Get.back();
        Get.back();
        selectedFromDate.value = selectedStartDate.toString();
      });
    }else{
       AppUtils.showToast('Choose Required Date!');
    }

}
void approveMaintenance(int id) async{
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
  await maintenanceService.approveMaintenance(employee_id,id,current_page.value).then((data) {
    if(data!=null){
      Get.back();
      AppUtils.showConfirmDialog('Information', "Successfully Approved!",() async {
      maintenanceList.value = data;
      Get.back();
      Get.back();
      });
    };
  });
}
void rejectMaintenance(int id) async{
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
  await maintenanceService.rejectMaintenance(employee_id,id,current_page.value).then((data) {
     if(data!=null){
      Get.back();
      AppUtils.showConfirmDialog('Information', "Successfully Declined!",() async {
      maintenanceList.value = data;
      Get.back();
      Get.back();
      });
    };
    // maintenanceList.value = data;
    // Get.back();
    // Get.back();
  });
}
void secondApprove(int id) async{
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
  await maintenanceService.secondApproveMaintenance(employee_id,id,current_page.value).then((data) {
    if(data!=null){
      Get.back();
      AppUtils.showConfirmDialog('Information', "Successfully Approved!",() async {
       maintenanceList.value = data;
      Get.back();
      Get.back();
      });
    }
  });
}
void resubmitClick(int id) async{
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
  await maintenanceService.reSubmitButton(employee_id,id,current_page.value).then((data) {
    maintenanceList.value = data;
    Get.back();
    Get.back();
  });
}
void clickQCButton(int id) async{
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
  await maintenanceService.submitQCButton(employee_id,id,current_page.value).then((data) {
    maintenanceList.value = data;
    Get.back();
    Get.back();
  });
}
void clickStartButton(int id) async{

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
  await maintenanceService.submitStartButton(employee_id,id,current_page.value).then((data) {
    maintenanceList.value = data;
    Get.back();
    Get.back();
  });
}
getMaintenanceProductCategorys() async {
  Future.delayed(
      Duration.zero,
          () => Get.dialog(
          Center(
              child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
          barrierDismissible: false));
  var company_id = box.read('emp_company');
  //fetch emp_id from GetX Storage
  await maintenanceService.getProductCategory(int.tryParse(company_id)).then((data) {
    maintenanceProductCategorys.value = data;
     selectedProductCategory.value = null;
    //getMaintenanceProductList(this.selectedProductCategory.value.id);
    Get.back();
  });
}

getMaintenanceProductList(int id) async {

  Future.delayed(
      Duration.zero,
          () => Get.dialog(
          Center(
              child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
          barrierDismissible: false));
  //fetch company_id from GetX Storage
  var company_id = box.read('emp_company');
  await maintenanceService.getProductList(id,company_id.toString()).then((data) {
    maintenanceProductList.value = data;
    if(data.length>0){
      selectedProduct.value = data[0];
    }

    Get.back();
  });
}


void createProductLine(Maintenance_product_id maintenance_product_id,var id) async{

  await maintenanceService.createProductLine(id, maintenance_product_id,box.read('emp_id')).then((data){
    maintenanceList.value = data;
  });
}


void updateImageFile(var id,var index,String imageFile) async{

  await maintenanceService.updateImage(id,index,imageFile,box.read('emp_id')).then((data){
    maintenanceList.value = data;
  });
}

void onChangeVehicleDropdown(
    Fleet_model fleet_model) async {
  this.selectedVehicle = fleet_model;
  update();
}

void onChangeProductCategoryDropdown(
    Maintenance_product_category_model maintenance_product_category_model) async {
  this.selectedProductCategory.value = maintenance_product_category_model;
  update();
  getMaintenanceProductList(this.selectedProductCategory.value.id);
}

void onChangeProductDropdown(
    Product_id product_id) async {
  this.selectedProduct.value = product_id;
  update();
}

void onChangeProductTypeDropdown(
    String type) async {
  this.selectedProductType.value = type;
  update();
}

void updateMaintenanceProductId(int id,Maintenance_product_ids maintenance_product_id){
  this.maintenanceProductIds.add(maintenance_product_id);
  this.maintenanceProductIdLists.add(Maintenance_product_id(productId:maintenance_product_id.productId.id ,categoryId: maintenance_product_id.categoryId.id,type:maintenance_product_id.type,qty:maintenance_product_id.qty));
  maintenanceProductIdList.value = maintenanceProductIds;
  createProductLine(Maintenance_product_id(productId:maintenance_product_id.productId.id ,categoryId: maintenance_product_id.categoryId.id,type:maintenance_product_id.type,qty:maintenance_product_id.qty), id);
}

void deleteMaintenanceProductId(Maintenance_product_ids maintenance_product_id){
  this.maintenanceProductIdList.value.remove(maintenance_product_id);
  this.maintenanceProductIdLists.remove(Maintenance_product_id(productId:maintenance_product_id.productId.id ,categoryId: maintenance_product_id.categoryId.id,type:maintenance_product_id.type,qty:maintenance_product_id.qty));
  update();
  maintenanceService.deleteProductLine(maintenance_product_id.id,box.read('emp_id')).then((data){
    maintenanceList.value = data;
  });
}

void addMaintenanceProductId(Maintenance_product_ids maintenance_product_id){
    print("initialData");
    print(this.maintenanceProductIds.length);
  this.maintenanceProductIds.add(maintenance_product_id);
    print("afterData");
    print(this.maintenanceProductIds.length);
  this.maintenanceProductIdLists.add(Maintenance_product_id(productId:maintenance_product_id.productId.id ,categoryId: maintenance_product_id.categoryId.id,type:maintenance_product_id.type,qty:maintenance_product_id.qty));
  maintenanceProductIdList.value =  this.maintenanceProductIds;
  update();

}
void removeMaintenanceProductId(Maintenance_product_ids maintenance_product_id){
  this.maintenanceProductIdList.value.remove(maintenance_product_id);
  this.maintenanceProductIdLists.remove(Maintenance_product_id(productId:maintenance_product_id.productId.id ,categoryId: maintenance_product_id.categoryId.id,type:maintenance_product_id.type,qty:maintenance_product_id.qty));
  update();
}

void setCameraImage(File image, String image64,String from) {
  image_base64 = image64;
  if(from=='before_one'){
    isShowBeforeOne.value = true;
    before_img_one.value = image;
    before_image_one_base64 = image64;
  }else if(from=='before_two'){
    isShowBeforeTwo.value = true;
    before_img_two.value = image;
    before_image_two_base64 = image64;
  }
  else if(from=='before_three'){
    isShowBeforeThree.value = true;
    before_img_three.value = image;
    before_image_three_base64 = image64;
  }
  else if(from=='after_one'){
    isShowAfterOne.value = true;
    after_img_one.value = image;
    after_image_one_base64 = image64;
  }
  else if(from=='after_two'){
    isShowAfterTwo.value = true;
    after_img_two.value = image;
    after_image_two_base64 = image64;
  }
  else if(from=='after_three'){
    isShowAfterThree.value = true;
    after_img_threee.value = image;
    after_image_three_base64 = image64;
  }
}


void updateCameraImage(int id,String from,File image, String image64) async {
  image_base64 = image64;
  var index;
  if(from=='before_one'){
     index = 0;
  }else if(from=='before_two'){
    index = 1;
  }
  else if(from=='before_three'){
    index = 2;
  }
  else if(from=='after_one'){
    index = 3;
  }
  else if(from=='after_two'){
    index = 4;
  }
  else if(from=='after_three'){
    index = 5;
  }
 await maintenanceService.updateImage(id, index, image64,box.read('emp_id')).then((data){

    if(from=='before_one'){
      isShowBeforeOne.value = true;

    }else if(from=='before_two'){
      isShowBeforeTwo.value = true;
    }
    else if(from=='before_three'){
      isShowBeforeThree.value = true;
    }
    else if(from=='after_one'){
      isShowAfterOne.value = true;
    }
    else if(from=='after_two'){
      isShowAfterTwo.value = true;
    }
    else if(from=='after_three'){
      isShowAfterThree.value = true;
    }
    maintenanceList.value = data;
  });
}

getFleetList(var empId) async{
  Future.delayed(
      Duration.zero,
          () => Get.dialog(
          Center(
              child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
          barrierDismissible: false));
  fleetList.value = await fleetService.getFleetList(empId);
  if(fleetList.value.length>0){
    selectedVehicle = fleetList[0];

  }

  Get.back();
}

}