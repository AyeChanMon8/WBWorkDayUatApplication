// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/approval_route_list.dart';
import 'package:winbrother_hr_app/pages/approved_route_list.dart';

class RouteApprovalTabBar extends StatefulWidget {
  @override
  _StateRouteApprovalTabBar createState() => _StateRouteApprovalTabBar();
}

class _StateRouteApprovalTabBar extends State<RouteApprovalTabBar> {

  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  int tabbar;
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
              title: Text(labels?.route, style: appbarTextStyle()),
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
              ApprovalRouteList(),
              ApprovedRouteList(),
            ],
          )
      ),
    );
  }
}