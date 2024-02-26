// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/announcements_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/announcements_details.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';

class RemindersList extends StatelessWidget {
  final AnnouncementsController controller = Get.put(AnnouncementsController());
  final box = GetStorage();
  int index;

  String image;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: appbar(context, labels?.reminders, image),
      body: Obx(
        () => NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                print("***bottomReach***");
                if (controller.reminderList.value.length >= 10) {
                  controller.offset.value += Globals.pag_limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
              }
            },
            child: ListView.builder(
              itemCount: controller.reminderList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.REMINDERS_DETAILS,
                              arguments: index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 11,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.reminderList.value[index].contents !=
                                          null
                                      ? Text(
                                          controller
                                              .reminderList.value[index].contents,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        )
                                      : Text('-',
                                      style: TextStyle(fontWeight: FontWeight.w500)),
                                  SizedBox(height: 5,),
                                  controller.reminderList.value[index]
                                              .description !=
                                          null && controller.reminderList.value[index]
                                              .description != false
                                      
                                      ? Text(
                                          controller.reminderList.value[index]
                                              .description,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Color(0XFFB7B7B7),
                                          fontWeight: FontWeight.w500),
                                        )
                                      : Text("-",
                                      style: TextStyle(color: Color(0XFFB7B7B7),
                                      fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.arrow_forward_ios))
                          ],
                        )),
                  ),
                );
              },
            )),
      ),
    );
  }

  void _loadData() {
    controller.getRemindersList();
  }
}
