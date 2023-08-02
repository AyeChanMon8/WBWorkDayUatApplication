import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/depart_empids.dart';
import 'package:winbrother_hr_app/models/employee.dart';
import 'package:winbrother_hr_app/models/insurance.dart';
import 'package:winbrother_hr_app/models/loan.dart';
import 'package:winbrother_hr_app/models/document.dart';

import 'package:winbrother_hr_app/models/odoo_instance.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/models/reward.dart';
import 'package:winbrother_hr_app/models/warning.dart';
import 'package:winbrother_hr_app/services/attendance_service.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'package:winbrother_hr_app/services/document_service.dart';
import 'package:winbrother_hr_app/services/overtime_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'Validator.dart';

void main() async {
  test('Testing odoo Services', () async {
    OdooService odooService = OdooService();
    OdooInstance odooInstance = await odooService.getOdooInstance();
    print(odooInstance.user.access_token);
    expect(odooInstance.connected, true);
    expect(odooInstance.user.uid, 2);
  });

 /* test('Get document list', () async {
    final validator = Validator();
    DocumentService empService = await DocumentService().init();
    List<Documents> list = await empService.getDocList("2");
    expect(validator.checkListNotEmpty(list), ValiationResult.VALID);
  });*/
 /* test('Get document', () async {
    final validator = Validator();
    DocumentService empService = await DocumentService().init();
    Documents list = await empService.getDocD("6");
    expect(validator.checkDoc(list), ValiationResult.VALID);
  });*/
}
