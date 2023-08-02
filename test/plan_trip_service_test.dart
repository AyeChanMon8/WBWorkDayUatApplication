import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/day_trip_expense_line.dart';
import 'package:winbrother_hr_app/models/day_trip_model.dart';
import 'package:winbrother_hr_app/models/daytrip_advance_expense_category.dart';
import 'package:winbrother_hr_app/models/daytrip_expense.dart';
import 'package:winbrother_hr_app/models/odoo_instance.dart';
import 'package:winbrother_hr_app/models/stock_location.dart';
import 'package:winbrother_hr_app/services/daytrip_service.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'package:winbrother_hr_app/services/plan_trip_service.dart';
import 'Validator.dart';

void main() async {
  test('Testing odoo Services', () async {
    OdooService odooService = OdooService();
    OdooInstance odooInstance = await odooService.getOdooInstance();
    print(odooInstance.user.access_token);
    expect(odooInstance.connected, true);
    expect(odooInstance.user.uid, 2);
  });

  test('getPlanTripWithProductList', () async {
    final validator = Validator();
    PlanTripServie planTripServie = await PlanTripServie().init();
    List<dynamic> day_trip_list =
        await planTripServie.getPlanTripWithProductList(6115, "0", "0");
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });
  test('getPlanTripWithWayBillList', () async {
    final validator = Validator();
    PlanTripServie planTripServie = await PlanTripServie().init();
    List<dynamic> day_trip_list =
        await planTripServie.getPlanTripWithWayBillList(6115, "0", "0");
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });

  test('getPlanTripWithWayBillIdList', () async {
    final validator = Validator();
    PlanTripServie planTripServie = await PlanTripServie().init();
    List<dynamic> day_trip_list =
        await planTripServie.getPlanTripWithWayBillIdsList(6115, "0");
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });

  test('getPlanTripWithProductIdList', () async {
    final validator = Validator();
    PlanTripServie planTripServie = await PlanTripServie().init();
    List<dynamic> day_trip_list =
        await planTripServie.getPlanTripWithProductIdList(6115, "0");
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });
}
