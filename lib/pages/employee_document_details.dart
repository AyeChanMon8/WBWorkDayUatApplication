// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/controllers/employee_change_controller.dart';
import 'package:winbrother_hr_app/controllers/employee_document_controller.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import '../localization.dart';
import 'leave_detail.dart';

class EmployeeDocumentDetails extends StatefulWidget {
  @override
  _EmployeeDocumentDetailsState createState() => _EmployeeDocumentDetailsState();
}

class _EmployeeDocumentDetailsState extends State<EmployeeDocumentDetails> {
  final EmployeeDocumentController controller = Get.put(EmployeeDocumentController());
  final box = GetStorage();
  String image;
  int index;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachementByDocID(controller.docList[index].id);
    return Scaffold(
      appBar: appbar(context, "Employee Document Details",image),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Document Number',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: Text(
                            AppUtils.removeNullString(controller.docList.value[index].name),
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Document Type',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: Text(AppUtils.removeNullString(controller.docList.value[index].documentType.name)
                           ,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Issue Date',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child:  Text(AppUtils.removeNullString(controller.docList.value[index].issueDate)
                           ,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Attachments',
                    // ("employee_name"),
                    style: datalistStyle(),
                  ),
                ),
                Obx(()=> GridView.builder(
                    itemCount: controller.attachment_list.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, fileIndex) => InkWell(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                              bytes: base64Decode(controller
                                  .attachment_list[fileIndex].data
                              ),
                            ));
                      },
                      child: controller.attachment_list[fileIndex].type.contains("pdf")?

                      InkWell(onTap:(){
                        _createFileFromString(controller.attachment_list[fileIndex].data.toString()).then((path) async{
                          await OpenFile.open(path);
                          print(path.toString());

                        });
                      },child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(controller.attachment_list[fileIndex].type),
                          )))
                          : Card(
                        child: Image.memory(
                            base64Decode(controller.attachment_list[fileIndex].data),
                            width: 50,
                            height: 50),
                      ),
                    ))),


              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {

    super.initState();
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
}