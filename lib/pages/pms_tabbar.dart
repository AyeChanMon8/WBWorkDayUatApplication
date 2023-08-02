// @dart=2.9

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/bottom_navigation.dart';
import 'package:winbrother_hr_app/pages/leave_list.dart';
import 'package:winbrother_hr_app/pages/pms_done_page.dart';
import 'package:winbrother_hr_app/pages/pms_manager_page.dart';
import 'package:winbrother_hr_app/pages/pms_page.dart';
import 'package:winbrother_hr_app/pages/travel_list.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PmsTabBar extends StatefulWidget {
  @override
  _StatePmsTabBar createState() => _StatePmsTabBar();
}

class _StatePmsTabBar extends State<PmsTabBar> {
  final box = GetStorage();

  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  int tabbar = 1;
  String role = '';
  @override
  void initState() {
    super.initState();
    role = box.read('role_category');
    List<String> result = getRole(role);
    if (result.isNotEmpty) {
      if (findUserRole(result, 'manager') != -1) {
        role = 'manager';
      } else if (findUserRole(result, 'dotted_line_manager') != -1) {
        role = 'dotted_line_manager';
      }
    }
    tabbar = role == 'manager' || role == 'dotted_line_manager' ? 3 : 1;
  }

  int findUserRole(List<String> roleList, String data) {
    return roleList.indexOf('$data');
  }

  List<String> getRole(String data) {
    int index = data.indexOf(',');
    List<String> result = [];
    if (index != -1) {
      result = data.split(',');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      initialIndex: 0,
      length: tabbar,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels?.pms, style: appbarTextStyle()),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  }),
              actions: <Widget>[],
              automaticallyImplyLeading: true,
              bottom: role == 'manager' || role == 'dotted_line_manager'
                  ? TabBar(
                      labelColor: Colors.white,
                      indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                      indicatorWeight: 5,
                      tabs: [
                        Tab(
                          text: labels.self,
                        ),
                        Tab(text: labels.toApprove),
                        Tab(text: labels.approved),
                      ],
                    )
                  : TabBar(
                      labelColor: Colors.white,
                      indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                      indicatorWeight: 5,
                      tabs: [
                        Tab(
                          text: labels.self,
                        ),
                      ],
                    )),
          body: role == 'manager' || role == 'dotted_line_manager'
              ? TabBarView(
                  children: [PmsPage(), PmsManagerPage(), PmsDonePage()],
                )
              : TabBarView(
                  children: [
                    PmsPage(),
                  ],
                )),
    );
  }
}
