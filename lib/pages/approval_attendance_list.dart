// @dart=2.9

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/controllers/leave_list_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';

import 'approval_details.dart';

class ApprovalAttendanceList extends StatefulWidget {
  @override
  _ApprovalAttendanceListState createState() => _ApprovalAttendanceListState();
}

class _ApprovalAttendanceListState extends State<ApprovalAttendanceList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image;
  int index;
  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: appbar(context, labels.attendanceApprovalList, image),
      body: ListView.builder(
        itemCount: controller.attendanceApprovalList.value.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.APPROVAL_ATTENDANCE_DETAILS,
                      arguments: index);
                },
                child: ListTile(
                    // leading: CircleAvatar(
                    //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                    //   child: ClipRRect(
                    //     borderRadius: new BorderRadius.circular(50.0),
                    //     child: controller.attendanceApprovalList.value[index]
                    //                 .employee_id.image_128 !=
                    //             null
                    //         ? new Image.memory(
                    //             base64Decode(controller.attendanceApprovalList
                    //                 .value[index].employee_id.image_128),
                    //             fit: BoxFit.contain)
                    //         : new Container(),
                    //   ),
                    // ),
                    // leading:
                    title: Text(controller
                        .attendanceApprovalList.value[index].employee_id.name),
                    subtitle: Text(controller
                            .attendanceApprovalList.value[index].check_in +
                        " - " +
                        controller
                            .attendanceApprovalList.value[index].check_out),
                    trailing: arrowforwardIcon),
              ),
            ),
          );
        },
      ),
    );
  }
}
