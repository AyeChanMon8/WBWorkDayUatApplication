// @dart=2.9

import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/daytrip_plantrip_fuel_advance_controller.dart';
import 'package:winbrother_hr_app/controllers/plan_trip_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/base_route.dart';
import 'package:winbrother_hr_app/models/plantrip_waybill.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_line_list_model.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/add_advance_page.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import 'add_fuel_waybill_page.dart';

class PlanTripWayBillDetails extends StatefulWidget {
  @override
  _PlanTripWayBillDetailsState createState() => _PlanTripWayBillDetailsState();
}

class _PlanTripWayBillDetailsState extends State<PlanTripWayBillDetails> with SingleTickerProviderStateMixin {
  final PlanTripController controller = Get.put(PlanTripController());
  var box = GetStorage();
  String image;
  int groupValue = 0;
  TabController _tabController;
  var arg_index;
  var isDriver = false;
  var is_spare = false;
  var is_branch_manager = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  var next_route_id = 0;
  var previous_route_id = 0;
  var plantrip_waybill_list_lines = [];
  var to_date;
  var isIncharge = false;
  var employee_id;
  @override
  void initState() {
    if(Get.arguments!=null){
      isDriver = box.read("is_driver");
      employee_id = box.read('emp_id');
      if(box.read('real_role_category').toString().contains('branch manager')){
        print('contains#');
        is_branch_manager = true;
      }else{
        is_branch_manager = false;
      }
      if(box.read('real_role_category').toString().contains('spare')){
        is_spare = true;
      }else{
        is_spare = false;
      }
      //controller.planTripWayBillModel = Get.arguments;
      controller.arg_index.value = Get.arguments;
      if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds.length>0){
        controller.selectedWayBillExpenseRouteCategory = controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[0];
      }
      if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds.length>0){
        controller.selectedWayBillRoute = controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds[0];
      }
      controller.waybill_expense_list.value = controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds;
      if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId.inchargeId!=null && controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId.inchargeId.id == int.parse(employee_id)){
                isIncharge = true;
      }
     
    }
    controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'?
    _tabController = TabController(length: 3, vsync: this):
    controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'? _tabController = TabController(length: 5, vsync: this):
    _tabController = TabController(length: 6, vsync: this);
    controller.fetchExpenseStatusData(controller.plantrip_with_waybill_list[controller.arg_index.value].id,'plantrip_waybill');
    controller.getRouteList(controller.plantrip_with_waybill_list[controller.arg_index.value].id.toString(),'plantrip_waybill');
    controller.calculateTotalExpense(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds);
    
    super.initState();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  //   plantrip_waybill_list_lines= [];
  //   next_route_id = 0;
  // }
  Widget routeContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex : 1,
                child: Text(labels.route,style: maintitleStyle(),)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2,right: 0,left: 0),
          child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
        ),
        controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' && (controller.plantrip_with_waybill_list[controller.arg_index.value].driverId.id == int.parse(employee_id)) ? Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: routeListWidget(context),
        ): SizedBox(),
        controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' && (isDriver || is_spare) ?Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: tripRouteListWidget(context),
        ):SizedBox(),
      ],
    );
  }

  Widget tripRouteListWidget(BuildContext context) {
    
    int fields;
    return Container(
      
      child: Obx(() {
        
        return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds.length,
        itemBuilder: (BuildContext context, int index1) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].routeId.name
                            .toString()
                        ),
                      ),
                    ),
                    Expanded(
                    flex: 3,
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].startActualDate!=null ? Text(AppUtils.changeDateAndTimeFormat(
                controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].startActualDate)): SizedBox(),
                        )),
                  ),
                   Expanded(
                    flex: 3,
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].endActualDate!=null ? Text(AppUtils.changeDateAndTimeFormat(
                controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].endActualDate)): SizedBox()
                        )),
                  ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].status!=null ?Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child:  Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index1].status),
                    ),
                  ): SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );}),
    );
  }

  Widget commisionContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Text(labels.commissionDriver,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),

                  Expanded(
                      flex: 2,
                      child: Text(labels.commissionSpare,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),

                  // Expanded(
                  //   flex: 2,
                  //   child: SizedBox()
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),

            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: productListWidget(context),
              ),
            ),
          ],
        )
    );
  }
  Widget wayBillContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels.invoice,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.customer,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.date,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.state,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: wayBillListWidget(context),
              ),
            ),
          ],
        )
    );
  }
  Widget expenseContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5,top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 2,
                      child: Text(labels.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 2,
                      child: Text(labels.routeExpense,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.stdAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.actualAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.overAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                      //flex: 1,
                      child: SizedBox()
                  ): SizedBox(),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                      //flex: 1,
                      child: SizedBox()
                  ):SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: expenseWidget(context),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalStdAmt),
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalActualAmt),
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalOverAmt),
                    ),
                  ),
                  // Obx(()=>Text(AppUtils.addThousnadSperator(controller.expenseStandardAmount.value))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                children: [
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseStandardAmount.value)),
                    ),
                  )),
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseActualAmount.value)),
                    ),
                  )),
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseOverAmount.value)),
                    ),
                  )),
                ],
              ),
            ),
          ],
        )
    );
  }
  dynamic fuelInBottomSheet(BuildContext context, WayBill_Fuelin_ids fuelIn_ids) {
    var labels = AppLocalizations.of(context);

    return  showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Color(0xff757575),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight:
                  Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Column(
                children: [
                  Align(
                    alignment:
                    Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(
                          Icons.close_outlined),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.date,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(AppUtils.changeDateFormat(
                              fuelIn_ids.date)))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.shop,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelIn_ids.shop)))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.product,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelIn_ids.productId.name.toString())))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.fromLocation,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: fuelIn_ids.location_id!=null?
                          Text(AppUtils.removeNullString(
                              fuelIn_ids.location_id.name)):Text(''))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.slipNo,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelIn_ids.slipNo)))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.quantity+"("+labels.liter+")",
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelIn_ids.liter.toString())).toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.unitPrice,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelIn_ids.priceUnit.toString())).toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.amount,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelIn_ids.amount.toString())).toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
  Widget fuelInContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels.date,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.product,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(labels.quantity,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.unitPrice,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(''),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: fuelInListWidget(context),
              ),
            ),
            (controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false)?
            Align(
              alignment:Alignment.topRight,
              child: FloatingActionButton(onPressed: (){
                Get.to(AddFuelWayBillPage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fromDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].toDatetime,null)).then((value) {
                  if(value!=null){
                    DayTripPlanTripGeneralController general_controller = Get.find();
                    controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds.add(WayBill_Fuelin_ids(id:value,date: general_controller.dateTextController.text,
                        shop: general_controller.shopNameTextController.text,
                        productId: WayBill_Product_id(id:general_controller.selectedProduct.id,name: general_controller.selectedProduct.name),
                        slipNo: general_controller.slipNoTextController.text,
                        liter: double.tryParse(general_controller.qtyController.text),
                        priceUnit: double.tryParse(general_controller.priceController.text),
                        amount: double.tryParse(general_controller.totalFuelInAmtController.text),
                        location_id: Location_id(id:general_controller.selectedLocation.id,name: general_controller.selectedLocation.name)),
                    );
                  }
                });
              },
                mini: true,
                child: Icon(Icons.add),

              ),
            ):new Container(),
          ],
        )
    );
  }
  dynamic advanceBottomSheet(BuildContext context, WayBill_Request_allowance_lines advance_ids) {
    var labels = AppLocalizations.of(context);

    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Color(0xff757575),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight:
                  Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Column(
                children: [
                  Align(
                    alignment:
                    Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(
                          Icons.close_outlined),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.expenseCategory,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              advance_ids.expenseCategId.name.toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.quantity,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(
                              advance_ids.quantity.toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.amount,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(advance_ids.amount.toString())).toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.totalAmount,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(advance_ids.totalAmount.toString())).toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.remark,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              advance_ids.remark.toString()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
  Widget advanceContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 2,
                      child: Text(labels.expenseCategory,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.quantity,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),

                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.remark,style: TextStyle(color: backgroundIconColor,fontSize:
                        11),),
                      )),

                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),

            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: advnaceListWidget(context),
              ),
            ),
            controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='submit'||controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'&&isDriver==true||is_spare==true &&
                is_branch_manager == false?
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(onPressed: (){
                var itemAdvanceTotal = 0.0;
                controller.plantrip_with_waybill_list[controller.arg_index.value].requestAllowanceLines.forEach((element) {
                  itemAdvanceTotal += element.totalAmount;
                });
                Get.to(AddAdvancePage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list[controller.arg_index.value].totalAdvance,itemAdvanceTotal)).then((value){
                  // controller.getPlantripWithWayBillList(controller.current_page.value);
                  if(value!=null){
                    DayTripPlanTripGeneralController day_trip_controller = Get.find();
                    // controller.waybill_advance_allowance_ids_list.add();
                    controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines.add(WayBill_Request_allowance_lines(id:value,expenseCategId: WayBill_Expense_categ_id(id:day_trip_controller.selectedExpenseCategory.id,name: day_trip_controller.selectedExpenseCategory.displayName),quantity: double.tryParse(day_trip_controller.quantityTextController.text),amount: double.tryParse(day_trip_controller.amountTextController.text),totalAmount: double.tryParse(day_trip_controller.totalAmountController.text),remark: day_trip_controller.remarkTextController.text));
                  }
                });
              },
                mini: true,
                child: Icon(Icons.add),

              ),
            ):new Container(),
          ],
        )
    );
  }
  Widget fuelConsumptionContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 1,
                      child: Text(labels.stdLit,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.actualLit,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex : 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.description,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='close'&&is_branch_manager==true?SizedBox(): Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                      flex: 1,
                      child: SizedBox()
                  ):SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: fuelConsumptionsListWidget(context),
              ),
            ),
            (controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(onPressed: (){
                showFuelAddDialog(0,null);
              },
                mini: true,
                child: Icon(Icons.add),
              ),
            ):new Container(),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    //DayTripModel dayTripModel = Get.arguments;
    if(Get.arguments!=null){
      print("Arguments##");

    }

    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    controller.plantrip_waybill_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].id;
    double width = MediaQuery.of(context).size.width;
    double customWidth = width * 0.30;
    var from_date = controller.plantrip_with_waybill_list[controller.arg_index.value].fromDatetime;
    to_date =  AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_waybill_list[controller.arg_index.value].toDatetime);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(labels.pantripWaybill),
        actions: [
        ],
      ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(right: 10,left: 10,top: 10),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(right: 65),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=> controller.showDetails.value?
                  Expanded(
                    flex:2,
                    child: AutoSizeText(
                      labels.viewDetailsClose,
                      style: maintitlenoBoldStyle(),
                    ),
                  ):
                  Expanded(
                    flex:2,
                    child: AutoSizeText(
                      labels.viewDetails,
                      style: maintitlenoBoldStyle(),
                    ),
                  )
              ),
              Obx(()=> controller.showDetails.value?Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_circle_up_sharp),
                      onPressed: () {
                        controller.showDetails.value = false;
                      },
                    ),
                  ):
                  Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_circle_down_sharp),
                      onPressed: () {
                        controller.showDetails.value = true;
                      },
                    ),
                  ),),
              ],
              ),
          ),
          Obx(()=>controller.plantrip_with_waybill_list.length > 0 ? controller.showDetails.value?  Column(
              children: [
                Container(
                  margin:EdgeInsets.only(right:60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(labels.code,style: maintitlenoBoldStyle(),),
                      AutoSizeText('${controller.plantrip_with_waybill_list.value[controller.arg_index.value].code}',style: maintitleStyle(),)
                    ],),
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.fromDate,style: maintitlenoBoldStyle(),),
                      SizedBox(height: 5,),
                      AutoSizeText('${from_date}',style: maintitleStyle(),)
                    ],)),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.toDate,style: maintitlenoBoldStyle(),),
                      SizedBox(height: 5,),
                      AutoSizeText(controller.plantrip_with_waybill_list[controller.arg_index.value].toDatetime,style: maintitleStyle(),)
                    ],)),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.vehicle,style: maintitlenoBoldStyle(),),
                      SizedBox(height:5),
                      AutoSizeText('${controller.plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId.name}',style: maintitleStyle(),)
                    ],)),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.driver,style: maintitlenoBoldStyle(),),
                      SizedBox(height:5),
                      AutoSizeText('${controller.plantrip_with_waybill_list.value[controller.arg_index.value].driverId.name}',style: maintitleStyle(),)
                    ],)),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.spare,style: maintitlenoBoldStyle(),),
                      SizedBox(height:5),
                      AutoSizeText('${controller.plantrip_with_waybill_list.value[controller.arg_index.value].spareId.name}',style: maintitleStyle(),)
                    ],)),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.trailer,style: maintitlenoBoldStyle(),),
                      SizedBox(height:5),
                      AutoSizeText('${controller.plantrip_with_waybill_list.value[controller.arg_index.value].trailerId.name}',style: maintitleStyle(),)
                    ],)),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.advanceAmount+' :',style: maintitlenoBoldStyle(),),
                      AutoSizeText('${AppUtils.addThousnadSperator(controller.plantrip_with_waybill_list.value[controller.arg_index.value].totalAdvance)}',style: maintitleStyle(),)
                    ],)),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.expenseStatus+' :',style: maintitlenoBoldStyle(),),
                      Obx(()=>AutoSizeText('${AppUtils.removeNullString(controller.expense_status.value)}',style: maintitleStyle(),))
                    ],)),
                ],),
                //Divider(thickness: 1,),
                SizedBox(height:10),
                controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' ?routeContainer(context): SizedBox(),
              ],
            ):SizedBox() : SizedBox()),
            
            controller.plantrip_with_waybill_list.value.length > 0 ?Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: controller.plantrip_with_waybill_list[controller.arg_index.value].state=='open'?
              TabBar(isScrollable: true,
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  Tab(
                    text: labels.advance,
                  ),
                ],
              ): controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'?TabBar(
                controller: _tabController,
                isScrollable: true,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.expense,
                  ),
                  Tab(
                    text: labels.fuelIn,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  Tab(
                    text: labels.fuelConsumption,
                  ),
                ],
              ):TabBar(isScrollable: true,
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.expense,
                  ),
                  Tab(
                    text: labels.fuelIn,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  Tab(
                    text: labels.advance,
                  ),
                  Tab(
                    text: labels.fuelConsumption,
                  ),
                ],
              ),
            ):SizedBox(),
            controller.plantrip_with_waybill_list.value.length > 0 ?Container(
              height: 300,
              child: controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'?
              TabBarView(
                controller: _tabController,
                children: [
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Add Commission
                  commisionContainer(context),
                  //Advance
                  advanceContainer(context),
                ],
              ) :  controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'?
              TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Expense
                  expenseContainer(context),
                  //Add Fuel
                  fuelInContainer(context),
                  //Commission
                  commisionContainer(context),
                  //fuel Consumption
                  fuelConsumptionContainer(context),
            
                ],
              ): TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Expense
                  expenseContainer(context),
                  //Fuel In
                  fuelInContainer(context),
                  //Commission
                  commisionContainer(context),
                  //Advance
                  advanceContainer(context),
                  //fuel consumption
                  fuelConsumptionContainer(context),
            
                ],
              ),
            ):SizedBox(),
            controller.plantrip_with_waybill_list.value.length > 0 && controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'advance_withdraw'  && isIncharge ?
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.clickstartPlanTripWayBill(controller.plantrip_with_waybill_list.value[controller.arg_index.value].id);
                },
                text: 'Start Trip',
                blockButton: true,
                size: GFSize.LARGE,
              ),
            )
                : SizedBox(),
            controller.plantrip_with_waybill_list.value.length > 0 ? 
            controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'?
            isIncharge?
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom: 15),
              child: GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.clickendPlanTripWayBill(controller.plantrip_with_waybill_list.value[controller.arg_index.value].id);
                },
                text: 'End Trip',
                blockButton: true,
                size: GFSize.LARGE,
              ),
            ):SizedBox():controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='submit'?
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,bottom: 15),
                    child: GFButton(
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.approvePlanTripWayBill();
                      },
                      text: labels.approve,
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,bottom: 15),
                    child: GFButton(
                      type: GFButtonType.outline,
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.declinePlanTripWayBill();
                      },
                      text: labels.sendBack,
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  ),
                ),
              ],
            )
                :new Container(): SizedBox(),
            SizedBox(height: 20,),
        ],
      ),
      
    ),
    );
  }
  Widget expenseWidget(BuildContext context) {
    int fields;
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].eRouteId.name
                            .toString(),style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].routeExpenseId.name
                            .toString(),style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].standardAmount.toString())).toString(),style: TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].actualAmount.toString())).toString(),style: TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      //flex: 1,
                      child: Container(
                        // width: 80,
                          child: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].overAmount!=null?
                          Align(
                            alignment:Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index].overAmount.toString())).toString(),style: TextStyle(fontSize: 11)),
                          ):Text('')
                      ),
                    ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="expense_claim"|| controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?Expanded(flex:1,child: SizedBox()):isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                        //flex:1,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteWayBillExpenseLine(controller.plantrip_with_waybill_list[controller.arg_index.value].expenseIds[index]);
                          },
                        )):SizedBox(),
                    controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: InkWell(
                          onTap: (){
                            Get.to(ExpenseCreate(),arguments: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds[index]).then((value){
                              if(value!=null){
                                controller.getPlantripWithWayBillList(controller.current_page.value);
                              }
                            });
                          },
                          child: Container(
                            // width: 80,
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Color.fromRGBO(60, 47, 126, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ): SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),),
    );

  }
  Widget routeListWidget(BuildContext context) {
    
    int fields;
    bool first_route = false;
    print(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds);
    return Container(
      
      child: Obx(() {
        plantrip_waybill_list_lines = [];
        next_route_id = 0;
        previous_route_id = 0;
          for(var i=0; i< controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length; i++){
            if(i == 0 && (controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == '' || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == null)){
              first_route = true;
            }else{
              first_route = false;
            }
            if((controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == '' || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == null || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == 'running') || (((controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length-1) == i) && controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].status == 'end')){
              plantrip_waybill_list_lines.add(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i]);
              if(i != controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length-1){
                  next_route_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i+1].id;
              }
              break;
            }
        }
        
        return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: plantrip_waybill_list_lines.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        // child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].routeId.name
                        //     .toString()
                        // ),
                        child: Text(plantrip_waybill_list_lines[index].routeId.name
                            .toString()
                        ),
                      ),
                    ),
                  //   Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(left: 10, right: 10),
                  //       child: Theme(
                  //         data: new ThemeData(
                  //           primaryColor: textFieldTapColor,
                  //         ),
                  //         child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].startActualDate!=null ? Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].startActualDate): SizedBox(),
                  //       )),
                  // ),
                  //  Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(right: 10),
                  //       child: Theme(
                  //         data: new ThemeData(
                  //           primaryColor: textFieldTapColor,
                  //         ),
                  //         child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].endActualDate!=null ? Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].endActualDate): SizedBox(),
                  //       )),
                  // ),
                  // (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='open'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='advance_request'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='advance_withdraw'&&isDriver==true)? Expanded(
                  //     flex: 1,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left:12.0),
                  //       child: InkWell(
                  //         onTap: (){
                  //           Get.toNamed(Routes.CREATEROUTEDATEWAYBILL,arguments: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index]).then((value){
                  //             if(value!=null){
                  //               controller.getPlantripWithWayBillList(controller.current_page.value);
                  //             }
                  //           });
                  //         },
                  //         child: Container(
                  //           child: Icon(
                  //             Icons.edit,
                  //             size: 20,
                  //             color: Color.fromRGBO(60, 47, 126, 0.5),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ): new Container(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: plantrip_waybill_list_lines[index].status!=null && plantrip_waybill_list_lines[index].status!='' ? Text(plantrip_waybill_list_lines[index].status): SizedBox(),
                    ),
                  ),
                  plantrip_waybill_list_lines[index].status == '' || plantrip_waybill_list_lines[index].status == null || plantrip_waybill_list_lines[index].status=='running' ? Expanded(child: SizedBox(
                    width: 50,
                    child: GFButton(
                      onPressed: () {
                        if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length > 1){
                          for(var i=0; i< controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length; i++){
                            if(i!=0){
                                if(plantrip_waybill_list_lines[index].id == controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].id){
                                  previous_route_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i-1].id;break;
                                }
                            }
                          }
                        }
                        controller.clickWayBillRouteLine(first_route, controller.plantrip_with_waybill_list.value[controller.arg_index.value].id, plantrip_waybill_list_lines[index].id,next_route_id,previous_route_id).then((value){
                          if(value!=0){
                            controller.getPlantripWithWayBillList(controller.current_page.value);
                          }
                        });
                      },
                      type: GFButtonType.outline,
                      text: plantrip_waybill_list_lines[index].status == '' || plantrip_waybill_list_lines[index].status == null ? 'Start' : plantrip_waybill_list_lines[index].status == 'running' ? 'End' : '',
                      textColor: textFieldTapColor,
                      blockButton: true,
                      size: GFSize.SMALL,
                      color: textFieldTapColor,
                    ),),):SizedBox(),
                  (plantrip_waybill_list_lines[index].status == 'end' && index == plantrip_waybill_list_lines.length-1) ? Expanded(child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text('Done')
                  ),):SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );}),
    );
  }
  Widget fuelConsumptionsListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>controller.plantrip_with_waybill_list.length > 0 ?ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].routeId.name
                            .toString(),style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].standardLiter.toString())).toString(),style: TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Text(
                              NumberFormat('#,###.##').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].consumedLiter.toString())).toString(),style: TextStyle(fontSize: 11))
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(AppUtils.removeNullString(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].description)
                            ,style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():(controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && isDriver==true||is_spare==true&&is_branch_manager==false)?
                    Expanded(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.deletePlantripWaybillConsumptionLine(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].id,controller.plantrip_with_waybill_list[controller.arg_index.value].id);
                          },
                        )):SizedBox(),
                    (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false)? Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: InkWell(
                          onTap: (){
                            showFuelAddDialog(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index].id,controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds[index]);
                          },
                          child: Container(
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Color.fromRGBO(60, 47, 126, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ): new Container(),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ):SizedBox()),
    );
  }
  Widget wayBillListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>controller.plantrip_with_waybill_list.length > 0 ?ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].accountMoveId.name==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].accountMoveId.name
                            .toString(),style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].partnerId.name==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].partnerId.name.toString(),style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        padding: EdgeInsets.only(left:5),
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].date==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].date
                            .toString(),style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Container(
                          // width: 80,
                            child: controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].amount==null?Text(''):
                            Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].amount.toString())).toString(),style: TextStyle(fontSize: 11))
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].state==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds[index].state
                            .toString(),style: TextStyle(fontSize: 11)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ):SizedBox()),
    );
  }
  Widget fuelInListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  fuelInBottomSheet(context, controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index]);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child: Text(AppUtils.changeDateFormat(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].date
                          ),style: TextStyle(fontSize: 11)
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].productId == null ? "":controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].productId.name
                                .toString(),style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].liter.toString())).toString(),style: TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].priceUnit.toString())).toString(),style: TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].amount.toString())).toString(),style: TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():
                      (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].add_from_office==null&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
                      Expanded(
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Get.to(AddFuelWayBillPage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fromDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].toDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds[index])).then((value) {
                                if(value!=null){
                                  controller.getPlantripWithWayBillList(controller.current_page.value);
                                }
                              });
                            },
                          )):Expanded(flex:1,child: SizedBox()),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():
                      (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].add_from_office==null&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
                      Expanded(
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteFuelInLineForPlantripWaybill(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds[index].id);
                            },
                          )):Expanded(flex:1,child: SizedBox()),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child:  IconButton(
                            icon: Icon(
                              Icons.arrow_circle_up,
                              size: 25,
                            ),),
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }

  Widget productListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds[index].routeId.name
                            .toString(),style: TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds[index].commissionDriver
                              .toString(),style: TextStyle(fontSize: 11)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds[index].commissionSpare
                              .toString(),style: TextStyle(fontSize: 11)),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }

  Widget advnaceListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  advanceBottomSheet(context, controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines[index]);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines[index].expenseCategId.name
                              .toString(),style: TextStyle(fontSize: 11)
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(padding: const EdgeInsets.only(left:6.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines[index].quantity.toString())).toString(),style: TextStyle(fontSize: 11))
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.only(left:6.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines[index].amount.toString())).toString(),style: TextStyle(fontSize: 11))
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     // width: 80,
                      //     child: Text(controller.advance_allowance_ids_list[index].totalAmount
                      //         .toString()),
                      //   ),
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines[index].remark
                              .toString(),style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="expense_claim"|| controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?SizedBox():isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteWayBillAdvanceLine(controller.plantrip_with_waybill_list[controller.arg_index.value].requestAllowanceLines[index].id);
                            },
                          )):SizedBox(),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child:  IconButton(
                            icon: Icon(
                              Icons.arrow_circle_up,
                              size: 25,
                            ),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }
  Widget routeDropDown() {
    print('routedropdown');
    print(controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds.length);
    var consumptionId = controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds;
    if(consumptionId.length!=0){
      controller.selectedWayBillRoute = consumptionId[0];
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[350], width: 2),
                  // Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<BaseRoute>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Choose Route",
                              )),
                          value: controller.selectedBaseRoute,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (BaseRoute value) {
                            controller.onChangeWayBillRouteDropdown(value);
                          },
                          items: controller.base_route_list
                              .map((BaseRoute route) {
                            return DropdownMenuItem<BaseRoute>(
                              value: route,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  route.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFuelAddDialog(int lineID,Consumption_ids consumption) {
    if(consumption!=null){
      controller.selectedBaseRoute = BaseRoute(id:consumption.routeId.id,name:consumption.routeId.name,fuel_liter: consumption.standardLiter);
      controller.actualAmountTextController.text = consumption.consumedLiter.toString();
      controller.descriptionTextController.text = consumption.description;
    }else{
      controller.selectedBaseRoute = controller.base_route_list.value[0];
      controller.actualAmountTextController.text = "";
      controller.descriptionTextController.text = "";
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // controller
          //     .actualAmountTextController.clear();
          // controller
          //     .descriptionTextController.clear();
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Fuel Consumption',style: TextStyle(color: backgroundIconColor,fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: routeDropDown(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Row(
                          children: [
                            Expanded(flex:2,child: Text('Standard Consumption : ',style: TextStyle(color: backgroundIconColor),)),
                            Obx(()=>Expanded(flex:1,child:controller.show_standard_liter.value?Text(controller.selectedBaseRoute.fuel_liter.toString()+"Liter",style: TextStyle(color: backgroundIconColor),):Text(''))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 15),
                                child: Theme(
                                  data: new ThemeData(
                                    primaryColor:
                                    textFieldTapColor,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: controller
                                        .actualAmountTextController,
                                    decoration:
                                    InputDecoration(
                                      border:
                                      OutlineInputBorder(),
                                      hintText: "Actual Fuel Consumption(Liter)",
                                    ),
                                    onChanged:
                                        (text) {

                                    },
                                  ),
                                )),
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Container(
                          child: TextField(
                            controller: controller
                                .descriptionTextController,
                            enabled: true,
                            style: TextStyle(
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: (("Description")),
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0),
                        child: GFButton(
                          onPressed: () {
                            controller.addPlanTripWillbillFuelConsumption(controller.plantrip_with_waybill_list.value[controller.arg_index.value],lineID);
                          },
                          text: "Save",
                          blockButton: true,
                          size: GFSize.LARGE,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).then((value) {
      if(value!=null){
        controller.getPlantripWithWayBillList(controller.current_page.value);
      }

    });
  }
}

class ExpenseCreate extends StatefulWidget {
  @override
  _ExpenseCreateState createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final PlanTripController controller = Get.find();
  var box = GetStorage();

  String image;
  String img64;
  List<TravelLineListModel> datalist;
  DateTime selectedFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File imageFile;
  String expenseValue;
  Uint8List bytes;
  WayBill_Expense_ids arguments;
  bool show_image_container = true;

  Widget  routeExpenseDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[350], width: 2),
                  // Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<WayBill_Expense_ids>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Category",
                              )),
                          value: controller.selectedWayBillExpenseRouteCategory,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (WayBill_Expense_ids value) {
                            controller.onChangeWayBillRouteExpenseDropdown(value);
                          },
                          items: controller.waybill_expense_list
                              .map((WayBill_Expense_ids category) {
                            return DropdownMenuItem<WayBill_Expense_ids>(
                              value: category,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  category.routeExpenseId.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: appbar(context, "Plan Trip WayBill Expense Form", image),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(controller.routeName,style: TextStyle(fontSize : 15,fontWeight: FontWeight.w500))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: routeExpenseDropDown()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 10.0),
                    child: Row(
                      children: [
                        Expanded(flex:1,child: Text('Standard Amount : ',style: TextStyle(color: backgroundIconColor),)),
                        Obx(()=>Expanded(flex:1,child:Text(controller.show_standard_amount.value?controller.selectedWayBillExpenseRouteCategory.standardAmount!=null?AppUtils.addThousnadSperator(controller.selectedWayBillExpenseRouteCategory.standardAmount):'':'',style: TextStyle(color: backgroundIconColor),))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.wayBillexpenseActualTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: labels?.actual+ " "+ labels?.amount,
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          controller: controller.wayBillexpenseDescriptionTextController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description'
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  show_image_container?Obx(()=>InkWell(
                    onTap: (){
                      showOptions(context);
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Column(
                          children: [
                            Text('Add Image'),
                            controller.isShowImage.value==false?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                  BoxDecoration(color: Colors.grey),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ):
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Image.memory(bytes,width: 100,height: 100,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )):SizedBox(),

                ],
              ),
              SizedBox(height: 30,),
              GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.saveExpense("waybill",arguments.id);
                },
                text: "Save",
                blockButton: true,
                size: GFSize.LARGE,
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    arguments = Get.arguments;
    if(arguments.attachement!=null){
      controller.isShowImage.value = true;
      controller.selectedExpensePlanTripWayBillImage = arguments.attachement;
      bytes = base64Decode(arguments.attachement);
    }else{
      controller.isShowImage.value = false;
      controller.selectedExpensePlanTripWayBillImage = "";
    }
    controller.wayBillexpenseActualTextController.text = arguments.actualAmount.toString();
    //controller.wayBillexpenseRouteController.text = arguments.eRouteId.name.toString();
    controller.routeName = arguments.eRouteId.name.toString();
    controller.wayBillexpenseDescriptionTextController.text = arguments.description;
    findDropDownValue(arguments.routeExpenseId.id);

    super.initState();
  }
  void findDropDownValue(int expenseID) {
    bool found = false;
    for(int i=0;i<controller.waybill_expense_list.value.length;i++){
      if(controller.waybill_expense_list.value[i].routeExpenseId.id==expenseID){
        found = true;
        controller.selectedWayBillExpenseRouteCategory = controller.waybill_expense_list.value[i];
        break;
      }
    }
  }
  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Camera")),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImage();
                    Get.back();
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Gallery")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if(pickedFile!=null){
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      controller.setCameraImageFromWayBill(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }

  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      controller.setCameraImageFromWayBill(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }

  }
}

