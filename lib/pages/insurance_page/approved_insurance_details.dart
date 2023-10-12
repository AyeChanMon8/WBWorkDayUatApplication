// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../../localization.dart';
class ApprovedInsuranceDetailsPage extends StatefulWidget {

  @override
  State<ApprovedInsuranceDetailsPage> createState() => _ApprovedInsuranceDetailsPageState();
}

class _ApprovedInsuranceDetailsPageState extends State<ApprovedInsuranceDetailsPage> {
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
          labels.insurance,
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
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].name)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Expire Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].expireDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.insuranceType,style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovedList.value[index].insuranceTypeId.policy_type}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.employeeName,style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovedList.value[index].employeeId.name}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Benefits',style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovedList.value[index].benefit}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Policy Coverage',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].poilcy_coverage)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Efective Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].effectiveDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].premiumAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Coverage Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].coverageAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employee)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].feesEmployee.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employer)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].feesEmployer.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].balanceAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('No of Installments',style: detailsStyle()),
                  AutoSizeText(' : ${controller.insuranceApprovedList.value[index].installment}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].totalAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Paid Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].totalPaidAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].balanceAmount)}',style: maintitleStyle()),
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
                    itemCount: controller.insuranceApprovedList.value[index].insuranceLines.length,
                    itemBuilder: (context,index1){
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(controller.insuranceApprovedList.value[index].insuranceLines[index1].date),
                          AutoSizeText(controller.insuranceApprovedList.value[index].insuranceLines[index1].state),
                          AutoSizeText('${NumberFormat('#,###').format(controller.insuranceApprovedList.value[index].insuranceLines[index1].amount)}'),
                        ],),
                      Divider(height: 2,color: Colors.black,),
                    ],
                  );
                }),
                SizedBox(height: 10,),
              ],
            ),
          
      ),
    );
  }
}