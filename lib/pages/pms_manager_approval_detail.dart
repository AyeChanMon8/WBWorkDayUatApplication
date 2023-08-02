// @dart=2.9

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/leave_detail.dart';
import 'package:winbrother_hr_app/pages/pms_details.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/ui/components/textbox.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:winbrother_hr_app/utils/pdf_file_utils.dart';

class PmsManagerApprovalDetails extends StatefulWidget {
  @override
  _PmsDetailsState createState() => _PmsDetailsState();
}

class _PmsDetailsState extends State<PmsManagerApprovalDetails>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  TabController _tabController;
  TextEditingController remarkTextController = TextEditingController();

  PMSEmployeeDetailController controller =
  Get.put(PMSEmployeeDetailController());
  double ratingValue = 0;
  String role = '';
  int empID = 0;

  @override
  void initState() {
    role = box.read('role_category');
    _tabController = TabController(length: 4, vsync: this);
    controller.detailModel.value = Get.arguments;
    empID = int.tryParse(box.read('emp_id'));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //PMSDetailModel pmsDetailModel = Get.arguments;
    // controller.detailModel.value = Get.arguments;

    controller.calculateTotalEmployeeRate();
    controller.calculateTotalFinalRate();
    controller.calculateTotalScoreAverage();
    final box = GetStorage();
    String user_image = box.read('emp_image');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(context, "PMS Details", user_image),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: GFButton(
                color:
                textFieldTapColor,
                onPressed:
                    () {
                  controller
                      .refreshToApproveData(controller.detailModel.value.id);
                },
                text:
                "Refresh",
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
                type: GFButtonType.outline,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30,top:20),
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
                      (AppUtils.removeNullString(controller
                          .detailModel.value.job_id.name)),
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
                      (
                        
                        controller.detailModel.value.startDate()!=null?
                        AppUtils.changeDateFormat(controller.detailModel.value.startDate())
                        :''),
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
                      (controller.detailModel.value.endDate()!=null?
                      AppUtils.changeDateFormat(controller.detailModel.value.endDate())
                      :''),
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
                //       AppUtils.changeDateFormat(controller.detailModel.value.deadline)
                //       ,
                //       style: pmstitleStyle(),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                color: backgroundIconColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Key Performance \nEvaluation',
                ),
                Tab(
                  text: 'Competencies',
                ),
                Tab(
                  text: 'Final Rating',
                ),
                Tab(
                  text: 'Attachment',
                ),
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
                  margin: EdgeInsets.only(left:20,right:20,top:20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left:10,right:10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Key Performance Area',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Employee Rate',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              SizedBox(width:5),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Final Rate',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                            ],
                          ),
                        ),
                         SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 5, left: 5),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: backgroundIconColor,
                          ),
                        ),
                        SizedBox(height:10),
                        Expanded(
                          child: Obx(
                                () => ListView.builder(
                                shrinkWrap: true,
                                //physics: NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .detailModel.value.keyPerformanceIds.length,
                                itemBuilder: (context, index) {
                                  Key_performance_ids keyPerformance = controller
                                      .detailModel.value.keyPerformanceIds[index];
                                  controller.managerRateTextController.text = keyPerformance
                                      .managerRate
                                      .toString();
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
                                              child: Container(
                                                 margin: EdgeInsets.only(left: 10, right: 10),
                                                child: Column(
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
                                                                'Description',
                                                                style:
                                                                pmstitleStyle())),
                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                    .description ?? ''))
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
                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                    .employeeRate
                                                                    .toString())
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
                                                                'Final Rate',
                                                                style:
                                                                pmstitleStyle())),

                                                        Expanded(
                                                            child: Text(
                                                                keyPerformance
                                                                    .managerRate
                                                                    .toString())
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
                                                        '')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      color: index % 2 == 0
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade100,
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10,bottom:10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
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
                                              child: Text(
                                                keyPerformance.employeeRate
                                                    .toString(),
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                                textAlign: TextAlign.center,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    keyPerformance.managerRate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: backgroundIconColor),
                                                    textAlign: TextAlign.center,
                                                  ),

                                                  controller.isAllowEditManagerRate()? IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                    ),
                                                    onPressed: () {
                                                      remarkTextController.text = keyPerformance.managerRemark.toString();
                                                      ratingValue = keyPerformance.managerRate;
                                                      showBarModalBottomSheet(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                              Container(
                                                                color: Color(
                                                                    0xff757575),
                                                                child: Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius
                                                                            .circular(
                                                                            10),
                                                                        topRight:
                                                                        Radius.circular(
                                                                            10)),
                                                                  ),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      10,
                                                                      horizontal:
                                                                      5),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child:
                                                                              Text('KEY PERFORMANCE AREAS', style: pmstitleStyle())),
                                                                          Expanded(
                                                                              child:
                                                                              Text(keyPerformance.name))
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child:
                                                                              Text('Description', style: pmstitleStyle())),
                                                                          Expanded(
                                                                              child:
                                                                              Text(keyPerformance.description ?? ''))
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child:
                                                                              Text('WEIGHTAGE(%)', style: pmstitleStyle())),
                                                                          Expanded(
                                                                              child:
                                                                              Text(keyPerformance.weightage.toString()))
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child:
                                                                              Text('Final Rating', style: pmstitleStyle())),
                                                                          Expanded(
                                                                            child:
                                                                            RatingBar.builder(
                                                                              initialRating:
                                                                              keyPerformance.managerRate,
                                                                              minRating:
                                                                              1,
                                                                              direction:
                                                                              Axis.horizontal,
                                                                              allowHalfRating:
                                                                              false,
                                                                              itemSize:
                                                                              22,
                                                                              itemCount:
                                                                              5,
                                                                              itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 4.0),
                                                                              itemBuilder: (context, _) =>
                                                                                  Icon(
                                                                                    Icons.star,
                                                                                    color: Colors.amber,
                                                                                  ),
                                                                              onRatingUpdate:
                                                                                  (rating) {
                                                                                print("ratingValue");
                                                                                print(ratingValue.toString());
                                                                                ratingValue = rating.toDouble();
                                                                              },
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      Text(
                                                                          'Final Remarks',
                                                                          style:
                                                                          pmstitleStyle()),
                                                                      SizedBox(
                                                                        height:
                                                                        10,
                                                                      ),
                                                                      TextField(
                                                                        maxLines:
                                                                        5,
                                                                        controller:
                                                                        remarkTextController,
                                                                        decoration:
                                                                        InputDecoration(
                                                                          contentPadding:
                                                                          EdgeInsets.all(20.0),
                                                                          hintText:
                                                                          "Remarks",
                                                                          border: OutlineInputBorder(
                                                                              borderSide:
                                                                              new BorderSide(color: Colors.grey[50])),
                                                                        ),
                                                                      ),
                                                                      GFButton(
                                                                        color:
                                                                        textFieldTapColor,
                                                                        onPressed:
                                                                            () {
                                                                          controller
                                                                              .detailModel
                                                                              .value
                                                                              .keyPerformanceIds[index]
                                                                              .setManagerRate(ratingValue);
                                                                          controller
                                                                              .detailModel
                                                                              .value
                                                                              .keyPerformanceIds[index]
                                                                              .setManagerRemark(remarkTextController.text);
                                                                          controller
                                                                              .editManagerRateAndRate(index);
                                                                        },
                                                                        text:
                                                                        "SAVE",
                                                                        blockButton:
                                                                        true,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                    },
                                                  ):SizedBox()

                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 5, left: 5,bottom:10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: backgroundIconColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left:10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Average',
                                    style: TextStyle(color: backgroundIconColor,fontSize: 16,fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Obx(
                                        () => Text(
                                      NumberFormat("#.##").format(
                                          controller.totalEmployeeRate.value),
                                      style: TextStyle(color: backgroundIconColor,fontSize: 16,fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Obx(
                                        () => Text(
                                      NumberFormat("#.##")
                                          .format(controller.totalFinalRate.value),
                                      style: TextStyle(color: backgroundIconColor,fontSize: 16,fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left:10,right:0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Key Performance Areas',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Text('Description',
                                      style: TextStyle(color: backgroundIconColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Score',
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
                          padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: backgroundIconColor,
                          ),
                        ),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                                            .description ?? ''))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text('Score',
                                                            style:
                                                            pmstitleStyle())),
                                                    Expanded(
                                                        child: Text(competencies
                                                            .score
                                                            .toString()))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // Text('Comment',
                                                //     style: pmstitleStyle()),
                                                // Text(competencies.comment
                                                //     .toString() ??
                                                //     ''),
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0,left:10,right:10),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        Row(
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
                                                child: Text(competencies.description ?? '',
                                                    style: TextStyle(
                                                        color: backgroundIconColor),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis)),
                                           /* Expanded(
                                                flex: 1,
                                                child: Text(
                                                  competencies.score.toString(),
                                                  style: TextStyle(
                                                    color: backgroundIconColor,
                                                  ),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                )),*/
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                    competencies.score.toString(),
                                                      style: TextStyle(
                                                          color: backgroundIconColor),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    controller.isAllowEditManagerRate()? IconButton(
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 16,
                                                      ),
                                                      onPressed: () {
                                                        remarkTextController.text = competencies.comment;
                                                        ratingValue = controller
                                                            .detailModel.value.competenciesIds[index].score;
                                                        showBarModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>Container(
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
                                                                                    .description ?? ''))
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child:
                                                                                Text('Scores :', style: pmstitleStyle())),
                                                                            Expanded(
                                                                              child:
                                                                              RatingBar.builder(
                                                                                initialRating:
                                                                                controller
                                                                                    .detailModel.value.competenciesIds[index].score,
                                                                                minRating:
                                                                                1,
                                                                                direction:
                                                                                Axis.horizontal,
                                                                                allowHalfRating:
                                                                                false,
                                                                                itemSize:
                                                                                22,
                                                                                itemCount:
                                                                                5,
                                                                                itemPadding:
                                                                                EdgeInsets.symmetric(horizontal: 4.0),
                                                                                itemBuilder: (context, _) =>
                                                                                    Icon(
                                                                                      Icons.star,
                                                                                      color: Colors.amber,
                                                                                    ),
                                                                                onRatingUpdate:
                                                                                    (rating) {
                                                                                  ratingValue = rating.toDouble();
                                                                                },
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        // Text(
                                                                        //     'Comment',
                                                                        //     style:
                                                                        //     pmstitleStyle()),
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        TextField(
                                                                          maxLines:
                                                                          5,
                                                                          controller:
                                                                          remarkTextController,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            contentPadding:
                                                                            EdgeInsets.all(20.0),
                                                                            hintText:
                                                                            "Remarks",
                                                                            border: OutlineInputBorder(
                                                                                borderSide:
                                                                                new BorderSide(color: Colors.grey[50])),
                                                                          ),
                                                                        ),
                                                                        GFButton(
                                                                          color:
                                                                          textFieldTapColor,
                                                                          onPressed:
                                                                              () {
                                                                            controller
                                                                                .detailModel
                                                                                .value
                                                                                .competenciesIds[index]
                                                                                .setScore(ratingValue);
                                                                            controller
                                                                                .detailModel
                                                                                .value
                                                                                .competenciesIds[index]
                                                                                .setComment(remarkTextController.text);
                                                                            controller
                                                                                .editCompetenciesScore(index);
                                                                          },
                                                                          text:
                                                                          "SAVE",
                                                                          blockButton:
                                                                          true,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                                );
                                                      },
                                                    ):SizedBox()
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: backgroundIconColor,
                          ),
                        ),
                        SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left:10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Average',
                                    style: TextStyle(color: backgroundIconColor,fontSize: 16,fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                flex: 2,
                                  child: Container()),
                              Expanded(
                                  flex: 1,
                                  child: Obx(
                                        () => Text(
                                      NumberFormat("#.##").format(
                                          controller.totalScoreAverage.value),
                                      style: TextStyle(color: backgroundIconColor,fontSize: 16,fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                     
                     
                      ],
                    )),
                Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,top: 10),
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
                                    'From-To',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'KPI',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Competency',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Final Rating',
                                    style: TextStyle(color: backgroundIconColor),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height:20),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: backgroundIconColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top: 10),
                          child: Row(
                            children: [
                              // Expanded(
                              //     flex: 1,
                              //     child: Text(
                              //       'Mid',
                              //       style: TextStyle(color: backgroundIconColor),
                              //     )),
                              Obx(()=>
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        AppUtils.changeDateFormat(controller.detailModel.value.midFromDate)+" - "+AppUtils.changeDateFormat(controller.detailModel.value.midToDate),
                                        style: TextStyle(color: backgroundIconColor),
                                      )),
                              ),
                             Obx(()=>
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.mid_kpi.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                              Obx(()=>
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.mid_competency_score.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                              Obx(()=>
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.mid_final_rating.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsets.only(left:10,top: 10),
                          child: Row(
                            children: [
                              // Expanded(
                              //     flex: 1,
                              //     child: Text(
                              //       'Annual',
                              //       style: TextStyle(color: backgroundIconColor),
                              //     )),
                              Obx(()=>Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.changeDateFormat(controller.detailModel.value.endFromDate)+" - "+AppUtils.changeDateFormat(controller.detailModel.value.endToDate),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                             Obx(()=>Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.kpi.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                              Obx(()=>Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.competency_score.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                              Obx(()=> Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppUtils.removeNullString(controller.detailModel.value.final_rating.toStringAsFixed(1)),
                                    style: TextStyle(color: backgroundIconColor),
                                  ))),
                            ],
                          ),
                        ),
                      ],
                    )),
              
                Container(
                  child: Obx(() => 
                  controller.detailModel.value.keyPerformanceAttachmentIds.length <= 0 ? 
                  Center(child: Text('No attachment'),)
                  :
                  ListView.builder(
                      itemCount: controller.detailModel.value.keyPerformanceAttachmentIds.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ()async{
                            controller.detailModel.value
                                        .keyPerformanceAttachmentIds[index].mimetype
                                        .contains('pdf')
                                    ?
                                    // open pdf
                                    createPDFFileFromString(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file)
                                        .then((path) async {
                                        await OpenFile.open(path);
                                      })
                                      :controller.detailModel.value
                                        .keyPerformanceAttachmentIds[index].mimetype
                                        .contains('application/vnd.ms-excel')
                                    ?
                                    // open pdf
                                    createExcelFileFromString(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file)
                                        .then((path) async {
                                        await OpenFile.open(path);
                                      })
                                    :controller.detailModel.value
                                        .keyPerformanceAttachmentIds[index].mimetype
                                        .contains('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
                                    ?
                                    // open pdf
                                    createExFileFromString(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file)
                                        .then((path) async {
                                        await OpenFile.open(path);
                                      })
                                    :controller.detailModel.value
                                        .keyPerformanceAttachmentIds[index].mimetype
                                        .contains('application/msword')
                                    ?
                                    // open pdf
                                    createWordFileFromString(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file)
                                        .then((path) async {
                                        await OpenFile.open(path);
                                      })
                                      :controller.detailModel.value
                                        .keyPerformanceAttachmentIds[index].mimetype
                                        .contains('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
                                    ?
                                    // open pdf
                                    createDocxWordFileFromString(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file)
                                        .then((path) async {
                                        await OpenFile.open(path);
                                      })
                                    :
                                    await showDialog(
                                        context: context,
                                        builder: (_) {
                                          return ImageDialog(
                                            bytes: base64Decode(controller
                                            .detailModel
                                            .value
                                            .keyPerformanceAttachmentIds[index]
                                            .attached_file),
                                          );
                                        });
                          },
                          child: Card(
                            child: ListTile(
                              title: Text('${controller.detailModel.value.keyPerformanceAttachmentIds[index].name}'),
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
          /*  Container(
              // padding: EdgeInsets.only(left: 130, right: 30),
              padding: EdgeInsets.only(left: 40, right: 30),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 6, child: Text("Title", style: labelStyle())),
                  Expanded(
                    flex: 5,
                    child: Text((("employee_rate")), style: labelStyle()),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      (("final_rating")),
                      style: labelStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),*/

          /* Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _pmsDetailslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 9,
                                child: Text(_pmsDetailslist[index]["name"])),
                            Expanded(
                                flex: 5,
                                child:
                                    Text(_pmsDetailslist[index]["emp_rate"])),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 13, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.indigo)),
                                height: 30,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "0",
                                  ),
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  );
                },
              ),
            ),*/

          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
                  width: 200,
                  child: RaisedButton(
                    onPressed: () {
                      controller.clickDone(
                          controller.detailModel.value.id.toString(),controller.detailModel.value.state.toString());
                    },
                    color: Color.fromRGBO(58, 47, 112, 1),
                    child: Text(
                      (("Approve")),
                      style: buttonTextStyle(),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
