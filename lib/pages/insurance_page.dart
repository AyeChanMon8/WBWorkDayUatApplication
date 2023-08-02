// @dart=2.9

// import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/controllers/insurance.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/insurancemodel.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/my_class/theme.dart';
import 'package:winbrother_hr_app/pages/employee_claim_insurance_list_page.dart';
import 'package:winbrother_hr_app/pages/employee_insurance_list_page.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';

class InsurancePage extends StatefulWidget {
  @override
  _InsurancePageState createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  @override
  Widget build(BuildContext context) {
    // index = Get.arguments;
    final labels = AppLocalizations.of(context);
     return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels?.insurance, style: appbarTextStyle()),
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
              bottom:TabBar(
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: 'Self Insurance',
                  ),
                  Tab(text: 'Claim Insurance'),
                ],
              ),
          ),
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text(labels?.insurance, style: appbarTextStyle()),
          //     leading: IconButton(
          //         icon: Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Get.back();
          //         }),
          //     actions: <Widget>[],
          //     automaticallyImplyLeading: true,
          //     bottom:TabBar(
          //       labelColor: Colors.white,
          //       indicatorColor: Color.fromRGBO(216, 181, 0, 1),
          //       indicatorWeight: 5,
          //       tabs: [
          //         Tab(
          //           text: 'Self Insurance',
          //         ),
          //         Tab(text: 'Claim Insurance'),
          //       ],
          //     )),
          body:  TabBarView(
            children: [
             EmployeeInsuranceListPage(),
             EmployeeClaimInsuranceListPage(),
            ],
          )
             ),
    );
  }
}
