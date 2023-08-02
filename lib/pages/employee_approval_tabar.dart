// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/approval_employee_change_list.dart';
import 'package:winbrother_hr_app/pages/approval_loan_list.dart';
import 'package:winbrother_hr_app/pages/approval_route_list.dart';
import 'package:winbrother_hr_app/pages/approved_employee_change_list.dart';
import 'package:winbrother_hr_app/pages/approved_loan_list.dart';
import 'package:winbrother_hr_app/pages/approved_route_list.dart';
import 'package:winbrother_hr_app/pages/first_approval_employee_change_list.dart';

class EmployeeChangeApprovalTabBar extends StatefulWidget {
  @override
  _StateEmployeeChangeApprovalTabBar createState() => _StateEmployeeChangeApprovalTabBar();
}

class _StateEmployeeChangeApprovalTabBar extends State<EmployeeChangeApprovalTabBar> {

  int tabbar;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels.employeeChanges, style: appbarTextStyle()),
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
                    text: labels.firstApprove,
                  ),
                  Tab(
                    text: labels.toApprove,
                  ),
                  Tab(text: labels?.approved),
                ],
              )
          ),
          body: TabBarView(
            children: [
              FirstApprovalEmployeeChangeList(),
              ApprovalEmployeeChangeList(),
              ApprovedEmployeeChangeList(),
            ],
          )
      ),
    );
  }
}