// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/announcements_controller.dart';
import 'package:winbrother_hr_app/controllers/reminder_noti_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/announcements_details.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class RemindersList extends StatefulWidget {
  @override
  _RemindersListState createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  final ReindersNotiController controller = Get.put(ReindersNotiController());

  final box = GetStorage();

  int index;

  String image;
  String selectall = "Select All";

  void initData() async {
    await controller.getRemindersList();
  }

  @override
  void initState() {
    initData();
    super.initState();
    controller.offset.value = 0;
    handleNotification();
  }

  void handleNotification() async {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification

      this.setState(() {
        //TODO put data to one of controller for notification messages.
        try {
          // var data = event.notification.additionalData;
          // String message =
          // event.notification.jsonRepresentation().replaceAll("\\n", "\n");

          String message_type = null;
          Map<String, dynamic> dataMap = event.notification.additionalData;
          if (dataMap != null && dataMap.length > 0) {
            message_type = dataMap["type"];
          }

          if (message_type != null && message_type == "noti") {
            controller.getRemindersList();
            String title = event.notification.title;
            String body = event.notification.body;
            Get.snackbar("Notification $title", body);
          }
        } catch (error) {}
      });
      event.complete(event.notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: appbar(context, labels?.reminders, image),
      body: Stack(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GFButton(
                  onPressed: () {
                    controller.reminderList.forEach((element) {
                      element.selected = true;
                    });
                    setState(() {
                      if (selectall == 'Select All') {
                        selectall = 'Unselect All';
                      } else {
                        selectall = 'Select All';
                        controller.reminderList.forEach((element) {
                          element.selected = false;
                        });
                      }
                    });
                  },
                  child: Text(selectall),
                ),
                SizedBox(
                  width: 10,
                ),
                GFButton(
                  onPressed: () {
                    setState(() {
                      selectall = 'Select All';
                    });
                    for (int index = 0;
                        index < controller.reminderList.length;
                        index++) {
                      if (controller.reminderList[index].selected)
                        controller.readMsg(
                            controller.reminderList[index], index);
                    }
                  },
                  child: Text('Read All'),
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                GFButton(
                    onPressed: () {
                      print("deleteAll#");
                      print(controller.reminderList.length);
                      controller.reminderList.forEach((element) {
                        element.selected = true;
                      });
                      controller.deleteConfirm();
                    },
                    child: Text('Delete All'),
                    color: Colors.red),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 2, right: 2, bottom: 2, top: 50),
                        child: Obx(
                          () => NotificationListener<ScrollNotification>(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!controller.isLoading.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  controller.offset.value += Globals.pag_limit;
                                  controller.isLoading.value = true;
                                  //_loadData();
                                }
                              },
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: Color(0xffCCCCCC),
                                  height: 1,
                                ),
                                controller: controller.scrollController,
                                itemBuilder: (context, index) {
                                  var dateValue = '';

                                  var date = DateFormat("yyyy-MM-dd HH:mm:ss")
                                      .parse(
                                          controller
                                              .reminderList[index].create_date,
                                          true);
                                  dateValue = date.toLocal().toString();

                                  return Dismissible(
                                    key: Key(controller
                                        .reminderList[index].noti_id
                                        .toString()),
                                    child: InkWell(
                                      onLongPress: () {
                                        controller.readMsg(
                                            controller.reminderList[index],
                                            index);
                                      },
                                      onDoubleTap: () {
                                        controller.readMsg(
                                            controller.reminderList[index],
                                            index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                            value: controller
                                                                .reminderList[
                                                                    index]
                                                                .selected,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                controller
                                                                    .reminderList[
                                                                        index]
                                                                    .selected = value;
                                                              });
                                                            })),
                                                    controller
                                                            .reminderList[index]
                                                            .has_read
                                                        ? Icon(
                                                            Entypo.dot_single,
                                                            color: Colors
                                                                .transparent,
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Entypo.dot_single,
                                                            color: Color(
                                                                0xff1D84F9),
                                                            size: 30,
                                                          ),
                                                  ],
                                                )),
                                            /* Expanded(
                                                  flex:1,
                                                  child: Visibility(
                                                      visible: controller
                                                          .notificationList[index]
                                                          .subTitle !=
                                                          null,
                                                      child: Text(controller
                                                          .notificationList[index]
                                                          .subTitle)),
                                                ),*/
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                      controller
                                                          .reminderList[index]
                                                          .contents,
                                                      style: controller
                                                              .reminderList[
                                                                  index]
                                                              .has_read
                                                          ? TextStyle(
                                                              color: Colors
                                                                  .grey[900])
                                                          : TextStyle(
                                                              // fontWeight:
                                                              // FontWeight.bold,
                                                              color: Colors
                                                                  .black)),
                                                  controller.reminderList[index].lastReminder
                                                      ? (controller
                                                                      .reminderList
                                                                      .value[
                                                                          index]
                                                                      .description !=
                                                                  null &&
                                                              controller
                                                                      .reminderList
                                                                      .value[
                                                                          index]
                                                                      .description !=
                                                                  false
                                                          ? AutoSizeText(
                                                              controller
                                                                  .reminderList
                                                                  .value[index]
                                                                  .description,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFFB7B7B7),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          : SizedBox())
                                                      : SizedBox()
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                  AppUtils.timeInfo(dateValue)),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  controller.deleteMsg(
                                                      controller
                                                          .reminderList[index],
                                                      index);
                                                },
                                                child: Icon(
                                                  MaterialCommunityIcons
                                                      .trash_can,
                                                  color: Colors.red,
                                                )),
                                            SizedBox(width: 3,),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes.REMINDERS_DETAILS,
                                                      arguments: index);
                                                },
                                                child: Icon(
                                                  MaterialCommunityIcons
                                                      .information,
                                                  color: Color.fromRGBO(60, 47, 126, 1),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    background: slideRightBackground(index),
                                    secondaryBackground:
                                        slideLeftBackground(index),
                                    confirmDismiss: (direction) async {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        final bool res = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                    "Are you sure you want to delete?"),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      //setState(() {
                                                      controller.reminderList
                                                          .removeAt(index);
                                                      //});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                        return res;
                                      } else {
                                        controller.readMsg(
                                            controller.reminderList[index],
                                            index);
                                        //setState(() {
                                        controller.reminderList.removeAt(index);
                                        // });
                                      }
                                      return null;
                                    },
                                  );
                                },
                                itemCount: controller.reminderList.length,
                              )),
                        ))),
              ],
            ),
          ),
          // Obx(
          //   () => NotificationListener<ScrollNotification>(
          //       // ignore: missing_return
          //       onNotification: (ScrollNotification scrollInfo) {
          //         if (!controller.isLoading.value &&
          //             scrollInfo.metrics.pixels ==
          //                 scrollInfo.metrics.maxScrollExtent) {
          //           print("***bottomReach***");
          //           if (controller.reminderList.value.length >= 10) {
          //             controller.offset.value += Globals.pag_limit;
          //             controller.isLoading.value = true;
          //             _loadData();
          //           }
          //         }
          //       },
          //       child: ListView.builder(
          //         itemCount: controller.reminderList.value.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Card(
          //             child: Container(
          //               padding: EdgeInsets.all(8),
          //               child: InkWell(
          //                   onTap: () {
          //                     Get.toNamed(Routes.REMINDERS_DETAILS,
          //                         arguments: index);
          //                   },
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Expanded(
          //                         flex: 11,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [
          //                             controller.reminderList.value[index].contents !=
          //                                     null
          //                                 ? Text(
          //                                     controller
          //                                         .reminderList.value[index].contents,
          //                                     overflow: TextOverflow.ellipsis,
          //                                     style: TextStyle(fontWeight: FontWeight.w500),
          //                                   )
          //                                 : Text('-',
          //                                 style: TextStyle(fontWeight: FontWeight.w500)),
          //                             SizedBox(height: 5,),
          //                             controller.reminderList.value[index].lastReminder ? (controller.reminderList.value[index]
          //                                         .description !=
          //                                     null && controller.reminderList.value[index]
          //                                         .description != false

          //                                 ? Text(
          //                                     controller.reminderList.value[index]
          //                                         .description,
          //                                     overflow: TextOverflow.ellipsis,
          //                                     style: TextStyle(color: Color(0XFFB7B7B7),
          //                                     fontWeight: FontWeight.w500),
          //                                   )
          //                                 : Text("-",
          //                                 style: TextStyle(color: Color(0XFFB7B7B7),
          //                                 fontWeight: FontWeight.w500))) : Text('-',style: TextStyle(color: Color(0XFFB7B7B7),
          //                                 fontWeight: FontWeight.w500))
          //                           ],
          //                         ),
          //                       ),
          //                       Expanded(
          //                         flex: 1,
          //                         child: Icon(Icons.arrow_forward_ios))
          //                     ],
          //                   )),
          //             ),
          //           );
          //         },
          //       )),
          // ),
        ],
      ),
    );
  }

  Widget slideLeftBackground(int index) {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                controller.deleteMsg(controller.reminderList[index], index);
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground(int index) {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                controller.readMsg(controller.reminderList[index], index);
              },
              child: Icon(
                FontAwesomeIcons.inbox,
                color: Colors.white,
              ),
            ),
            Text(
              " Read",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  void _loadData() {
    controller.getRemindersList();
  }
}
