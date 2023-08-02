// @dart=2.9

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/models/fleet_insurance.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/pdf_view.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
class FleetInsuranceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Fleet_insurance fleet_insurance = Get.arguments;
    return Scaffold(
      appBar: appbar(context, 'Insurance Detail', ''),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText('Valid Date : ${AppUtils.formatter.format(DateTime.parse(fleet_insurance.startDate))} - ${AppUtils.formatter.format(DateTime.parse(fleet_insurance.endDate))}',style: TextStyle(fontSize: 20,color: Color.fromRGBO(88, 98, 134, 1)),),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Name : ${fleet_insurance.vehicleId.name}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Type : ${fleet_insurance.insuranceTypeId.name}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Company : ${fleet_insurance.insuranceCompany}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Contact Person : ${fleet_insurance.contactPerson}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Contact Phone : ${fleet_insurance.contactPhone}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('By : ${fleet_insurance.by}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),

              GridView.builder(
                // padding: EdgeInsets.all(10),
                  itemCount: fleet_insurance.attachmentId.length,
                  shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisSpacing: 0.9,
                    mainAxisSpacing: 0.5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int fileIndex) {
                    return InkWell(
                      onTap: () async {
                        File file = await _createFileFromString(fleet_insurance.attachmentId[fileIndex].datas,fleet_insurance.attachmentId[fileIndex].name,fleet_insurance.attachmentId[fileIndex].mimetype);
                        if (AppUtils.isImage(file.path)) {
                          Get.dialog(Stack(
                            children: [
                              Center(child: Image.file(file)),
                              Positioned(right : 0,child: FlatButton(onPressed: (){Get.back();}, child: Text('Close',style:TextStyle(color: Colors.white,fontSize: 20) ,)))
                            ],
                          ));
                        } else {
                          await OpenFile.open(file.path);
                          //Get.to(PdfView(file.path,fleet_insurance.attachmentId[fileIndex].name));
                        }
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Icon(
                                FontAwesomeIcons.file,
                                size: 50,
                              ),
                            ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                            Text(
                              fleet_insurance.attachmentId[fileIndex].name,
                              style: datalistStyle(),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
  Future<File> _createFileFromString(String data,String name,String type) async {
    return AppUtils.createPDF(data, name,type);
  }
}
