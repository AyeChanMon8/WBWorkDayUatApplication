// @dart=2.9

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/announcements_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';

import 'leave_detail.dart';

class RemindersDetails extends StatelessWidget {
  final AnnouncementsController controller = Get.put(AnnouncementsController());
  final box = GetStorage();
  int index;
  String image;
  List<String> reminder;
  String reminderText;
  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
  }
  Widget pdfView(String pathPDF){
    print("pdfView");
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF.toString());
  }
  @override
  Widget build(BuildContext context) {
    index = Get.arguments;
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    // if(controller.reminderList.value[index].description.contains("src=\"/web/image/")){
    //   reminder = controller.reminderList.value[index].description.split('src=\"/web/image/');
    //   reminderText = reminder[0]+'src=\"'+Globals.baseURL.split('/api')[0]+'/web/image/'+reminder[1];
    // }else{
    //   reminderText = controller.reminderList.value[index].description;
    // }
    return Scaffold(
      appBar: appbar(context, "Reminders Details", image),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.reminderList.value[index].contents,style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 15,),
              controller.reminderList.value[index].description != null && controller.reminderList.value[index].description != false ? Text(controller.reminderList.value[index].description): SizedBox(),
              SizedBox(height: 20),
              SizedBox(
                child: GridView.builder(
                    itemCount: controller.reminderList.value[index].attachment_ids.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context,fileIndex) {

                      return InkWell(
                        onTap: () async{
                          !controller.reminderList.value[index].attachment_ids[fileIndex].name.toString().contains('pdf')?
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return ImageDialog(
                                  bytes: base64Decode(controller.reminderList.value[index].attachment_ids[fileIndex].attach_file),
                                );
                              }
                          ):
                          _createFileFromString(controller.reminderList.value[index].attachment_ids[fileIndex].attach_file.toString()).then((path) async{
                            print("FilePath");
                            await OpenFile.open(path);
                             print(path.toString());
                          });
                        },child: Card(
                          elevation: 10,
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.all(10),
                            child: !controller.reminderList.value[index].attachment_ids[fileIndex].name.toString().contains('pdf')? 
                            
                            Image.memory(base64Decode(controller.reminderList.value[index].attachment_ids[fileIndex].attach_file)):AutoSizeText(
                              controller.reminderList.value[index].attachment_ids[fileIndex].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blueGrey,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }
                       ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: pdfPath);
  }
}