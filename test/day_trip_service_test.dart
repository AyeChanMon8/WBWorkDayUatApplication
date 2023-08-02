import 'package:flutter_test/flutter_test.dart';
import 'package:winbrother_hr_app/models/day_trip_expense_line.dart';
import 'package:winbrother_hr_app/models/day_trip_model.dart';
import 'package:winbrother_hr_app/models/daytrip_advance_expense_category.dart';
import 'package:winbrother_hr_app/models/daytrip_expense.dart';
import 'package:winbrother_hr_app/models/odoo_instance.dart';
import 'package:winbrother_hr_app/models/stock_location.dart';
import 'package:winbrother_hr_app/services/daytrip_service.dart';
import 'package:winbrother_hr_app/services/odoo_service.dart';
import 'Validator.dart';

void main() async {
  test('Testing odoo Services', () async {
    OdooService odooService = OdooService();
    OdooInstance odooInstance = await odooService.getOdooInstance();
    print(odooInstance.user.access_token);
    expect(odooInstance.connected, true);
    expect(odooInstance.user.uid, 2);
  });
  test('getDayTripExpenseList', () async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<Daytrip_expense> day_trip_list = await daytripService.getDayTripExpenseList(8.toString());
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });
  test('getStockLocationList', () async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<Stock_location> day_trip_list = await daytripService.getStockLocationList();
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });

  test('getProductListForProductTab', () async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<Daytrip_expense> day_trip_list = await daytripService.getDayTripProductListForProductTab(1.toString());
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });

  test('getDayTripProductListForFuelTab', () async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<Daytrip_expense> day_trip_list = await daytripService.getDayTripProductListForFuelTab(1.toString());
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);
  });

  test('addExpense',() async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    int day_trip_list = await daytripService.addExpense(Expense(productId: 24),"2",2);
    expect(validator.checkIdReturn(day_trip_list), ValiationResult.VALID);

  });

  test('getDayTripList',() async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<DayTripModel> day_trip_list = await daytripService.getDayTripList(6115,"0","0");
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);

  });

  test('getDayTripExpenseCategoryList',() async {
    final validator = Validator();
    DayTripServie daytripService = await DayTripServie().init();
    List<Daytrip_advance_expense_category> day_trip_list = await daytripService.getDayTripAdvanceExpenseCategory(1);
    expect(validator.checkListNotEmpty(day_trip_list), ValiationResult.VALID);

  });


}
