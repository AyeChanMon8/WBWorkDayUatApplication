// @dart=2.9
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/announcement.dart';
import 'package:winbrother_hr_app/models/base_route.dart';
import 'package:winbrother_hr_app/models/employee_promotion.dart';
import 'package:winbrother_hr_app/models/expense_attachment.dart';
import 'package:winbrother_hr_app/models/insurance.dart';
import 'package:winbrother_hr_app/models/insurancemodel.dart';
import 'package:winbrother_hr_app/models/loan.dart';
import 'package:winbrother_hr_app/models/overtime_request_response.dart';
import 'package:winbrother_hr_app/models/overtime_response.dart';
import 'package:winbrother_hr_app/models/remark.dart';
import 'package:winbrother_hr_app/models/resignation.dart';
import 'package:winbrother_hr_app/models/suspension.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_list_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/out_of_pocket_response.dart';
import 'package:winbrother_hr_app/models/trip_expense.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/models/attendance.dart';
import 'package:winbrother_hr_app/models/leave_list_response.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/services/attendance_service.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/overtime_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/employee_service.dart';

import 'package:get/get.dart';

import '../utils/app_utils.dart';

class ApprovalController extends GetxController {
  static ApprovalController to = Get.find();
  OvertimeService overtimeService;
  LeaveService leaveService;
  TravelRequestService travelService;
  AttendanceService attendanceService;
  EmployeeService employeeService;
  var leaveApprovalList = List<LeaveListResponse>().obs;
  var leaveApprovedList = List<LeaveListResponse>().obs;
  var travelApprovalList = List<TravelRequestListResponse>().obs;
  var routeApprovalList = List<BaseRoute>().obs;
  var travelApprovedList = List<TravelRequestListResponse>().obs;
  var routeApprovedList = List<BaseRoute>().obs;
  var loanApprovalList = List<Loan>().obs;
  var loanApprovedList = List<Loan>().obs;
  var resignationApprovalList = List<Resignation>().obs;
  var resignationApprovedList = List<Resignation>().obs;
  var employeeChangesApprovalList = List<Employee_promotion>().obs;
  var employeeChangesFirstApprovalList = List<Employee_promotion>().obs;
  var employeeChangesApprovedList = List<Employee_promotion>().obs;
  var announcementList = List<Announcement>().obs;
  var attendanceApprovalList = List<Attendance>().obs;
  var otcList = List<OvertimeResponse>().obs;
  var leave_approve_show = true.obs;
  var travel_approve_show = true.obs;
  var attendance_approve_show = true.obs;
  var outofpockeshow = false.obs;
  var route_approve_show = true.obs;
  var outofpocketExpenseToApproveList = List<OutofPocketResponse>().obs;
  var travelExpenseList = List<TravelExpenseList>().obs;
  var outofpocketExpenseApprovedList = List<OutofPocketResponse>().obs;
  var travelExpenseApprovedList = List<TravelExpenseList>().obs;
  var button_show = false;
  var suspensionApprovalList = List<Suspension>().obs;
  var leave_approval_count = 0.obs;
  var travel_approval_count =0.obs;
  var route_approval_count =0.obs;
  var loan_approval_count =0.obs;
  var resignation_approval_count =0.obs;
  var employee_changes_approval_count =0.obs;
  var out_of_pocket_approval_count = 0.obs;
  var travel_expense_approval_count =0.obs;
  var trip_expense_approval_count = 0.obs;
  var overtime_count = 0.obs;
  var warning_approval_count = 0.obs;
  var reward_approval_count = 0.obs;
  var announcement_approval_count = 0.obs;
  var tripExpenseToApproveList = List<TripExpense>().obs;
  var tripExpenseApprovedList = List<TripExpense>().obs;
  var suspened_approval_count = 0.obs;
  var suspendedApprovalList = List<Suspension>().obs;
  var suspendedApprovedList = List<Suspension>().obs;
  var insurance_approval_count = 0.obs;
  var insuranceApprovalList = List<Insurancemodel>().obs;
  var insuranceApprovedList = List<Insurancemodel>().obs;
  final box = GetStorage();
  TextEditingController remarkController;
  TravelRequestService travelRequestService;
  var isLoading = false.obs;
  var offset = 0.obs;
  var attachment_list = List<Expense_attachment>().obs;
  var show_attachment = false.obs;
  var showDetails = true.obs;

  var suspension_approval_count =0.obs;
  var suspensionApprovedList = List<Suspension>().obs;
  @override
  void onReady() async {
    super.onReady();
    this.leaveService = await LeaveService().init();
    this.travelService = await TravelRequestService().init();
    this.attendanceService = await AttendanceService().init();
    this.overtimeService = await OvertimeService().init();
    this.travelRequestService = await TravelRequestService().init();
    this.employeeService = await EmployeeService().init();
    //getApprovalInformation();
    getApprovalInformationCount();
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
      print("getAttachemnt#");
    });
  }
  getAttachmentTravel(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelRequestService.getAttachment(id,"travel").then((data) {
      Get.back();
      attachment_list.value = data;
      show_attachment.value =true;
      print("getAttachemnt#");
    });
  }
  getAttachmentTrip(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelRequestService.getAttachment(id,"trip").then((data) {
      Get.back();
      attachment_list.value = data;
      show_attachment.value =true;
      print("getAttachemnt#");
      print(data.length);
    });
  }
  getTravelExpenseToApprove() async {
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
    await travelRequestService
        .getTravelExpenseToApprove(employee_id,offset.toString())
        .then((data) {
      //print("travelExpenseList");
      if(offset!=0){
        isLoading.value = false;
        //travelExpenseList.addAll(data);
        data.forEach((element) {
          travelExpenseList.add(element);
        });
      }else{
        travelExpenseList.value = data;
      }
      update();
      Get.back();
    });
  }

  getInsuranceApprovalList() async {
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
    await employeeService.getInsuranceToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //resignationApprovalList.addAll(data);
        data.forEach((element) {
          insuranceApprovalList.add(element);
        });
      }else{
        insuranceApprovalList.value = data;
      }
      Get.back();
    });
  }

  getTravelExpenseApproved() async {
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
    await travelRequestService
        .getTravelExpenseApproved(employee_id,offset.toString())
        .then((data) {
      //print("travelExpenseList");
      if(offset!=0){
        isLoading.value = false;
        //travelExpenseApprovedList.addAll(data);
        data.forEach((element) {
          travelExpenseApprovedList.add(element);
        });
      }else{
        travelExpenseApprovedList.value = data;
      }

      update();
      Get.back();
    });
  }

  getInsuranceApproved() async {
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
    await employeeService
        .getInsuranceApproved(employee_id,offset.toString())
        .then((data) {
      //print("travelExpenseList");
      if(offset!=0){
        isLoading.value = false;
        data.forEach((element) {
          insuranceApprovedList.add(element);
        });
      }else{
        insuranceApprovedList.value = data;
      }

      update();
      Get.back();
    });
  }

  getExpenseToApprove() async {
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
    await travelRequestService
        .getOutOfPocketToApprove(employee_id,offset.toString())
        .then((data) {
            if(offset!=0){
              isLoading.value = false;
              //outofpocketExpenseToApproveList.addAll(data);
              data.forEach((element) {
                outofpocketExpenseToApproveList.add(element);
              });
            }else{
              outofpocketExpenseToApproveList.value = data;
            }
            update();
        Get.back();
    });
  }

  getExpenseApproved() async {
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
    await travelRequestService
        .getOutOfPocketApproved(employee_id,offset.toString())
        .then((data) {
      print("data in json >>"+data.toString());
      if(offset!=0){
        isLoading.value = false;
        //outofpocketExpenseApprovedList.addAll(data);
        data.forEach((element) {
          outofpocketExpenseApprovedList.add(element);
        });
      }else{
        outofpocketExpenseApprovedList.value = data;
      }
      update();
      Get.back();
    });
  }

  getOtResponse() async {
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
    var role = box.read('role_category');

    if (role == 'employee') {
      await overtimeService
          .getEmployeeOvertimeResponseList(employee_id)
          .then((data) {
        otcList.value = data;

        Get.back();
      });
    } else {
      await overtimeService
          .getManagerOvertimeResponseList(employee_id)
          .then((data) {

        otcList.value = data;

        Get.back();
      });
    }
  }

  approveOvertime(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await overtimeService.overtimeAccept(id).then((value) {
      Get.back();
      if (value == true) {
        getOtResponse();
        AppUtils.showDialog('Overtime request', 'Approve Successfull');
        Get.toNamed(Routes.APPROVAL_OVERTIME_LIST);
      }
    });
  }

  declineOvertime(int id) async {
    var remarktext = remarkController.text;
    var remark =
        Remark(remark: remarktext, remark_line: remarktext, state: "cancel");
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await overtimeService.overtimeDecline(id, remark).then((value) {
      getOtResponse();
      Get.toNamed(Routes.APPROVAL_OVERTIME_LIST);
    });
  }

  getLeaveApprovalList() async {
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
    await leaveService.getLeaveToApprove(employee_id,offset.toString()).then((value) {
      leave_approve_show.value = true;
      if(offset!=0){
          // update data and loading status
          isLoading.value = false;
          //leaveApprovalList.addAll(value);
          value.forEach((element) {
            leaveApprovalList.add(element);
          });
        }else{
          leaveApprovalList.value = value;
        }

      Get.back();
    });
  }

  getLeaveApprovedList() async {
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
    await leaveService.getLeaveApproved(employee_id,offset.toString()).then((value) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //leaveApprovedList.addAll(value);
        value.forEach((element) {
          leaveApprovedList.add(element);
        });
      }else{
        leaveApprovedList.value = value;
      }
      Get.back();
    });
  }
  void startTimer() {

  }
  approvelLeave(int id) async {
    bool finish_loading = false;
    var change_spinner = false.obs;
    const oneSec = const Duration(seconds: 3);
    new Timer.periodic(
      oneSec,
          (Timer timer) {
          if(!finish_loading){
            if(change_spinner.value){
              change_spinner.value = false;
            }else{
              change_spinner.value = true;
            }

          }
      },
    );
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Obx(()=>  Center(
                child: change_spinner.value?SpinKitWanderingCubes(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                ):SpinKitFoldingCube(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),),
            barrierDismissible: false));

    await leaveService.approveLeave(id).then((data) {
      finish_loading = true;
      if(data==true){
        Get.back();
         AppUtils.showConfirmDialog('Information', "Approved!",() async {
        var employee_id = box.read('emp_id');
        leave_approval_count.value = await leaveService.getLeaveToApproveCount(employee_id);
        offset.value = 0;
        getLeaveApprovalList();
        getLeaveApprovedList();
        Get.back();
        Get.back();
      });
        // getLeaveApprovalList();
        // getLeaveApprovedList();
        // //print(data);
        // //leave_approve_show.value = false;
        // AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        //   var employee_id = box.read('emp_id');
        //   leave_approval_count.value = await leaveService.getLeaveToApproveCount(employee_id);
        //   Get.back();
        //   Get.back();
        // });
      }

    });
  }

  approveTravelExpense(int id) async {
    bool finish_loading = false;
    var change_spinner = false.obs;
    const oneSec = const Duration(seconds: 3);
    new Timer.periodic(
      oneSec,
          (Timer timer) {
        if(!finish_loading){
          if(change_spinner.value){
            change_spinner.value = false;
          }else{
            change_spinner.value = true;
          }

        }
      },
    );
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Obx(()=>  Center(
                child: change_spinner.value?SpinKitWanderingCubes(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                ):SpinKitFoldingCube(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),),
            barrierDismissible: false));
    await travelRequestService.approvalTravelExpenseApproval(id).then((data) {
      finish_loading = true;
      Get.back();
      AppUtils.showConfirmDialog('Information', "Approved!",() async {
        var employee_id = box.read('emp_id');
        travel_expense_approval_count.value = await travelRequestService.getTravelExpenseToApproveCount(employee_id);
        offset.value = 0;
        getTravelExpenseToApprove();
        getTravelExpenseApproved();
        Get.back();
        Get.back();
      });
    });
  }

  declineTravelExpense(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService.declineTravelExpenseApproval(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "The request is Send Back!",() async {
        var employee_id = box.read('emp_id');
        travel_expense_approval_count.value = await travelRequestService.getTravelExpenseToApproveCount(employee_id);
        offset.value = 0;
        getTravelExpenseToApprove();
        getTravelExpenseApproved();
        Get.back();
        Get.back();
      });
    });
  }

  approveOutofPocket(int id) async {
    bool finish_loading = false;
    var change_spinner = false.obs;
    const oneSec = const Duration(seconds: 3);
    new Timer.periodic(
      oneSec,
          (Timer timer) {
        if(!finish_loading){
          if(change_spinner.value){
            change_spinner.value = false;
          }else{
            change_spinner.value = true;
          }

        }
      },
    );
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Obx(()=>  Center(
                child: change_spinner.value?SpinKitWanderingCubes(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                ):SpinKitFoldingCube(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await travelRequestService.approvalOutofPocketApproval(id).then((data) {
      finish_loading = true;
      Get.back();
      AppUtils.showConfirmDialog('Information', "Approved!",(){
        Get.back();
        Get.back();
        offset.value = 0;
        getExpenseToApprove();
        getExpenseApproved();
        travelRequestService.getOutOfPocketToApproveCount(employee_id).then((value) {
           out_of_pocket_approval_count.value = value;
        });
      });
    });
  }
  approveTripExpense(int id) async {
    bool finish_loading = false;
    var change_spinner = false.obs;
    const oneSec = const Duration(seconds: 3);
    new Timer.periodic(
      oneSec,
          (Timer timer) {
        if(!finish_loading){
          if(change_spinner.value){
            change_spinner.value = false;
          }else{
            change_spinner.value = true;
          }

        }
      },
    );
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Obx(()=>  Center(
                child: change_spinner.value?SpinKitWanderingCubes(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                ):SpinKitFoldingCube(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),),
            barrierDismissible: false));
    await travelRequestService.approvalTripExpenseApproval(id).then((data) {
      finish_loading = true;
      Get.back();
      AppUtils.showConfirmDialog('Information', "Approved!",() async {
        var employee_id = box.read('emp_id');
        trip_expense_approval_count.value = await travelRequestService.getTripExpenseToApproveCount(employee_id);
        Get.back();
        Get.back();
        offset.value = 0;
        getTripExpenseToApprove();
        getTripExpenseApproved();
      });
    });
  }
  approveAnnouncement(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService.approvalAnnouncementClick(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "Approved!",() async {
        var employee_id = box.read('emp_id');
        announcement_approval_count.value = await employeeService.getAnnouncementToApproveCount(employee_id);
        offset.value = 0;
        Get.back();
        Get.back();
        getAnnouncementsList();
      });
    });
  }
  approveInsurance(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService.approvalInsuranceClick(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "Approved!",() async {
        var employee_id = box.read('emp_id');
        insurance_approval_count.value = await employeeService.getInsuranceToApproveCount(employee_id);
        offset.value = 0;
        Get.back();
        Get.back();
        getInsuranceApprovalList();
      });
    });
  }
  rejectAnnouncement(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService.rejectAnnouncementClick(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "Rejected!",() async {
        var employee_id = box.read('emp_id');
        announcement_approval_count.value = await employeeService.getAnnouncementToApproveCount(employee_id);
        offset.value = 0;
        Get.back();
        Get.back();
        getAnnouncementsList();
      });
    });
  }

  rejectInsurance(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService.rejectInsuranceClick(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "Rejected!",() async {
        var employee_id = box.read('emp_id');
        announcement_approval_count.value = await employeeService.getInsuranceToApproveCount(employee_id);
        offset.value = 0;
        Get.back();
        Get.back();
        getInsuranceApprovalList()();
      });
    });
  }

  declineOutofPocket(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService.declineOutofPocketApproval(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "The request is send back!",(){
        var employee_id = box.read('emp_id');
        travelRequestService.getOutOfPocketToApproveCount(employee_id).then((value) {
          out_of_pocket_approval_count.value = value;
        });
        offset.value = 0;
        getExpenseToApprove();
        getExpenseApproved();
        Get.back();
        Get.back();
      });
    });
  }

  declineTripExpense(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelRequestService.declineTripExpenseApproval(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', "The request is send back!",(){
        offset.value = 0;
        getTripExpenseToApprove();
        Get.back();
        Get.back();
      });
    });
  }

  declinedLeave(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await leaveService.cancelLeave(id).then((data) {
      if(data){
      leave_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        leave_approval_count.value = await leaveService.getLeaveToApproveCount(employee_id);
        offset.value = 0;
        getLeaveApprovalList();
        getLeaveApprovedList();
        Get.back();
        Get.back();
        Get.back();
      });
      }
      
    });
  }

  getTravelApprovalList() async {
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
    print('getTravelRequestToApprove#');
    await travelService.getTravelRequestToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //travelApprovalList.addAll(data);
        data.forEach((element) {
          travelApprovalList.add(element);
        });
      }else{
        travelApprovalList.value = data;
      }
      Get.back();
    });
  }
  getLoanApprovalList() async {
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
    await travelService.getLoanToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //loanApprovalList.addAll(data);
        data.forEach((element) {
          loanApprovalList.add(element);
        });
      }else{
        loanApprovalList.value = data;
      }
      Get.back();
    });
  }
  getLoanApprovedList() async {
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
    await travelService.getLoanApproved(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //loanApprovedList.addAll(data);
        data.forEach((element) {
          loanApprovedList.add(element);
        });
      }else{
        loanApprovedList.value = data;
      }
      Get.back();
    });
  }
  getResignationApprovalList() async {
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
    await travelService.getResignationToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //resignationApprovalList.addAll(data);
        data.forEach((element) {
          resignationApprovalList.add(element);
        });
      }else{
        resignationApprovalList.value = data;
      }
      Get.back();
    });
  }
  getResignationApprovedList() async {
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
    await travelService.getResignationApproved(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //resignationApprovedList.addAll(data);
        data.forEach((element) {
          resignationApprovedList.add(element);
        });
      }else{
        resignationApprovedList.value = data;
      }
      Get.back();
    });
  }
  getSuspensionApprovedList() async {
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
    await travelService.getSuspensionApproved(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //resignationApprovedList.addAll(data);
        data.forEach((element) {
          suspensionApprovedList.add(element);
        });
      }else{
        suspensionApprovedList.value = data;
      }
      Get.back();
    });
  }
  getEmployeeChangesFirstApprovalList() async {
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
    await travelService.getEmployeeChangesFirstToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        // employeeChangesApprovalList.addAll(data);
        data.forEach((element) {
          employeeChangesFirstApprovalList.add(element);
        });
      }else{
        employeeChangesFirstApprovalList.value = data;
      }
      Get.back();
    });
  }
  getEmployeeChangesApprovalList() async {
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
    await travelService.getEmployeeChangesToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
       // employeeChangesApprovalList.addAll(data);
        data.forEach((element) {
          employeeChangesApprovalList.add(element);
        });
      }else{
        employeeChangesApprovalList.value = data;
      }
      Get.back();
    });
  }
  getEmployeeChangesApprovedList() async {
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
    await travelService.getEmployeeChangesApproved(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //employeeChangesApprovedList.addAll(data);
        if(data.length > 0){
        data.forEach((element) {
          employeeChangesApprovedList.add(element);
        });
        }
       
      }else{
        if(data.length > 0){
          employeeChangesApprovedList.value = data;
          employeeChangesApprovedList.value.reversed;
        }
      }
      Get.back();
    });
  }
  getRouteApprovalList() async {
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
    await travelService.getRoutesToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //routeApprovalList.addAll(data);
        data.forEach((element) {
          routeApprovalList.add(element);
        });
      }else{
        routeApprovalList.value = data;
      }
      Get.back();
    });
  }
  getTravelApprovedList() async {
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
    await travelService.getTravelRequestApproved(employee_id).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //travelApprovedList.addAll(data);
        data.forEach((element) {
          travelApprovedList.add(element);
        });
      }else{
        travelApprovedList.value = data;
      }

      Get.back();
    });
  }
  getRouteApprovedList() async {
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
    await travelService.getRoutesApproved(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        //routeApprovedList.addAll(data);
        data.forEach((element) {
          routeApprovedList.add(element);
        });
      }else{
        routeApprovedList.value = data;
      }

      Get.back();
    });
  }
  approveTravel(int id) async {
    bool finish_loading = false;
    var change_spinner = false.obs;
    const oneSec = const Duration(seconds: 3);
    new Timer.periodic(
      oneSec,
          (Timer timer) {
        if(!finish_loading){
          if(change_spinner.value){
            change_spinner.value = false;
          }else{
            change_spinner.value = true;
          }

        }
      },
    );
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Obx(()=>  Center(
                child: change_spinner.value?SpinKitWanderingCubes(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                ):SpinKitFoldingCube(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await travelService.approveTravel(id).then((data) {
      if(data){
      finish_loading = true;
      Get.back();
      AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        travel_approval_count.value = await travelService.getTravelRequestToApproveCount(employee_id);
        offset.value = 0;
        getTravelApprovalList();
        getTravelApprovedList();
        Get.back();
        Get.back();
      });
      }
      
    });
  }

  declinedTravel(int id) async {
    await travelService.cancelTravel(id).then((data) async {
      var employee_id = box.read('emp_id');
      travel_approval_count.value = await travelService.getTravelRequestToApproveCount(employee_id);
      travel_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',(){
        offset.value = 0;
        getTravelApprovalList();
        getTravelApprovedList();
        Get.back();
        Get.back();
      });
    });
  }
  approveRoute(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.approveRoute(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        var employee_id = box.read('emp_id');
        route_approval_count.value =  await travelRequestService.getRouteToApproveCount(employee_id);
        offset.value = 0;
        getRouteApprovalList();
        getRouteApprovedList();
        Get.back();
        Get.back();
      });
    });
  }

  declinedRoute(int id) async {
    await travelService.cancelRoute(id).then((data) {
      route_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        route_approval_count.value =  await travelRequestService.getRouteToApproveCount(employee_id);
        offset.value = 0;
        getRouteApprovalList();
        getRouteApprovalList();
        Get.back();
        Get.back();
      });
    });
  }

  approveLoan(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.approveLoan(id).then((data) {
      if(data){
      Get.back();
      AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        Get.back();
        Get.back();
        var employee_id = box.read('emp_id');
        loan_approval_count.value =  await travelRequestService.getLoanToApproveCount(employee_id);
        offset.value = 0;
        getLoanApprovalList();
        //getLoanApprovedList();
       });
      }
    });
  }

  declinedLoan(int id) async {
    await travelService.declineLoan(id).then((data) {
      route_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        loan_approval_count.value =  await travelRequestService.getLoanToApproveCount(employee_id);
        offset.value = 0;
        getLoanApprovalList();
        getLoanApprovedList();
        Get.back();
        Get.back();
      });
    });
  }
  firstApproveEmployeeChange(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.fistAapproveEmployeeChange(id).then((data) {
      
      if(data){
      Get.back();
AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        var employee_id = box.read('emp_id');
        employee_changes_approval_count.value =  await travelRequestService.getEmployeeChangesToApproveCount(employee_id);
        offset.value = 0;
        getEmployeeChangesFirstApprovalList();
        getEmployeeChangesApprovalList();
        getEmployeeChangesApprovedList();
        Get.back();
        Get.back();
      });
      }
      
    });
  }
  approveEmployeeChange(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.approveEmployeeChange(id).then((data) {
      if(data){
      Get.back();
      AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        var employee_id = box.read('emp_id');
        employee_changes_approval_count.value =  await travelRequestService.getEmployeeChangesToApproveCount(employee_id);
        offset.value = 0;
        getEmployeeChangesApprovalList();
        getEmployeeChangesApprovedList();
        Get.back();
        Get.back();
      });
      }
    });
  }

  declinedEmployeeChange(int id) async {
    await travelService.declineEmployeeChange(id).then((data) {

      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        employee_changes_approval_count.value =  await travelRequestService.getEmployeeChangesToApproveCount(employee_id);
        offset.value = 0;
        getEmployeeChangesApprovalList();
        getEmployeeChangesApprovedList();
        Get.back();
        Get.back();
      });
    });
  }

  approveResign(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.approveResign(id).then((data) {
      Get.back();
      AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        var employee_id = box.read('emp_id');
        resignation_approval_count.value =  await travelRequestService.getResignationToApproveCount(employee_id);
        offset.value = 0;
        getResignationApprovalList();
        getResignationApprovedList();
        Get.back();
        Get.back();
      });
    });
  }

  approveSuspension(int id,BuildContext context) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelService.approveSuspension(id,context).then((data) async{
      if(data == 1){
         showConfirmSuspensionDialogApprove('Information', 'The employee to be suspended has a related user. Are you sure that you want to proceed?',id,context);
        // await travelService.confirmSuspension(id).then((susData) {
        //   if(susData){
        //      Get.back();
        //       AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        //         var employee_id = box.read('emp_id');
        //         suspension_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
        //         offset.value = 0;
        //         getSuspensionApprovalList();
        //         getSuspensionApprovedList();
        //         Get.back();
        //         Get.back();
        //       });
        //   }
        // });
      }else if(data == 2){
        determine_compute_payslip(context,id);
        // await travelService.confirmSuspension(id).then((susData) {
        //   if(susData){
        //      Get.back();
        //       AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        //         var employee_id = box.read('emp_id');
        //         suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
        //         offset.value = 0;
        //         getSuspensionApprovalList();
        //         getSuspensionApprovedList();
        //         Get.back();
        //         Get.back();
        //       });
        //   }
        // });
      }
     
    });
  }

  void showConfirmSuspensionDialogApprove(
    String title,
    String msg,
    int id,
    BuildContext context
  ) {
    final box = GetStorage();
    int status = 0;
    Get.defaultDialog(
      barrierDismissible: false,
      content: Text(msg),
       actions: [
          FlatButton(
          child: Text('Yes', style: TextStyle(color: Colors.red)),
          onPressed: () async{
            Navigator.of(context).pop();
            determine_compute_payslip(context,id);
        //     await travelService.confirmSuspension(id).then((susData) {
        //   if(susData){
        //     Get.back();
        //      Get.back();
        //       AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
        //         var employee_id = box.read('emp_id');
        //         suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
        //         offset.value = 0;
        //         getSuspensionApprovalList();
        //         getSuspensionApprovedList();
        //         Get.back();
        //         Get.back();
        //       });
        //   }
        // });
          },
          ),
           FlatButton(
          child: Text('No', style: TextStyle(color: Colors.red)),
          onPressed: () {
           Get.back();
           Navigator.of(context).pop();
          },
          ),
    ],
    );
  }

  void determine_compute_payslip(
    BuildContext context,
    int id
  ) {
    final box = GetStorage();
    int status = 0;
    Get.defaultDialog(
      barrierDismissible: false,
      content: Text("Do you want to compute pay for this employee during suspension?"),
       actions: [
          FlatButton(
          child: Text('Yes', style: TextStyle(color: Colors.red)),
          onPressed: () async{
            await travelService.confirmSuspension(id,true).then((susData) {
          if(susData){
            Get.back();
             Get.back();
              AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
                Get.back();
                Get.back();
                var employee_id = box.read('emp_id');
                suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
                offset.value = 0;
                getSuspensionApprovalList();
                getSuspensionApprovedList();
              });
          }
        });
          },
          ),
           FlatButton(
          child: Text('No', style: TextStyle(color: Colors.red)),
          onPressed: () async{
           await travelService.confirmSuspension(id,false).then((susData) {
          if(susData){
            Get.back();
             Get.back();
              AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
                var employee_id = box.read('emp_id');
                suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
                offset.value = 0;
                getSuspensionApprovalList();
                getSuspensionApprovedList();
                Get.back();
                Get.back();
              });
          }
        });
          },
          ),
    ],
    );
  }

  declinedResignation(int id) async {
    await travelService.declineResigantion(id).then((data) {
      if(data){
route_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        resignation_approval_count.value =  await travelRequestService.getResignationToApproveCount(employee_id);
        offset.value = 0;
        getResignationApprovalList();
        getResignationApprovedList();
        Get.back();
        Get.back();
      });
      }
    });
  }
   declinedSuspension(int id) async {
    await travelService.declineSuspension(id).then((data) {
      route_approve_show.value = false;
      AppUtils.showConfirmDialog('Information', 'Successfully Declined!',() async {
        var employee_id = box.read('emp_id');
        suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
        offset.value = 0;
        getSuspensionApprovalList();
        getSuspensionApprovedList();
        Get.back();
        Get.back();
      });
    });
  }
  Future<String> getTravelExpenseImage(int id) async {
    return await travelService.getTravelExpenseImage(id);
  }
  Future<List<String>> findExpenseImage(int id) async {

    var attachmentList = List<String>();
    for (var element in attachment_list) {
      if(id==element.expenseLineId){
        attachmentList = element.attachments;
        break;
      }

    }
    return await attachmentList;
  }
  Future<bool> attach_exist(int id,int parentInd,int index) async {
    var exist= false;
    for (var element in attachment_list) {
      if(id==element.expenseLineId){
        print("same??");
        exist = true;
        show_attachment.value = true;
        // outofpocketExpenseToApproveList.value[parentInd]
        //     .pocket_line[index].attachment_include = true;
        break;
      }else{
        exist = false;
        show_attachment.value = false;
        outofpocketExpenseToApproveList.value[parentInd]
            .pocket_line[index].attachment_include = false;
      }

    }
    return await exist;
  }
  getAttendanceApprovalList() async {
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
    await attendanceService
        .getAttendanceRequestToApprove(employee_id,offset.toString())
        .then((data) {
      attendanceApprovalList.value = data;
      Get.back();
    });
  }

  Future<void> attendanceApprove(int index) async {
    await attendanceService
        .approveAttendance(attendanceApprovalList[index].id)
        .then((data) {
      Get.back();
      getAttendanceApprovalList();
      AppUtils.showDialog('Information', 'Successfully Approved!');
      // updateCheck(index, false, state);
      // attendanceApprovalList.elementAt(index).check = true;
      // attendanceApprovalList.refresh();
      // attendanceApprovalList[index].check = false;
      // attendanceApprovalList[index].state = 'approve';
      // update();
    });
  }

  getApprovalInformationCount() async{
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
     leave_approval_count.value = await leaveService.getLeaveToApproveCount(employee_id);
     travel_approval_count.value = await travelService.getTravelRequestToApproveCount(employee_id);
     out_of_pocket_approval_count.value = await travelRequestService.getOutOfPocketToApproveCount(employee_id);
     travel_expense_approval_count.value = await travelRequestService.getTravelExpenseToApproveCount(employee_id);
     warning_approval_count.value = await employeeService.getWarningToApproveCount(employee_id);
    reward_approval_count.value = await employeeService.getRewardsToApproveCount(employee_id);
    announcement_approval_count.value = await employeeService.getAnnouncementToApproveCount(employee_id);
    trip_expense_approval_count.value = await travelRequestService.getTripExpenseToApproveCount(employee_id);
    route_approval_count.value =  await travelRequestService.getRouteToApproveCount(employee_id);
    loan_approval_count.value =  await travelRequestService.getLoanToApproveCount(employee_id);
    resignation_approval_count.value =  await travelRequestService.getResignationToApproveCount(employee_id);
    employee_changes_approval_count.value =  await travelRequestService.getEmployeeChangesToApproveCount(employee_id);
    suspened_approval_count.value =  await travelRequestService.getSuspensionToApproveCount(employee_id);
    insurance_approval_count.value = await employeeService.getInsuranceToApproveCount(employee_id);
    var role = box.read('role_category');
    if (role == 'employee') {
      overtime_count.value = await overtimeService.getEmployeeOverTimeResponseCount(employee_id);
    }
    Get.back();
  }
 Future<void> getAnnouncementsList() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: true));
    var employee_id = box.read('emp_id');
    // fetch emp_id from GetX Storage
    await employeeService
        .getApprovalAnnouncement(employee_id,offset.toString())
        .then((data) {
      if(offset!=0){
        isLoading.value = false;
        //announcementList.value.addAll(data.reversed.toList());
        data.forEach((element) {
          announcementList.add(element);
        });
      }else{
        announcementList.value = data.reversed.toList();
      }
      update();
      Get.back();
    });
  }

 Future<void> getApprovedAnnouncementsList() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: true));
    var employee_id = box.read('emp_id');
    // fetch emp_id from GetX Storage
    await employeeService
        .getApprovedAnnouncement(employee_id,offset.toString())
        .then((data) {
      if(offset!=0){
        isLoading.value = false;
        //announcementList.value.addAll(data.reversed.toList());
        data.forEach((element) {
          announcementList.add(element);
        });
      }else{
        announcementList.value = data.reversed.toList();
      }
      update();
      Get.back();
    });
  }

 Future<void> getApprovalInformation()async{
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
    await leaveService.getLeaveToApprove(employee_id,0.toString()).then((value) {
      leaveApprovalList.value = value;
    });
    await leaveService.getLeaveApproved(employee_id,0.toString()).then((value) {
      leaveApprovedList.value = value;
    });
    await travelService.getTravelRequestToApprove(employee_id,0.toString()).then((data) {
      travelApprovalList.value = data;
    });
    await travelService.getTravelRequestApproved(employee_id).then((data) {
      travelApprovedList.value = data;
    });
    var role = box.read('role_category');
    if (role == 'employee') {
      await overtimeService
          .getEmployeeOvertimeResponseList(employee_id)
          .then((data) {
        print(role);
        otcList.value = data;
      });
    } else {
      await overtimeService
          .getManagerOvertimeResponseList(employee_id)
          .then((data) {
        print(role);
        otcList.value = data;
      });
    }
    await travelRequestService
        .getOutOfPocketToApprove(employee_id,offset.toString())
        .then((data) {
      outofpocketExpenseToApproveList.value = data;
      update();
    });
    await travelRequestService
        .getOutOfPocketApproved(employee_id,offset.toString())
        .then((data) {
      outofpocketExpenseApprovedList.value = data;
      update();
    });
    await travelRequestService
        .getTravelExpenseToApprove(employee_id,0.toString())
        .then((data) {
      //print("travelExpenseList");
      travelExpenseList.value = data;
      update();
    });
    await travelRequestService
        .getTravelExpenseApproved(employee_id,0.toString())
        .then((data) {
      //print("travelExpenseList");
      travelExpenseApprovedList.value = data;
      update();
      Get.back();
    });
  }

  double getTotalAmount(int index){
    double totalAmount = 0.0;
      travelApprovalList[index].request_allowance_lines.forEach((element) {
        totalAmount +=element.total_amount;
      });
      return totalAmount;
  }

  double getTotalOutOfPocketAmount(int index){
    double totalAmount = 0.0;
    outofpocketExpenseToApproveList[index].pocket_line.forEach((element) {
      totalAmount +=element.price_subtotal;
    });
    return totalAmount;
  }
  double getTotalTripExpenseAmount(int index){
    double totalAmount = 0.0;
    tripExpenseToApproveList[index].trip_expense_lines.forEach((element) {
      totalAmount +=element.price_subtotal;
    });
    return totalAmount;
  }

  double getTotalpocketExpenseApprovedAmount(int index){
    double totalAmount = 0.0;
    outofpocketExpenseApprovedList[index].pocket_line.forEach((element) {
      totalAmount +=element.price_subtotal;
    });
    return totalAmount;
  }
  double getTotaltripExpenseApprovedAmount(int index){
    double totalAmount = 0.0;
    tripExpenseApprovedList[index].trip_expense_lines.forEach((element) {
      totalAmount +=element.price_subtotal;
    });
    return totalAmount;
  }
  double getTotalExpenseTravelAdvanceAmount(int index){
    return travelExpenseList[index].advanced_money;
  }

  double getTotalExpenseTravelAmount(int index){
    return travelExpenseList[index].total_expense;
  }

  double getTotalRemainingAmount(int index){
    return travelExpenseList[index].advanced_money-travelExpenseList[index].total_expense;
  }


  @override
  void onClose() {
    super.onClose();
    offset.value =  0;
    super.dispose();
  }
  getTripExpenseToApprove() async {
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
    await travelRequestService
        .getTripExpenseToApprove(employee_id,offset.toString())
        .then((data) {

      if(offset!=0){
        print('offsetNotZero');
        print(data.length);
        isLoading.value = false;
        //tripExpenseToApproveList.addAll(data);
        data.forEach((element) {
          tripExpenseToApproveList.add(element);
        });
      }else{
        tripExpenseToApproveList.value = data;
      }
      update();
      Get.back();
    });
  }

  getTripExpenseApproved() async {
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
    await travelRequestService
        .getTripExpenseApproved(employee_id,offset.toString())
        .then((data) {
      if(offset!=0){
        isLoading.value = false;
        //tripExpenseApprovedList.addAll(data);
        data.forEach((element) {
          tripExpenseApprovedList.add(element);
        });
      }else{
        tripExpenseApprovedList.value = data;
      }
      update();
      Get.back();
    });
  }

  getSuspensionApprovalList() async {
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
    await travelService.getSuspensionToApprove(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        isLoading.value = false;
        data.forEach((element) {
          suspensionApprovalList.add(element);
        });
      }else{
        suspensionApprovalList.value = data;
      }
      Get.back();
    });
  }

}
