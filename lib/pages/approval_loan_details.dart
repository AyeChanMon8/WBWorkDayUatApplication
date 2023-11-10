// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../localization.dart';
import 'leave_detail.dart';

class ApprovalLoanDetails extends StatefulWidget {
  @override
  _ApprovalLoanDetailsState createState() => _ApprovalLoanDetailsState();
}

class _ApprovalLoanDetailsState extends State<ApprovalLoanDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image;
  int index;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    image = box.read('emp_image');
    index = Get.arguments;
    return Scaffold(
      appBar: appbar(context, "Loan Details",image),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: controller.loanApprovalList.value.length>0? Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    controller.loanApprovalList.value[index].name,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.status,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.loanApprovalList.length > 0 ?Container(
                          child: Text(
                            controller.loanApprovalList[index].state,
                            style: subtitleStyle(),
                          ),
                        ):SizedBox(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.employeeName,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.loanApprovalList.value.length > 0 ?Container(
                          child: Text(
                            controller.loanApprovalList.value[index].employee_id.name,
                            style: subtitleStyle(),
                          ),
                        ):SizedBox(),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.position,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.loanApprovalList.value.length > 0 ?Container(
                          child: controller.loanApprovalList.value[index].job_position.name !=
                              null
                              ? Text(
                            controller.loanApprovalList.value[index].job_position.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
                        ):SizedBox(),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.date,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("payment_start_date"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.loanApprovalList.value.length > 0 ?Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.loanApprovalList.value[index].date),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.loanApprovalList.value[index].payment_date),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
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
               Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.company,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Branch"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.loanApprovalList.value.length > 0 ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            child: Text(
                              AppUtils.removeNullString(controller.loanApprovalList.value[index].company_id.name),
                              style: subtitleStyle(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left:28.0),
                              child: Text(
                                AppUtils.removeNullString(controller.loanApprovalList.value[index].branch_id.name),
                                style: subtitleStyle(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height:  10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels?.loanAmount,
                          // ("loan_amount"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          labels?.noOfInstallments,
                          // ("no_of_installments"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.loanApprovalList.value.length>0 ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            NumberFormat('#,###').format(double.tryParse(controller.loanApprovalList.value[index].loan_amount.toString())),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            controller.loanApprovalList.value[index].installment.toString(),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
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
                Container(
                  child: Text(
                    'Attachments',
                    // ("loan_amount"),
                    style: datalistStyle(),
                  ),
                ),
                // Divider(
                //   thickness: 1,
                // ),
                SizedBox(
                  height: 10,
                ),
                controller.loanApprovalList.value[index].attachment!=null ?
                InkWell(
                  onTap: () async{
                    controller.loanApprovalList.value[index].attachment_filename.contains('pdf')?
                    _createFileFromString(controller.loanApprovalList.value[index].attachment.toString()).then((path) async{
                      await OpenFile.open(path);
                      //  Get.to(PdfView(path,'Name.pdf'));
                    }) :
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return ImageDialog(
                            bytes: base64Decode(controller.loanApprovalList.value[index].attachment),
                          );
                        }
                    );
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 50,
                      //width: 120,
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.attach_file),
                            Expanded(
                              child: AutoSizeText(
                                controller.loanApprovalList.value[index].attachment_filename!=null?controller.loanApprovalList.value[index].attachment_filename:'',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blueAccent,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ):new Container(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Text(labels?.installments, style: datalistStyle()),
                ),
                SizedBox(
                  height: 20,
                ),
                installmentTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                controller.loanApprovalList.value.length > 0 ?installmentWidget(context):SizedBox(),
                SizedBox(
                  height: 10,
                ),
                approveButton(context)
              ],
            ),
          ):SizedBox(),
        ),
      ),
    );
  }

  Widget installmentTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              labels?.paymentDate,
              // ("payment_date"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              labels?.status,
              // ("status"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              labels?.amount,
              // ("amount"),
              style: subtitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget installmentWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Obx(() => controller.loanApprovalList.value.length>0 ?Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.loanApprovalList.value[index].loan_lines.length,
        itemBuilder: (BuildContext context, int pos) {
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                          AppUtils.changeDateFormat(controller.loanApprovalList.value[index].loan_lines[pos].date)
                      ),
                    ),
                    Container(
                      child: Text(controller.loanApprovalList.value[index].loan_lines[pos].state),
                    ),
                    Container(
                      child: Text(NumberFormat('#,###').format(double.tryParse(controller.loanApprovalList.value[index].loan_lines[pos].amount
                          .toString()))
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
      ),
    ):SizedBox());
  }
  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
  }

  Widget approveButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller
                    .approveLoan(controller.loanApprovalList.value[index].id);
                print("Loan approved");
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.declinedLoan(
                    controller.loanApprovalList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels?.decline,
              textColor: textFieldTapColor,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
        ],
      ),
    );
  }

}
