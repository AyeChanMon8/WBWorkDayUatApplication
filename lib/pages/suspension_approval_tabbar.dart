// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';

import 'approval_suspension_list.dart';
import 'approved_suspension_list.dart';


class SuspensionApprovalTabBar extends StatefulWidget {
  @override
  _StateSuspensionApprovalTabBar createState() => _StateSuspensionApprovalTabBar();
}

class _StateSuspensionApprovalTabBar extends State<SuspensionApprovalTabBar> {

  int tabbar;
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels.suspension, style: appbarTextStyle()),
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
          body: TabBarView(
            children: [
              ApprovalSuspensionList(),
              ApprovedSuspensionList(),
            ],
          )
      ),
    );
  }
}