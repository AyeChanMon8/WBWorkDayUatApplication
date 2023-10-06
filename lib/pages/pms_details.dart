// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/models/rating_config.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/leave_detail.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/ui/components/textbox.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:winbrother_hr_app/utils/pdf_file_utils.dart';

class PmsDetails extends StatefulWidget {
  @override
  _PmsDetailsState createState() => _PmsDetailsState();
}

class _PmsDetailsState extends State<PmsDetails>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController remarkTextController = TextEditingController();
  PMSEmployeeDetailController controller =
      Get.put(PMSEmployeeDetailController());
  double ratingValue = 0;
  String img64;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    controller.detailModel.value = Get.arguments;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    //PMSDetailModel pmsDetailModel = Get.arguments;
    // controller.detailModel.value = Get.arguments;
    //controller.calculateTotalEmployeeRate();
    //controller.calculateTotalFinalRate();
    final box = GetStorage();
    controller.detailModel.value.state == 'sent_to_employee' ||
            controller.detailModel.value.state == 'acknowledge' ||
            controller.detailModel.value.state == 'mid_year_hr_approve'
        ? controller.showAcknowledge.value = true
        : controller.showApprove.value = true;
    String user_image = box.read('emp_image');
    var start_date =
        AppUtils.changeDateFormat(controller.detailModel.value.startDate());
    var end_date =
        AppUtils.changeDateFormat(controller.detailModel.value.endDate());
    // var deadline_date =
    //     AppUtils.changeDateFormat(controller.detailModel.value.deadline);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(context, "PMS Details", user_image),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.refreshData(controller.detailModel.value.id);
                },
                text: "Refresh",
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
                type: GFButtonType.outline,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Text(
              (controller.detailModel.value.name),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(58, 47, 112, 1)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (("Period")),
                      style: pmstitleStyle(),
                    ),
                    Text(
                      (controller.detailModel.value.dateRangeId.name),
                      style: pmstitleStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (("Position")),
                      style: pmstitleStyle(),
                    ),
                    Text(
                      (AppUtils.removeNullString(
                          controller.detailModel.value.job_id.name)),
                      style: pmstitleStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (("Strat date")),
                      style: pmstitleStyle(),
                    ),
                    Text(
                      ('${AppUtils.changeDateFormat(controller.detailModel.value.dateStart)}'),
                      style: pmstitleStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (("End date")),
                      style: pmstitleStyle(),
                    ),
                    Text(
                      ('${AppUtils.changeDateFormat(controller.detailModel.value.dateEnd)}'),
                      style: pmstitleStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       (("Deadline")),
                //       style: pmstitleStyle(),
                //     ),
                //     Text(
                //       (deadline_date),
                //       style: pmstitleStyle(),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                color: backgroundIconColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'THE WHAT:',
                ),
                Tab(
                  text: 'THE HOW:',
                ),
                Tab(
                  text: 'Final Evaluation',
                ),
                // Tab(
                //   text: 'Attachment',
                // ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Goal',
                                style: TextStyle(color: backgroundIconColor),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Employee Self-Assessment',
                                style: TextStyle(color: backgroundIconColor),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Manager Rating',
                                style: TextStyle(color: backgroundIconColor),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: backgroundIconColor,
                      ),
                    ),
                    Expanded(
                        child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .detailModel.value.keyPerformanceIds.length,
                          itemBuilder: (context, index) {
                            Key_performance_ids keyPerformance = controller
                                .detailModel.value.keyPerformanceIds[index];
                            return InkWell(
                              onTap: () {
                                if (keyPerformance.attachmentIds != null &&
                                    keyPerformance.attachmentIds.length > 0) {
                                  controller.getAttachment(
                                      keyPerformance.attachmentIds);
                                }
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => ListView(
                                          children: [
                                            Container(
                                              color: Color(0xff757575),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: IconButton(
                                                        icon: Icon(Icons
                                                            .close_outlined),
                                                        onPressed: () {
                                                          controller
                                                              .isShowAttachment
                                                              .value = false;
                                                          controller
                                                              .attachment_list
                                                              .value = [];
                                                          controller
                                                              .isShowImageAttachment
                                                              .value = false;
                                                          controller
                                                              .image_base64_list = [];
                                                          controller.imageList
                                                              .value = [];
                                                          Get.back();
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Goal',
                                                          style:
                                                              pmstitleStyle(),
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                    .name))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                                'KPI',
                                                                style:
                                                                    pmstitleStyle())),
                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                        .description ??
                                                                    ''))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                                'WEIGHTAGE(%)',
                                                                style:
                                                                    pmstitleStyle())),
                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                    .weightage
                                                                    .toString()))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                                'Employee Self-Assessment',
                                                                style:
                                                                    pmstitleStyle())),
                                                        keyPerformance.employeeRating !=
                                                                    null &&
                                                                keyPerformance
                                                                        .employeeRating
                                                                        .name !=
                                                                    null
                                                            ? Expanded(
                                                                child: Text(keyPerformance
                                                                    .employeeRating
                                                                    .name
                                                                    .toString()))
                                                            : Expanded(
                                                                child: Text(''),
                                                              )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                                'Manager Rating',
                                                                style:
                                                                    pmstitleStyle())),
                                                        keyPerformance.managerRating !=
                                                                    null &&
                                                                keyPerformance
                                                                        .managerRating
                                                                        .name !=
                                                                    null
                                                            ? Expanded(
                                                                child: Text(keyPerformance
                                                                    .managerRating
                                                                    .name
                                                                    .toString()))
                                                            : Expanded(
                                                                child: Text(''),
                                                              )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('Employee Remarks',
                                                        style: pmstitleStyle()),
                                                    Text(keyPerformance
                                                            .employeeRemark
                                                            .toString() ??
                                                        ''),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('Manager Remarks',
                                                        style: pmstitleStyle()),
                                                    Text(keyPerformance
                                                            .managerRemark
                                                            .toString() ??
                                                        ''),
                                                    Text('Attachments',
                                                        style: pmstitleStyle()),
                                                    Obx(() => controller
                                                                .attachment_list
                                                                .value
                                                                .length >
                                                            0
                                                        ? Row(
                                                            children: [
                                                              Expanded(
                                                                  child: GridView
                                                                      .count(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                crossAxisCount:
                                                                    3,
                                                                children: List.generate(
                                                                    controller
                                                                        .attachment_list
                                                                        .value
                                                                        .length,
                                                                    (index1) {
                                                                  return controller
                                                                          .attachment_list
                                                                          .value[
                                                                              index1]
                                                                          .name
                                                                          .contains(
                                                                              ".pdf")
                                                                      ? Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              createPDFFileFromString(controller.attachment_list.value[index1].attach_file).then((path) async {
                                                                                await OpenFile.open(path);
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 100,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    color: Colors.black, //color of border
                                                                                    width: 1, //width of border
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(5)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  controller.attachment_list.value[index1].name,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Image.memory(
                                                                            base64Decode(controller.attachment_list.value[index1].attach_file),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                          ),
                                                                        );
                                                                }),
                                                              )),
                                                            ],
                                                          )
                                                        : SizedBox()),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade100,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, right: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          keyPerformance.name,
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            // Text(
                                            //   keyPerformance.employeeRate
                                            //       .toString(),
                                            //   style: TextStyle(
                                            //       color: backgroundIconColor),
                                            //   textAlign: TextAlign.center,
                                            // ),
                                            keyPerformance.employeeRating !=
                                                        null &&
                                                    keyPerformance
                                                            .employeeRating
                                                            .name !=
                                                        null
                                                ? Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      keyPerformance
                                                          .employeeRating.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                            controller
                                                    .allowSelfEditEmployeeRate()
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                    ),
                                                    onPressed: () {
                                                      if (keyPerformance
                                                                  .employeeRating !=
                                                              null &&
                                                          keyPerformance
                                                                  .employeeRating
                                                                  .id !=
                                                              0 &&
                                                          keyPerformance
                                                                  .employeeRating
                                                                  .id !=
                                                              null) {
                                                        RatingConfig data =
                                                            new RatingConfig();
                                                        data.id = keyPerformance
                                                            .employeeRating.id;
                                                        data.name =
                                                            keyPerformance
                                                                .employeeRating
                                                                .name;
                                                        data.rating_description =
                                                            keyPerformance
                                                                .employeeRating
                                                                .rating_description;
                                                        controller
                                                                .selectedRatingConfig =
                                                            data;
                                                      }
                                                      remarkTextController
                                                          .text = keyPerformance
                                                              .employeeRemark ??
                                                          '';
                                                      ratingValue =
                                                          keyPerformance
                                                              .employeeRate;
                                                      if (keyPerformance
                                                                  .attachmentIds !=
                                                              null &&
                                                          keyPerformance
                                                                  .attachmentIds
                                                                  .length >
                                                              0) {
                                                        controller.getAttachment(
                                                            keyPerformance
                                                                .attachmentIds);
                                                      }
                                                      showBarModalBottomSheet(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  ListView(
                                                                    padding: EdgeInsets.all(0),
                                                                    children: [
                                                                      Container(
                                                                        color: Color(
                                                                            0xff757575),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                          ),
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 10,
                                                                              horizontal: 5),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.bottomRight,
                                                                                child: IconButton(
                                                                                  icon: Icon(Icons.close_outlined),
                                                                                  onPressed: () {
                                                                                    if(controller.ratingConfig_list.length > 0){
                                                                                      controller.selectedRatingConfig = controller.ratingConfig_list[0];
                                                                                    }
                                                                                    controller.isShowAttachment.value = false;
                                                                                    controller.attachment_list.value = [];
                                                                                    controller.isShowImageAttachment.value = false;
                                                                                    controller.image_base64_list = [];
                                                                                    controller.imageList.value = [];
                                                                                    Get.back();
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(child: Text('Goal', style: pmstitleStyle())),
                                                                                  Expanded(child: Text(keyPerformance.name))
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(child: Text('KPI', style: pmstitleStyle())),
                                                                                  Expanded(child: Text(keyPerformance.description ?? ''))
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(child: Text('WEIGHTAGE(%)', style: pmstitleStyle())),
                                                                                  Expanded(child: Text(keyPerformance.weightage.toString()))
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          flex: 2,
                                                                                          child: Text('Employee Self-Assessment', style: pmstitleStyle())),
                                                                                        Expanded(
                                                                                          flex: 4,
                                                                                          child:
                                                                                              Obx(
                                                                                            () => Column(
                                                                                                children: createWhatRadioListRating(),
                                                                                        )
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                              // Row(
                                                                              //   children: [
                                                                              //     Expanded(
                                                                              //       flex: 2,
                                                                              //       child: Text('Employee Self-Assessment', style: pmstitleStyle())),
                                                                              //     Expanded(
                                                                              //       flex: 4,
                                                                              //       child:
                                                                              //           Column(
                                                                              //                   children: createWhatRadioListRating(),
                                                                              //           )
                                                                              //       //     Obx(
                                                                              //       //   () => DropdownButtonHideUnderline(
                                                                              //       //     child: DropdownButton<RatingConfig>(
                                                                              //       //         hint: Container(
                                                                              //       //             // padding: EdgeInsets.only(left: 20),
                                                                              //       //             child: Text(
                                                                              //       //           "Final Rating",
                                                                              //       //         )),
                                                                              //       //         value: controller.selectedRatingConfig,
                                                                              //       //         icon: Icon(Icons.keyboard_arrow_down),
                                                                              //       //         iconSize: 30,
                                                                              //       //         isExpanded: false,
                                                                              //       //         onChanged: (RatingConfig value) {
                                                                              //       //           controller.onChangeRatingConfigDropdown(value);
                                                                              //       //         },
                                                                              //       //         items: controller.ratingConfig_list.map((RatingConfig leave) {
                                                                              //       //           return DropdownMenuItem<RatingConfig>(
                                                                              //       //             value: leave,
                                                                              //       //             child: Padding(
                                                                              //       //               padding: EdgeInsets.only(left: 2.0),
                                                                              //       //               child: Text(
                                                                              //       //                 leave.rating_description,
                                                                              //       //                 style: TextStyle(fontSize: 14),
                                                                              //       //               ),
                                                                              //       //             ),
                                                                              //       //           );
                                                                              //       //         }).toList()),
                                                                              //       //   ),
                                                                              //       // ),
                                                                              //     )
                                                                              //   ],
                                                                              // ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text('Employee Remarks', style: pmstitleStyle()),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                child: TextField(
                                                                                  maxLines: 5,
                                                                                  controller: remarkTextController,
                                                                                  decoration: InputDecoration(
                                                                                    contentPadding: EdgeInsets.all(20.0),
                                                                                    hintText: "Remarks",
                                                                                    border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey[50])),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(flex: 1, child: Text('Attachment :', style: pmstitleStyle())),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        getMultipleFile(context);
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        primary: Colors.white,
                                                                                        side: BorderSide(width: 1.0, color: textFieldTapColor),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Icon(
                                                                                            // <-- Icon
                                                                                            Icons.attach_file,
                                                                                            size: 24.0,
                                                                                            color: textFieldTapColor,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Text('Upload', style: TextStyle(color: textFieldTapColor, fontWeight: FontWeight.bold)),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: SizedBox(),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              Obx(() => controller.isShowImageAttachment.value == true && controller.attachment_list.value.length > 0
                                                                                  ? Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                            child: GridView.count(
                                                                                          shrinkWrap: true,
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          crossAxisCount: 3,
                                                                                          children: List.generate(controller.attachment_list.value.length, (index1) {
                                                                                            return controller.attachment_list.value[index1].name.contains(".pdf")
                                                                                                ? Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Stack(
                                                                                                      children: [
                                                                                                        GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            createPDFFileFromString(controller.attachment_list.value[index1].attach_file).then((path) async {
                                                                                                              await OpenFile.open(path);
                                                                                                            });
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                            decoration: BoxDecoration(
                                                                                                                border: Border.all(
                                                                                                                  color: Colors.black, //color of border
                                                                                                                  width: 1, //width of border
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(5)),
                                                                                                            child: Center(
                                                                                                              child: Text(
                                                                                                                controller.attachment_list.value[index1].name,
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: TextStyle(
                                                                                                                  color: Colors.black54,
                                                                                                                  fontSize: 16,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Positioned(
                                                                                                          top: 0,
                                                                                                          right: 0,
                                                                                                          child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                setState(() {
                                                                                                                  controller.attachment_list.value.removeAt(index1);
                                                                                                                  controller.attachment_list.refresh();
                                                                                                                });
                                                                                                              },
                                                                                                              child: Icon(Icons.close, color: Colors.red)),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                : Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Stack(
                                                                                                      children: [
                                                                                                        Image.memory(
                                                                                                          base64Decode(controller.attachment_list.value[index1].attach_file),
                                                                                                          fit: BoxFit.cover,
                                                                                                          width: 100,
                                                                                                          height: 100,
                                                                                                        ),
                                                                                                        Positioned(
                                                                                                          top: 0,
                                                                                                          right: 0,
                                                                                                          child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                setState(() {
                                                                                                                  controller.attachment_list.value.removeAt(index1);
                                                                                                                  controller.attachment_list.refresh();
                                                                                                                });
                                                                                                              },
                                                                                                              child: Icon(Icons.close, color: Colors.red)),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                          }),
                                                                                        )),
                                                                                      ],
                                                                                    )
                                                                                  : SizedBox()),
                                                                              SizedBox(
                                                                                height: 3,
                                                                              ),
                                                                              Obx(() => controller.isShowAttachment.value == true && controller.imageList.value.length > 0
                                                                                  ? Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                            child: GridView.count(
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          crossAxisCount: 3,
                                                                                          children: List.generate(controller.imageList.value.length, (index) {
                                                                                            return controller.imageList.value[index].name.contains(".pdf")
                                                                                                ? Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Stack(
                                                                                                      children: [
                                                                                                        GestureDetector(
                                                                                                          onTap: () async {
                                                                                                            await OpenFile.open(controller.imageList.value[index].path);
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                            decoration: BoxDecoration(
                                                                                                                border: Border.all(
                                                                                                                  color: Colors.black, //color of border
                                                                                                                  width: 1, //width of border
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(5)),
                                                                                                            child: Center(
                                                                                                              child: Text(
                                                                                                                controller.imageList.value[index].name,
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: TextStyle(
                                                                                                                  color: Colors.black54,
                                                                                                                  fontSize: 16,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Positioned(
                                                                                                          top: 0,
                                                                                                          right: 0,
                                                                                                          child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                setState(() {
                                                                                                                  controller.imageList.value.removeAt(index);
                                                                                                                  controller.image_base64_list.removeAt(index);
                                                                                                                  controller.imageList.refresh();
                                                                                                                });
                                                                                                              },
                                                                                                              child: Icon(Icons.close, color: Colors.red)),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )
                                                                                                : Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Stack(
                                                                                                      children: [
                                                                                                        Image.file(
                                                                                                          File(controller.imageList.value[index].path),
                                                                                                          fit: BoxFit.cover,
                                                                                                          width: 100,
                                                                                                          height: 100,
                                                                                                        ),
                                                                                                        Positioned(
                                                                                                          top: 0,
                                                                                                          right: 0,
                                                                                                          child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                setState(() {
                                                                                                                  controller.imageList.value.removeAt(index);
                                                                                                                  controller.image_base64_list.removeAt(index);
                                                                                                                  controller.imageList.refresh();
                                                                                                                });
                                                                                                              },
                                                                                                              child: Icon(Icons.close, color: Colors.red)),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                          }),
                                                                                        )),
                                                                                      ],
                                                                                    )
                                                                                  : SizedBox()),
                                                                              Center(
                                                                                child: GFButton(
                                                                                  color: textFieldTapColor,
                                                                                  onPressed: () {
                                                                                    controller.detailModel.value.keyPerformanceIds[index].setemployeeRate(ratingValue);
                                                                                    controller.detailModel.value.keyPerformanceIds[index].setemployeeRemark(remarkTextController.text);
                                                                                    controller.editEmployeeRateAndRate(index);
                                                                                  },
                                                                                  text: "SAVE",
                                                                                  blockButton: true,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ));
                                                    },
                                                  )
                                                : SizedBox()
                                          ],
                                        )),
                                    keyPerformance.managerRating != null &&
                                            keyPerformance.managerRating.name !=
                                                null
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              keyPerformance.managerRating.name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: backgroundIconColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Expanded(
                                            flex: 1,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: backgroundIconColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         Text(
                                    //           keyPerformance.managerRate
                                    //               .toString(),
                                    //           style: TextStyle(
                                    //               color: backgroundIconColor),
                                    //           textAlign: TextAlign.center,
                                    //         ),
                                    //       ],
                                    //     )),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5, right: 0, left: 0),
                    //   child: Divider(
                    //     height: 1,
                    //     thickness: 1,
                    //     color: backgroundIconColor,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //           flex: 2,
                    //           child: Text(
                    //             'Average',
                    //             style: TextStyle(color: backgroundIconColor),
                    //           )),
                    //       Expanded(
                    //           flex: 1,
                    //           child: Obx(
                    //             () => Text(
                    //               NumberFormat("#.##").format(
                    //                   controller.totalEmployeeRate.value),
                    //               style: TextStyle(color: backgroundIconColor),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           )),
                    //       Expanded(
                    //           flex: 1,
                    //           child: Obx(
                    //             () => Text(
                    //               NumberFormat("#.##")
                    //                   .format(controller.totalFinalRate.value),
                    //               style: TextStyle(color: backgroundIconColor),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           )),
                    //     ],
                    //   ),
                    // ),
                  ],
                )),

                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Key Performance Areas',
                                style: TextStyle(color: backgroundIconColor),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text('Description',
                                  style: TextStyle(color: backgroundIconColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Employee Self-Assessment',
                                style: TextStyle(
                                  color: backgroundIconColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Manager Rating',
                                style: TextStyle(
                                  color: backgroundIconColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: backgroundIconColor,
                      ),
                    ),
                    Expanded(
                      // height: 280,
                      child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller
                              .detailModel.value.competenciesIds.length,
                          itemBuilder: (context, index) {
                            Competencies_ids competencies = controller
                                .detailModel.value.competenciesIds[index];
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          color: Color(0xff757575),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: IconButton(
                                                    icon: Icon(
                                                        Icons.close_outlined),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      'KEY PERFORMANCE AREAS',
                                                      style: pmstitleStyle(),
                                                    )),
                                                    Expanded(
                                                        child: Text(
                                                            competencies.name))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            'Description',
                                                            style:
                                                                pmstitleStyle())),
                                                    Expanded(
                                                        child: Text(competencies
                                                                .description ??
                                                            ''))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            'Employee Self-Assessment',
                                                            style:
                                                                pmstitleStyle())),
                                                    competencies.employee_rating !=
                                                                null &&
                                                            competencies
                                                                    .employee_rating
                                                                    .name !=
                                                                null
                                                        ? Expanded(
                                                            child: Text(competencies
                                                                .employee_rating
                                                                .name
                                                                .toString()))
                                                        : Expanded(
                                                            child: Text(''),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            'Manager Rating',
                                                            style:
                                                                pmstitleStyle())),
                                                    competencies.rating !=
                                                                null &&
                                                            competencies.rating
                                                                    .id !=
                                                                0 &&
                                                            competencies.rating
                                                                    .id !=
                                                                null
                                                        ? Expanded(
                                                            child: Text(
                                                                competencies
                                                                    .rating.name
                                                                    .toString()))
                                                        : Expanded(
                                                            child: Text(''),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Remark',
                                                    style: pmstitleStyle()),
                                                Text(competencies.comment
                                                        .toString() ??
                                                    ''),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          competencies.name,
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            competencies.description ?? '',
                                            style: TextStyle(
                                                color: backgroundIconColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis)),
                                    Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  competencies.employee_rating !=
                                                              null &&
                                                          competencies
                                                                  .employee_rating
                                                                  .name !=
                                                              null
                                                      ? Expanded(
                                                        flex: 1,
                                                          child: Text(
                                                            competencies
                                                                .employee_rating
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundIconColor),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )
                                                      : Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            '',
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundIconColor),
                                                            textAlign:
                                                                TextAlign.center,
                                                          ),
                                                      ),
                                                  controller
                                                          .allowSelfEditEmployeeRate()
                                                      ? IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 16,
                                                          ),
                                                          onPressed: () {
                                                            if (competencies
                                                                        .employee_rating !=
                                                                    null &&
                                                                competencies
                                                                        .employee_rating
                                                                        .id !=
                                                                    0 && competencies.employee_rating.id!=null) {
                                                              RatingConfig
                                                                  data =
                                                                  new RatingConfig();
                                                              data.id =
                                                                  competencies
                                                                      .employee_rating
                                                                      .id;
                                                              data.name =
                                                                  competencies
                                                                      .employee_rating
                                                                      .name;
                                                              data.rating_description =
                                                                  competencies
                                                                      .employee_rating
                                                                      .rating_description;
                                                              controller
                                                                      .selectedCompetenciesRatingConfig =
                                                                  data;
                                                            }
                                                            remarkTextController
                                                                    .text =
                                                                competencies
                                                                    .comment
                                                                    .toString();

                                                            showBarModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        ListView(
                                                                          padding: EdgeInsets.all(0),
                                                                          children: [
                                                                            Container(
                                                                              color:
                                                                                  Color(0xff757575),
                                                                              child:
                                                                                  Container(
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                ),
                                                                                padding:
                                                                                    EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                                                                child:
                                                                                    Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Align(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    child: IconButton(
                                                                                      icon: Icon(Icons.close_outlined),
                                                                                      onPressed: () {
                                                                                        if(controller.ratingConfig_list.length > 0){
                                                                                          controller.selectedCompetenciesRatingConfig = controller.ratingConfig_list[0];
                                                                                        }
                                                                                        Get.back();
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(child: Text('KEY PERFORMANCE AREAS', style: pmstitleStyle())),
                                                                                        Expanded(child: Text(competencies.name))
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(child: Text('Description', style: pmstitleStyle())),
                                                                                        Expanded(child: competencies.description != null ?Text(competencies.description): Text(''))
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    // Row(
                                                                                    //   children: [
                                                                                    //     Expanded(child: Text('Employee Self-Assessment', style: pmstitleStyle())),
                                                                                    //     Expanded(
                                                                                    //       child:
                                                                                    //           Obx(
                                                                                    //         () => DropdownButtonHideUnderline(
                                                                                    //           child: DropdownButton<RatingConfig>(
                                                                                    //               hint: Container(
                                                                                    //                   // padding: EdgeInsets.only(left: 20),
                                                                                    //                   child: Text(
                                                                                    //                 "Employee Rating",
                                                                                    //               )),
                                                                                    //               value: controller.selectedCompetenciesRatingConfig,
                                                                                    //               icon: Icon(Icons.keyboard_arrow_down),
                                                                                    //               iconSize: 30,
                                                                                    //               isExpanded: false,
                                                                                    //               onChanged: (RatingConfig value) {
                                                                                    //                 controller.onChangeRatingCompetenciesConfigDropdown(value);
                                                                                    //               },
                                                                                    //               items: controller.ratingConfig_list.map((RatingConfig leave) {
                                                                                    //                 return DropdownMenuItem<RatingConfig>(
                                                                                    //                   value: leave,
                                                                                    //                   child: Padding(
                                                                                    //                     padding: EdgeInsets.only(left: 2.0),
                                                                                    //                     child: Text(
                                                                                    //                       leave.rating_description,
                                                                                    //                       style: TextStyle(fontSize: 14),
                                                                                    //                     ),
                                                                                    //                   ),
                                                                                    //                 );
                                                                                    //               }).toList()),
                                                                                    //         ),
                                                                                    //       ),
                                                                                    //     )
                                                                                    //   ],
                                                                                    // ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          flex: 2,
                                                                                          child: Text('Employee Self-Assessment', style: pmstitleStyle())),
                                                                                        Expanded(
                                                                                          flex: 4,
                                                                                          child:
                                                                                              Obx(
                                                                                            () => Column(
                                                                                                children: createRadioListRating(),
                                                                                        )
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: TextField(
                                                                                        maxLines: 5,
                                                                                        controller: remarkTextController,
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.all(20.0),
                                                                                          hintText: "Remarks",
                                                                                          border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey[50])),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Center(
                                                                                      child: GFButton(
                                                                                        color: textFieldTapColor,
                                                                                        onPressed: () {
                                                                                          controller.detailModel.value.competenciesIds[index].setScore(ratingValue);
                                                                                          controller.detailModel.value.competenciesIds[index].setComment(remarkTextController.text);
                                                                                          controller.editEmployeeCompetenciesScore(index);
                                                                                        },
                                                                                        text: "SAVE",
                                                                                        blockButton: true,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ));
                                                          },
                                                        )
                                                      : SizedBox()
                                                ],
                                              )),
                                        
                                    Expanded(
                                        flex: 1,
                                        child: competencies.rating != null &&
                                                competencies.rating.id != 0 &&
                                                competencies.rating.id != null
                                            ? Text(
                                                competencies.rating.name
                                                    .toString(),
                                                style: TextStyle(
                                                  color: backgroundIconColor,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                              )
                                            : Text('',
                                                style: TextStyle(
                                                  color: backgroundIconColor,
                                                ))),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ],
                )),

                Container(
                    child: controller.detailModel.value.state !=
                                'sent_to_employee' &&
                            controller.detailModel.value.state !=
                                'acknowledge' &&
                            controller.detailModel.value.state !=
                                'mid_year_self_assessment'
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       'Review Year',
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Final Rating',
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Final Description',
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       'Competency',
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     )),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       'Final Rating',
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 0, left: 0),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: backgroundIconColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       'Mid',
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     )),
                                    Obx(() => Expanded(
                                        flex: 1,
                                        // child: Text(
                                        //   AppUtils.changeDateFormat(controller
                                        //           .detailModel.value.midFromDate) +
                                        //       " - " +
                                        //       AppUtils.changeDateFormat(controller
                                        //           .detailModel.value.midToDate),
                                        //   style: TextStyle(color: backgroundIconColor),
                                        // )),
                                        // child: Text(
                                        //   controller
                                        //       .detailModel.value.final_evaluation_rating
                                        //       .toString(),
                                        //   style: TextStyle(color: backgroundIconColor),
                                        // )
                                        child: controller.detailModel.value
                                                        .final_evaluation_rating !=
                                                    null &&
                                                controller
                                                        .detailModel
                                                        .value
                                                        .final_evaluation_rating
                                                        .id !=
                                                    0 &&
                                                controller
                                                        .detailModel
                                                        .value
                                                        .final_evaluation_rating
                                                        .id !=
                                                    null
                                            ? Text(
                                                controller
                                                    .detailModel
                                                    .value
                                                    .final_evaluation_rating
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: backgroundIconColor))
                                            : Text(
                                                '',
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              ))),
                                    Obx(() => Expanded(
                                        flex: 1,
                                        // child: Text(
                                        //   AppUtils.removeNullString(controller
                                        //       .detailModel.value.mid_kpi
                                        //       .toStringAsFixed(1)),
                                        //   style: TextStyle(color: backgroundIconColor),
                                        // ))),
                                        child: controller.detailModel.value
                                                    .final_evaluation_description !=
                                                null
                                            ? Text(
                                                controller.detailModel.value
                                                    .final_evaluation_description
                                                    .toString(),
                                                style: TextStyle(
                                                    color: backgroundIconColor))
                                            : Text(
                                                '',
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              ))),
                                    // Obx(() => Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       AppUtils.removeNullString(controller
                                    //           .detailModel.value.mid_competency_score
                                    //           .toStringAsFixed(1)),
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     ))),
                                    // Obx(() => Expanded(
                                    //     flex: 1,
                                    //     child: Text(
                                    //       AppUtils.removeNullString(controller
                                    //           .detailModel.value.mid_final_rating
                                    //           .toStringAsFixed(1)),
                                    //       style: TextStyle(color: backgroundIconColor),
                                    //     ))),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10, top: 10),
                              //   child: Row(
                              //     children: [
                              //       // Expanded(
                              //       //     flex: 1,
                              //       //     child: Text(
                              //       //       'Annual',
                              //       //       style: TextStyle(color: backgroundIconColor),
                              //       //     )),
                              //       Obx(() => Expanded(
                              //           flex: 1,
                              //           child: Text(
                              //             AppUtils.changeDateFormat(controller
                              //                     .detailModel.value.endFromDate) +
                              //                 " - " +
                              //                 AppUtils.changeDateFormat(
                              //                     controller.detailModel.value.endToDate),
                              //             style: TextStyle(color: backgroundIconColor),
                              //           ))),
                              //       Obx(() => Expanded(
                              //           flex: 1,
                              //           child: Text(
                              //             AppUtils.removeNullString(controller
                              //                 .detailModel.value.kpi
                              //                 .toStringAsFixed(1)),
                              //             style: TextStyle(color: backgroundIconColor),
                              //           ))),
                              //       Obx(() => Expanded(
                              //           flex: 1,
                              //           child: Text(
                              //             AppUtils.removeNullString(controller
                              //                 .detailModel.value.competency_score
                              //                 .toStringAsFixed(1)),
                              //             style: TextStyle(color: backgroundIconColor),
                              //           ))),
                              //       Obx(() => Expanded(
                              //           flex: 1,
                              //           child: Text(
                              //             AppUtils.removeNullString(controller
                              //                 .detailModel.value.final_rating
                              //                 .toStringAsFixed(1)),
                              //             style: TextStyle(color: backgroundIconColor),
                              //           ))),
                              //     ],
                              //   ),
                              // ),
                            ],
                          )
                        : SizedBox()),

                // Container(
                //   child: Obx(() => controller.detailModel.value
                //               .keyPerformanceAttachmentIds.length <=
                //           0
                //       ? Center(
                //           child: Text('No attachment'),
                //         )
                //       : ListView.builder(
                //           itemCount: controller.detailModel.value
                //               .keyPerformanceAttachmentIds.length,
                //           itemBuilder: (context, index) {
                //             return InkWell(
                //               onTap: () async {
                //                 controller.detailModel.value
                //                         .keyPerformanceAttachmentIds[index].mimetype
                //                         .contains('application/pdf')
                //                     ?
                //                     // open pdf
                //                     createPDFFileFromString(controller
                //                             .detailModel
                //                             .value
                //                             .keyPerformanceAttachmentIds[index]
                //                             .attached_file)
                //                         .then((path) async {
                //                         await OpenFile.open(path);
                //                       })
                //                       :controller.detailModel.value
                //                         .keyPerformanceAttachmentIds[index].mimetype
                //                         .contains('application/vnd.ms-excel')
                //                     ?
                //                     // open pdf
                //                     createExcelFileFromString(controller
                //                             .detailModel
                //                             .value
                //                             .keyPerformanceAttachmentIds[index]
                //                             .attached_file)
                //                         .then((path) async {
                //                         await OpenFile.open(path);
                //                       })
                //                     :controller.detailModel.value
                //                         .keyPerformanceAttachmentIds[index].mimetype
                //                         .contains('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
                //                     ?
                //                     // open pdf
                //                     createExFileFromString(controller
                //                             .detailModel
                //                             .value
                //                             .keyPerformanceAttachmentIds[index]
                //                             .attached_file)
                //                         .then((path) async {
                //                         await OpenFile.open(path);
                //                       })
                //                     :controller.detailModel.value
                //                         .keyPerformanceAttachmentIds[index].mimetype
                //                         .contains('application/msword')
                //                     ?
                //                     // open pdf
                //                     createWordFileFromString(controller
                //                             .detailModel
                //                             .value
                //                             .keyPerformanceAttachmentIds[index]
                //                             .attached_file)
                //                         .then((path) async {
                //                         await OpenFile.open(path);
                //                       })
                //                       :controller.detailModel.value
                //                         .keyPerformanceAttachmentIds[index].mimetype
                //                         .contains('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
                //                     ?
                //                     // open pdf
                //                     createDocxWordFileFromString(controller
                //                             .detailModel
                //                             .value
                //                             .keyPerformanceAttachmentIds[index]
                //                             .attached_file)
                //                         .then((path) async {
                //                         await OpenFile.open(path);
                //                       })
                //                     : await showDialog(
                //                         context: context,
                //                         builder: (_) {
                //                           return ImageDialog(
                //                             bytes: base64Decode(controller
                //                                 .detailModel
                //                                 .value
                //                                 .keyPerformanceAttachmentIds[
                //                                     index]
                //                                 .attached_file),
                //                           );
                //                         });
                //               },
                //               child: Card(
                //                 child: ListTile(
                //                   title: Text(
                //                       '${controller.detailModel.value.keyPerformanceAttachmentIds[index].name}'),
                //                 ),
                //               ),
                //             );
                //           })),
                // ),
              ],
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Obx(
            () => Center(
              child: controller.showApprove.value
                  ? SizedBox()
                  : controller.showAcknowledge.value &&
                          controller.detailModel.value.state ==
                              'sent_to_employee'
                      ? Container(
                          child: RaisedButton(
                            onPressed: () {
                              controller.clickAcknowledge(
                                  controller.detailModel.value.id.toString());
                            },
                            color: Color.fromRGBO(58, 47, 112, 1),
                            child: Text(
                              (("Acknowledge")),
                              style: buttonTextStyle(),
                            ),
                          ),
                        )
                      : controller.showSubmitOrNot()
                          ? Container(
                              width: 200,
                              child: RaisedButton(
                                onPressed: () {
                                  controller.clickSubmit(controller
                                      .detailModel.value.id
                                      .toString());
                                },
                                color: Color.fromRGBO(58, 47, 112, 1),
                                child: Text(
                                  (("Submit")),
                                  style: buttonTextStyle(),
                                ),
                              ),
                            )
                          : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createWhatRadioListRating() {
    List<Widget> widgets = [];
    for (RatingConfig rating in controller.ratingConfig_list) {
      widgets.add(
        RadioListTile(
          contentPadding: EdgeInsets.all(0),
          value: rating,
          dense: true,
          groupValue: controller.selectedRatingConfig,
          title: Text(rating.rating_description,
          style: TextStyle(fontSize: 14),),
          onChanged: (value) {
            controller.onChangeRatingConfigDropdown(value);
          },
          selected: controller.selectedRatingConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }

  List<Widget> createRadioListRating() {
    List<Widget> widgets = [];
    for (RatingConfig rating in controller.ratingConfig_list) {
      widgets.add(
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
          value: rating,
          dense: true,
          groupValue: controller.selectedCompetenciesRatingConfig,
          title: Text(rating.rating_description,
          style: TextStyle(fontSize: 14),),
          onChanged: (value) {
            controller.onChangeRatingCompetenciesConfigDropdown(value);
          },
          selected: controller.selectedCompetenciesRatingConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }

  getMultipleFile(BuildContext context) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg', 'jpeg'],
    );

    if (result == null) return;
    var data = [];
    if (controller.attachment_list.length > 0) {
      for (var j = 0; j < controller.attachment_list.length; j++) {
        data.add(controller.attachment_list[j].name);
      }
    }
    if (result.files.length > 0) {
      for (var i = 0; i < result.files.length; i++) {
        data.add(result.files[i].name);
      }
    }
    if (controller.imageList.value.length > 0) {
      for (var k = 0; k < controller.imageList.value.length; k++) {
        data.add(controller.imageList.value[k].name);
      }
    }
    if (data.length > 2) {
      _showAlertDialog();
    } else {
      setState(() {
        controller.isShowAttachment.value = true;
        for (var i = 0; i < result.files.length; i++) {
          controller.imageList.value.add(result.files[i]);
          setImageList(result.files[i].path, result.files[i].name);
        }
        controller.imageList.refresh();
      });
    }
  }

  setImageList(String filePath, String fileName) async {
    File image = File(filePath);
    //File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(image.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64, fileName);
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Maximum File length is two'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
