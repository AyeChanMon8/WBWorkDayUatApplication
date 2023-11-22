// @dart=2.9

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/models/calendar_data.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:intl/intl.dart';

class CalendarService extends OdooService{
  Dio dioClient;
  @override
  Future<CalendarService> init() async {
    print('AttendanceService has been initialize');
    dioClient = await client();
    return this;
  }
  Future<CalendarData> getCalendarInformation(int empId)async{
    var calendarData;
    String start_date = AppUtils.onemonthago().toString().split(' ')[0];
    String end_date = AppUtils.onemonthpre().toString().split(' ')[0];
    var current_date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    String url = Globals.baseURL+"/summary.request/388/get_employee_calendar_date_new";

    // Response response = await dioClient.put(url,data: jsonEncode({"employee_id": empId, "start_date": start_date,"end_date":end_date}));
    Response response = await dioClient.put(url,data: jsonEncode({"employee_id": empId, "start_date": start_date,"end_date":end_date,"current_date":current_date}));

    if(response.statusCode == 200){
       calendarData = CalendarData.fromJson(response.data);
    }

    return calendarData;
  }
}