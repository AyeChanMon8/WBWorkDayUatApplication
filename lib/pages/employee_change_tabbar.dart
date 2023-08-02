//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/controllers/employee_change_controller.dart';
import 'package:winbrother_hr_app/controllers/leave_report_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';

import 'employee_changes_list.dart';

class EmployeeChangeTabBar extends StatefulWidget {
  @override
  _EmployeeChangeTabBarState createState() => _EmployeeChangeTabBarState();
}
class _EmployeeChangeTabBarState extends State<EmployeeChangeTabBar> {
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Employee Changes', style: appbarTextStyle()),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: <Widget>[],
          automaticallyImplyLeading: true,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Color.fromRGBO(216, 181, 0, 1),
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: labels?.open,
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            EmployeeChangeList(),

          ],
        ),
      ),
    );
  }
}
