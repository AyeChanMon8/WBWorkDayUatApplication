import 'package:get/get.dart';
import 'package:winbrother_hr_app/bindings/base_binding.dart';
import 'package:winbrother_hr_app/controllers/attendance_report_controller.dart';
import 'package:winbrother_hr_app/controllers/auth_controller.dart';
import 'package:winbrother_hr_app/controllers/leave_list_controller.dart';
import 'package:winbrother_hr_app/controllers/leave_report_controller.dart';
import 'package:winbrother_hr_app/controllers/leave_request_controller.dart';
import 'package:winbrother_hr_app/controllers/organization_chart_controller.dart';
import 'package:winbrother_hr_app/controllers/overtime_list_controller.dart';
import 'package:winbrother_hr_app/controllers/overtime_response_controller.dart';
import 'package:winbrother_hr_app/controllers/overtime_tabbar_conroller.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/controllers/travel_list_controller.dart';
import 'package:winbrother_hr_app/controllers/travel_request_controller.dart';
import 'package:winbrother_hr_app/controllers/user_profile_controller.dart';
import 'package:winbrother_hr_app/controllers/overtime_request_controller.dart';
import 'package:winbrother_hr_app/pages/overtime_list_tabbar.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';

import '../controllers/overtime_response_list_controller.dart';
import '../controllers/overtime_list_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<PmsListController>(() => PmsListController());
    Get.lazyPut<OrganizationalChartController>(
        () => OrganizationalChartController());
    Get.lazyPut<AttendanceReportController>(() => AttendanceReportController());
  }
}
