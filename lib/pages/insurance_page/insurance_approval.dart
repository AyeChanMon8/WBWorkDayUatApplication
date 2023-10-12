// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../../localization.dart';
class InsuranceApproval extends StatefulWidget {

  @override
  State<InsuranceApproval> createState() => _InsuranceApprovalState();
}

class _InsuranceApprovalState extends State<InsuranceApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image;
  int index;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text(
          labels.insuranceApproval,
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(right: 10,left: 10,top: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  AutoSizeText('Code',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].name)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Expire Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].expireDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.insuranceType,style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovalList.value[index].insuranceTypeId.policy_type}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.employeeName,style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovalList.value[index].employeeId.name}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Benefits',style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovalList.value[index].benefit}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Policy Coverage',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].poilcy_coverage)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Efective Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].effectiveDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].premiumAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Coverage Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].coverageAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employee)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].feesEmployee.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employer)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].feesEmployer.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].balanceAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('No of Installments',style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovalList.value[index].installment}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].totalAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Paid Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].totalPaidAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].balanceAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                AutoSizeText('Installments',style: detailsStyle(),),
                SizedBox(height: 20,),
                Divider(height: 2,color: Colors.black,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                AutoSizeText('Payment Date',style: maintitleStyle(),),
                AutoSizeText('Status',style: maintitleStyle()),
                AutoSizeText('Amount',style: maintitleStyle()),
                ],),
                Divider(height: 2,color: Colors.black,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.insuranceApprovalList.value[index].insuranceLines.length,
                    itemBuilder: (context,index1){
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(controller.insuranceApprovalList.value[index].insuranceLines[index1].date),
                          AutoSizeText(controller.insuranceApprovalList.value[index].insuranceLines[index1].state),
                          AutoSizeText('${NumberFormat('#,###').format(controller.insuranceApprovalList.value[index].insuranceLines[index1].amount)}'),
                        ],),
                      Divider(height: 2,color: Colors.black,),
                    ],
                  );
                }),
                SizedBox(height: 10,),
                controller.insuranceApprovalList.value[index].state == 'waiting_approval_1'
                  ? Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                              onPressed: () {
                                controller.approveInsurance(controller.insuranceApprovalList.value[index].id);
                              },
                              text: labels?.approve,
                              blockButton: true,
                              size: GFSize.LARGE,
                              color: textFieldTapColor,
                            ),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            onPressed: () {
                              controller.rejectInsurance(
                                  controller.insuranceApprovalList.value[index].id);
                            },
                            type: GFButtonType.outline,
                            text: 'Reject',
                            textColor: textFieldTapColor,
                            blockButton: true,
                            size: GFSize.LARGE,
                            color: textFieldTapColor,
                          ),
                        ),
                      )
                    ],
                  )
                  : SizedBox(),
              ],
            ),
          
      ),
    );
  }
}