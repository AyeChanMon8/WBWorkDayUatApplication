import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/attendance.dart';
import 'package:winbrother_hr_app/models/attendance_request.dart';
import 'package:winbrother_hr_app/services/attendance_service.dart';


import 'Validator.dart';

void main() async {

  test('checkApprovalIdforAttendance', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    int employee_id = 2;
    String state = "draft";
    List<dynamic> emp_id = await attendanceService.getAttanIDsList("2");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });

  test('getAttendanceEarlyOutList', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    List<dynamic> list = await attendanceService.getAttendanceEarlyReport(2);

    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('getAttendanceEmployeeHistoryList', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    List<dynamic> list = await attendanceService.getAttendanceEmployeeHistoryList(5191,'');
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('getOwnAtendance', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    List<Attendance> attendance_list =
    await attendanceService.getOwnAtendance(5191,"0");
    expect(validator.checkListNotEmpty(attendance_list), ValiationResult.VALID);
  });

  test('getAttendanceRequestToApprove', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    List<Attendance> attendance_list = await attendanceService.getAttendanceRequestToApprove("5191","");
    expect(validator.checkListNotEmpty(attendance_list), ValiationResult.VALID);
  });
  test('getEmployeeListForApprovalManager', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    List<dynamic> empIDS = await attendanceService.getEmployeeListForApprovalManager(5191);
    expect(validator.checkListNotEmpty(empIDS), ValiationResult.VALID);
  });
  test('createAttendance', () async {
    final validator = Validator();
    AttendanceService attendanceService = await AttendanceService().init();
    AttendanceRequest attendanceRequest = AttendanceRequest(
        fingerprint_id: "1001",
        employee_id: 2,
        check_in: "2020-10-12 14:50:11");
    bool created =
    await attendanceService.createAttendanceCheckIn(attendanceRequest);
    expect(validator.checkSuccessCreate(created), ValiationResult.VALID);
  });

}
