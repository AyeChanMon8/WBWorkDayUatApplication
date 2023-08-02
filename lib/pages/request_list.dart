// @dart=2.9

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/my_class/theme.dart';
import 'package:winbrother_hr_app/pages/create_request_page.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';

class RequestListPage extends StatefulWidget {
  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(
            FontAwesomeIcons.plus,
            color: barBackgroundColorStyle,
          ),
          backgroundColor: selectedItemBackgroundColorStyle,
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CreateRequestPage()));

            Get.toNamed(Routes.EXPENSE_PAGE);
          }),
      appBar: appbar(
        context,
        labels?.allRequests,
          user_image
      ),
      body: Container(
        child: myListView(context),
      ),
    );
  }

  Widget myListView(BuildContext context) {
    final titles = [
      'trip',
      'breakfast',
      'lunch',
      'car oil',
      'water ',
      'foods',
      'beer',
      'tier',
    ];
    final subtitles = [
      'YGN To MDY',
      'Feel Restaurant',
      'Feel Restaurant',
      'PT Power',
      'City Express ',
      'Feel Restaurant',
      'Win Restaurant',
      'PT Service',
    ];

    final icons = [
      Icons.directions_bike,
      Icons.directions_boat,
      Icons.directions_bus,
      Icons.directions_car,
      Icons.directions_railway,
      Icons.directions_run,
      Icons.directions_subway,
      Icons.directions_transit,
      Icons.directions_walk
    ];

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          //                           <-- Card widget
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text(titles[index]),
            subtitle: Text(subtitles[index]),
          ),
        );
      },
    );
  }
}
