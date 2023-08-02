// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/announcement_approval_page.dart';
import 'package:winbrother_hr_app/pages/approval_list.dart';
import 'package:winbrother_hr_app/pages/leave_approved_list.dart';
import 'package:winbrother_hr_app/pages/warning_approval_page.dart';
import 'package:winbrother_hr_app/pages/warning_page.dart';

class AnnouncementApprovalTabBar extends StatefulWidget {
  @override
  _StateAnnouncementApprovalTabBar createState() => _StateAnnouncementApprovalTabBar();
}

class _StateAnnouncementApprovalTabBar extends State<AnnouncementApprovalTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              shadowColor: Colors.white,
              title: Text(labels?.announcements, style: appbarTextStyle()),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                    //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                  }),
              actions: <Widget>[],
              automaticallyImplyLeading: true,
              bottom:  TabBar(
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: labels.toApprove,
                  ),
                  Tab(text: labels?.approved),
                ],
              )
          ),
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text(labels?.announcements, style: appbarTextStyle()),
          //     leading: IconButton(
          //         icon: Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Get.back();
          //           //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
          //         }),
          //     actions: <Widget>[],
          //     automaticallyImplyLeading: true,
          //     bottom:  TabBar(
          //       labelColor: Colors.white,
          //       indicatorColor: Color.fromRGBO(216, 181, 0, 1),
          //       indicatorWeight: 5,
          //       tabs: [
          //         Tab(
          //           text: "To Approve",
          //         ),
          //         Tab(text: labels?.approved),
          //       ],
          //     )
          //
          // ),
          body: TabBarView(
            children: [
             AnnouncementApprovalPage('approval'),
             AnnouncementApprovalPage('approved'),
            ],
          )
      ),
    );
  }
}