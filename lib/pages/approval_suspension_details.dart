// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../localization.dart';
import 'leave_detail.dart';

class ApprovalSuspensionDetails extends StatefulWidget {
  @override
  _ApprovalSuspensionDetailsState createState() => _ApprovalSuspensionDetailsState();
}

class _ApprovalSuspensionDetailsState extends State<ApprovalSuspensionDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image;
  int index;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    return Scaffold(
      appBar: appbar(context, labels.suspensionDetails,image),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: controller.suspensionApprovalList.value.length > 0 ? Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].name)
                    ,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.employeeName,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.suspensionApprovalList.length > 0 ?Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].employeeId.name),
                            style: subtitleStyle(),
                          ):SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Text(
                //           labels.employeeContract,
                //           // ("position"),
                //           style: datalistStyle(),
                //         ),
                //       ),
                //       Obx(
                //             () => Container(
                //           child: controller.suspensionApprovalList.value[index].employeeContract !=
                //               null
                //               ? Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].employeeContract)
                //            ,
                //             style: subtitleStyle(),
                //           )
                //               : Text('-'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.company,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Branch"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            child: controller.suspensionApprovalList.length > 0 ?Text(
                              AppUtils.removeNullString(controller.suspensionApprovalList.value[index].company_id.name),
                              style: subtitleStyle(),
                            ):SizedBox(),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Align(
                            alignment:Alignment.topRight,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left:50.0),
                                child: controller.suspensionApprovalList.length > 0 ? Text(
                                  AppUtils.removeNullString(controller.suspensionApprovalList.value[index].branch_id.name),
                                  style: subtitleStyle(),
                                ): SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Department',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].departmentId !=
                              null
                              ? Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].departmentId.name)
                            ,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Text(
                //           'Job Position',
                //           // ("position"),
                //           style: datalistStyle(),
                //         ),
                //       ),
                //       Obx(
                //             () => Container(
                //           child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].job_id !=
                //               null
                //               ? Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].job_id.name)
                //             ,
                //             style: subtitleStyle(),
                //           )
                //               : Text('-'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(
                //   thickness: 1,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Text(
                //           'Job Grade',
                //           // ("position"),
                //           style: datalistStyle(),
                //         ),
                //       ),
                //       Obx(
                //             () => Container(
                //           child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].job_grade_id !=
                //               null
                //               ? Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].job_grade_id.name)
                //             ,
                //             style: subtitleStyle(),
                //           )
                //               : Text('-'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(
                //   thickness: 1,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Job Position',
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Job Grade',
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].job_id !=
                              null
                              ? Text(
                              AppUtils.removeNullString(controller.suspensionApprovalList.value[index].job_id.name),
                              style: subtitleStyle(),
                            ): Text('-'),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Align(
                            alignment:Alignment.topRight,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left:50.0),
                                child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].job_grade_id !=
                              null
                              ? Text(
                                  AppUtils.removeNullString(controller.suspensionApprovalList.value[index].job_grade_id.name),
                                  style: subtitleStyle(),
                                ): Text('-'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Joining Date',
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Submitted Date"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: controller.suspensionApprovalList.length > 0 ?Text(
                            AppUtils.changeDateFormat(controller.suspensionApprovalList.value[index].joinedDate),
                            style: subtitleStyle(),
                          ):SizedBox(),
                        ),
                        Container(
                          child: controller.suspensionApprovalList.length > 0 ? Text(
                            AppUtils.changeDateFormat(controller.suspensionApprovalList.value[index].suspension_submit_date),
                            style: subtitleStyle(),
                          ):SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   child: Text(
                      //     'Last Day of Employee',
                      //     // ("loan_amount"),
                      //     style: datalistStyle(),
                      //   ),
                      // ),
                      Container(
                        child: Text(
                          'Approved Last Day Of Employee',
                          // ("no_of_installments"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   child: Text(
                        //     AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].expectedRevealingDate.toString()),
                        //     style: subtitleStyle(),
                        //   ),
                        // ),
                        Container(
                          child: controller.suspensionApprovalList.length > 0 ? Text(
                              AppUtils.changeDateFormat(controller.suspensionApprovalList.value[index].approvedRevealingDate.toString()),
                            style: subtitleStyle(),
                          ): SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Reason',
                            // ("position"),
                            style: datalistStyle(),
                          ),
                        ),
                      ),
                      Obx(
                            () => Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                          child: controller.suspensionApprovalList.length > 0 && controller.suspensionApprovalList.value[index].suspension_reason !=
                                  null
                                  ? Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].suspension_reason)
                                ,
                                style: subtitleStyle(),
                          ),
                                  )
                                  : Text('-'),
                        ),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Text(
                //           'Type',
                //           // ("position"),
                //           style: datalistStyle(),
                //         ),
                //       ),
                //       Obx(
                //             () => Container(
                //           child: controller.suspensionApprovalList.value[index].resignationType !=
                //               null
                //               ? Text(AppUtils.removeNullString(controller.suspensionApprovalList.value[index].resignationType)
                //             ,
                //             style: subtitleStyle(),
                //           )
                //               : Text('-'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                approveButton(context)
              ],
            ),
          ): SizedBox(),
        ),
      ),
    );
  }

  Widget approveButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller
                    .approveSuspension(controller.suspensionApprovalList.value[index].id,context);
                print("Loan approved");
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.declinedSuspension(
                    controller.suspensionApprovalList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels?.decline,
              textColor: textFieldTapColor,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
        ],
      ),
    );
  }

}
