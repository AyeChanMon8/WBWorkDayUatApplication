import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/leave.dart';
import 'package:winbrother_hr_app/models/leave_line.dart';
import 'package:winbrother_hr_app/models/leave_list_response.dart';
import 'package:winbrother_hr_app/models/leave_report.dart';
import 'package:winbrother_hr_app/models/leave_type.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'Validator.dart';

void main() async {

  test('leaveReport', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    List<LeaveReport> leavelist = await leaveService.getLeaveReport(2);
    expect(validator.checkListNotEmpty(leavelist), ValiationResult.VALID);
  });

  test('leaveTypeList', () async {
    final validator = Validator();
    MasterService masterService = await MasterService().init();
    List<LeaveType> leave_type = await masterService.getLeaveType();
    expect(validator.checkListNotEmpty(leave_type), ValiationResult.VALID);
  });

  test('getleaveList', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    List<LeaveListResponse> leave_list = await leaveService.getLeaveList('6115',"5");
    expect(validator.checkListNotEmpty(leave_list), ValiationResult.VALID);
  });

  test('approveLeave', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    bool list = await leaveService.approveLeave(108);
    // expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('submitLeave', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    String list = await leaveService.submitLeave(106);
    // expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('secondApproveLeave', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    bool list = await leaveService.secondApproveLeave(66);
    // expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('fetchLeaveLine', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    Leave leave = Leave(
      employee_id: 3,
      start_date: "2020-09-06",
      end_date: "2020-09-08",
    );
    List<LeaveLine> list = await leaveService.getLeaveLine(leave);
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('updateLeaveLine', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    LeaveLine leave_line = LeaveLine(
        dayofweek: '5',
        request_date: '2020-10-05',
        date: '2020-10-05',
        distinct_shift: 'whole',
        full: false,
        first: false,
        second: false,
        start_date: "2020-09-05 06:00:00",
        end_date: "2020-09-05 18:00:00",
        this_day_hour_id: 353,
        next_day_hour_id: 0,
        resource_calendar_id: 16);
    LeaveLine leaveLine = await leaveService.updateLeaveLine(leave_line);
    expect(validator.checkLeaveLineNotEmpty(leaveLine), ValiationResult.VALID);
  });

  test('fetchLeaveForManager', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    List<LeaveListResponse> list = await leaveService.getLeaveListForManager(2);
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });

  test('checkLeaveApprovalId', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    int employee_id = 2;
    String state = "submit";
    List<dynamic> emp_id = await leaveService.getLeaveIDsList("2");
    expect(validator.checkListNotEmpty(emp_id), ValiationResult.VALID);
  });
  test('addAttachment', () async {
    final validator = Validator();
    LeaveService leaveService = await LeaveService().init();
    await leaveService.addAttachment(Leave(attachment: ""),1);
    //expect(validator.checkListNotEmpty(leave_list), ValiationResult.VALID);
  });

}
