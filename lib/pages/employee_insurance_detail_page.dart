// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/insurancemodel.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
class EmployeeInsuranceDetailPage extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    Insurancemodel insurance = Get.arguments;
    return Scaffold(
      appBar: appbar(context, 'Insurance Detail', ''),
      body: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  AutoSizeText('Code',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(insurance.name)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Expire Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(insurance.expireDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.insuranceType,style: detailsStyle()),
                  AutoSizeText(' : ${insurance.insuranceTypeId.policy_type}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText(labels?.employeeName,style: detailsStyle()),
                  AutoSizeText(' : ${insurance.employeeId.name}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Benefits',style: detailsStyle()),
                  AutoSizeText(' : ${insurance.benefit}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Policy Coverage',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(insurance.poilcy_coverage)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Efective Date',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.changeDateFormat(insurance.effectiveDate)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.premiumAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Coverage Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employee)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(insurance.feesEmployee.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Premium Fees(Employer)',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.removeNullString(insurance.feesEmployer.toString())}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.balanceAmount.toString()))}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('No of Installments',style: detailsStyle()),
                  AutoSizeText(' : ${insurance.installment}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.totalAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Total Paid Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.totalPaidAmount)}',style: maintitleStyle()),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AutoSizeText('Balance Amount',style: detailsStyle()),
                  AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.balanceAmount)}',style: maintitleStyle()),
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
                    itemCount: insurance.insuranceLines.length,
                    itemBuilder: (context,index){
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(insurance.insuranceLines[index].date),
                          AutoSizeText(insurance.insuranceLines[index].state),
                          AutoSizeText('${NumberFormat('#,###').format(insurance.insuranceLines[index].amount)}'),
                        ],),
                      Divider(height: 2,color: Colors.black,),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
