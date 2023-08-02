// @dart=2.9

//import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:winbrother_hr_app/controllers/payslip_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/my_class/theme.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
class PaySlipPage extends StatefulWidget {
  @override
  _PaySlipPageState createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  int pindex;

  final box = GetStorage();

  String image;

  String basic;

  String inc;

  String ot;

  String otdt;

  String ins;

  String unpaid;

  String eloan;

  String tloan;

  String ssb;

  String gross;

  String ict;

  String net;

  var format = NumberFormat('#,###.#');

  final PayslipController controller = Get.find();

List<Category_list> category = [] ;

getCategoryList(){
  List<Category_list> categoryList = [];
  categoryList = controller.paySlips[pindex].categoryList;
  Category_list deduction ;
  Category_list net;
  for(var i = 0; i < categoryList.length; i++){
    switch(categoryList[i].name){
      case 'Deduction' : {
        deduction = categoryList[i];
      }
      break;
      case 'Net' :
        {
         net = categoryList[i];
        }
      break;
      case 'Leave Deduction' :
        {
            category.add(categoryList[i]);
           // category.add(deduction);
           // category.add(net);
          }
          break;
      default :category.add(categoryList[i]);
    }
    print("categoryName ${categoryList[i].name}");
  }
  category.add(deduction);
  category.add(net);
  print("category $category");
}

  Widget payslipLineWidget(BuildContext context) {
  getCategoryList();
    return Column(
      children: [
        Divider(thickness: 1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                  Container(
                    child: Text(
                      'Description',
                      //controller.paySlips[pindex].categoryList[index].lineList[ind].name,
                      style: TextStyle(
                        color: Color.fromRGBO(58, 47, 112, 1),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Amount (MMK)',
                      style: TextStyle(
                        color: Color.fromRGBO(58, 47, 112, 1),
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.right,
                    ),
                  )
        ],),
        Divider(thickness: 1,),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          //controller: scrollController,
          shrinkWrap: true,
          itemCount: category.length, //controller.paySlips[pindex].categoryList.length,
          itemBuilder: (BuildContext context, int index) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     child: Text(
                        //       category[index].name,
                        //       // controller.paySlips[pindex].categoryList[index].name,
                        //       style: maintitleBoldStyle(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height:30),
                        ListView.builder(
                          //controller: scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: category[index].lineList.length, // controller.paySlips[pindex].categoryList[index].lineList.length,
                          itemBuilder: (BuildContext context, int ind) {

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              category[index].lineList[ind].name,
                                              //controller.paySlips[pindex].categoryList[index].lineList[ind].name,
                                              style: TextStyle(
                                                color: Color.fromRGBO(58, 47, 112, 1)
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              AppUtils.addThousnadSperator(
                                                category[index].lineList[ind].total,
                                                //controller.paySlips[pindex].categoryList[index].lineList[ind].total
                                              ),
                                              style: TextStyle(
                                                color: Color.fromRGBO(58, 47, 112, 1)
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                (index == category.length-1 && ind ==category[index].lineList.length-1) ?SizedBox():Divider(thickness: 1,),
                                // SizedBox(
                                //   height: 10,
                                // ),
                              ],
                            );
                          },
                        )

                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    pindex = Get.arguments;

    final labels = AppLocalizations.of(context);
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(controller.paySlips[pindex].dateFrom);
    String date = DateFormat("MMMM yyyy").format(tempDate);
    String user_image = box.read('emp_image');
    String usercompany = box.read('emp_company_name');
    return Scaffold(
      appBar: appbar(context, labels?.paySlip, user_image),
      body: SingleChildScrollView(
        child: Container(
          margin : EdgeInsets.only(left: 20,top: 20,right: 20),
          child: Column(children: [
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Icon(
                    Icons.download_sharp
                  ),
                  onPressed: _createPDF,
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text(
                  usercompany,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(58, 47, 112, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Salary Slip- ' +controller.paySlips[pindex].employeeId.name+ ' - '+
                        date,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(58, 47, 112, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Table(
                border: TableBorder.all(color: Colors.black26),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Description', style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('['+controller.paySlips[pindex].pin.toString()+'] '+controller.paySlips[pindex].employeeId.name,
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Designation',
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.paySlips[pindex].employeeId.jobId.name,
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Reference', style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.paySlips[pindex].slip_number.toString(),
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Bank Account',
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.paySlips[pindex].bank_account_number!=false &&  controller.paySlips[pindex].bank_account_number!=null?
                        controller.paySlips[pindex].bank_account_number.toString(): "",
                       style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                    )
                  ],),
                ],
              ),
              SizedBox(height: 20,),
              payslipLineWidget(context),
              SizedBox(height: 20,),
              Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Authorized Signature',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(58, 47, 112, 1)),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Container(alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(DateFormat("yyyy-MM-dd").format(DateTime.now()),style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
                SizedBox(height: 5,),
                Text(DateFormat("HH:mm").format(DateTime.now()),style: TextStyle(
                      color: Color.fromRGBO(58, 47, 112, 1))),
              ],),
              ),
      //        FooterView(
      //   children:<Widget>[
      //     new Padding(
      //       padding: new EdgeInsets.only(top:200.0),
      //       child: Center(
      //         child: new Text('Scrollable View'),
      //       ),
      //     ),
      //   ],
      //   footer: new Footer(
      //     child: Padding(
      //       padding: new EdgeInsets.all(10.0),
      //       child: Text('I am a Customizable footer!!')
      //     ),
      //   ),
      //   flex: 1, //default flex is 2
      // ),

          ],),
        ),
        // child: Container(
        //   margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Align(
        //         alignment: Alignment.centerRight,
        //         child: FlatButton(
        //           child: Icon(
        //             Icons.download_sharp
        //           ),
        //           onPressed: _createPDF,
        //         ),
        //       ),
        //       Container(
        //         child: Center(
        //           child: Text(
        //             usercompany,
        //             // "July Payroll",
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 color: Color.fromRGBO(58, 47, 112, 1),
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         child: Center(
        //           child: Text(
        //             'Salary Slip-' +
        //                 date,
        //             // "July Payroll",
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 color: Color.fromRGBO(58, 47, 112, 1),
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 40),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               child: Text(
        //                 labels.payrollPeriod,
        //                 style: subtitleStyle(),
        //               ),
        //             ),
        //             Container(
        //               child: Text(
        //                 AppUtils.removeNullString(controller.paySlips[pindex].month.toString())+"-"+AppUtils.removeNullString(controller.paySlips[pindex].year),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               child: Text(
        //                 'Period',
        //                 style: subtitleStyle(),
        //               ),
        //             ),
        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].dateFrom+"/"+controller.paySlips[pindex].dateTo),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Container(
        //             //   child: Text(
        //             //     labels?.employeeName,
        //             //     style: subtitleStyle(),
        //             //   ),
        //             // ),
        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].employeeId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [

        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].employeeId.jobId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Container(
        //             //   child: Text(
        //             //     labels?.department,
        //             //     style: subtitleStyle(),
        //             //   ),
        //             // ),
        //             Container(
        //               child: Text(
        //                 (controller
        //                     .paySlips[pindex].employeeId.departmentId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),

        //       // SizedBox(
        //       //   height: 10,
        //       // ),
        //       // Divider(
        //       //   thickness: 1,
        //       // ),
        //       SizedBox(
        //         height: 10,
        //       ),


        //       SizedBox(
        //         height: 10,
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),

        //   
          ),
  //     bottomNavigationBar: BottomAppBar(
  //       elevation: 0,
  //       color: Colors.transparent,
  //   child: Container(
  //      height: 40,
  //      padding: EdgeInsets.only(left: 30),
  //     child: Column(
  //       children: <Widget>[
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //             children: <Widget>[
  //               Text(DateFormat("yyyy-MM-dd").format(DateTime.now()),style: TextStyle(
  //                     color: Color.fromRGBO(58, 47, 112, 1))),
  //             ]),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //             children: <Widget>[
  //               Text(DateFormat("HH:mm").format(DateTime.now()),style: TextStyle(
  //                     color: Color.fromRGBO(58, 47, 112, 1)))
  //             ]),
  //       ],
  //     ),
  //   ),
  // ),

      );
  }

  Future<void> _createPDF() async{
    String empusercompany = box.read('emp_company_name');
    DateTime tempDate1 = new DateFormat("yyyy-MM-dd").parse(controller.paySlips[pindex].dateFrom);
    String paySlipDate = DateFormat("MMMM yyyy").format(tempDate1);
    List<Category_list> categoryList = [];
    categoryList = controller.paySlips[pindex].categoryList;
    String file_name = controller.paySlips[pindex].employeeId.name+paySlipDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    var timeFormatter = new DateFormat('HHmmss');
    String formattedDate = formatter.format(now);
    String formattedTime = timeFormatter.format(now);
    String fileName = file_name.replaceAll(RegExp(r"\s+"), "")+""+formattedDate+""+formattedTime+'.pdf';
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawString(empusercompany, PdfStandardFont(PdfFontFamily.timesRoman, 20),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
   
    page.graphics.drawString('Salary Slip- ' +controller.paySlips[pindex].employeeId.name+' - '+
                        paySlipDate, PdfStandardFont(PdfFontFamily.timesRoman, 20),
    bounds: Rect.fromLTWH(0, 40, pageSize.width, pageSize.height));

    //Create a second PdfGrid in the same page
    final PdfGrid grid2 = PdfGrid();

    //Add columns to second grid
    grid2.columns.add(count: 4);

    //Add rows to grid
    PdfGridRow row11 = grid2.rows.add();
    row11.cells[0].value = 'Description';
    row11.cells[1].value = '['+controller.paySlips[pindex].pin.toString()+'] '+controller.paySlips[pindex].employeeId.name;
    row11.cells[2].value = 'Designation';
    row11.cells[3].value = controller.paySlips[pindex].employeeId.jobId.name;
    PdfGridRow row12 = grid2.rows.add();
    row12.cells[0].value = 'Reference';
    row12.cells[1].value = controller.paySlips[pindex].slip_number.toString();
    row12.cells[2].value = 'Bank Account';
    row12.cells[3].value = controller.paySlips[pindex].bank_account_number!=false && controller.paySlips[pindex].bank_account_number!=null ? controller.paySlips[pindex].bank_account_number.toString(): "";

    grid2.style = PdfGridStyle(
    cellPadding: PdfPaddings(left: 8, right: 8, top: 4, bottom: 4),
    backgroundBrush: PdfBrushes.white,
    textBrush: PdfBrushes.black,
    font: PdfStandardFont(PdfFontFamily.timesRoman, 16));
    //Draw the grid in PDF document page
    grid2.columns[0].width = 100;
    grid2.columns[2].width = 100;
    grid2.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 90, pageSize.width, pageSize.height));
    final PdfPen linePen = PdfPen(PdfColor(255, 255, 255), width: 1);
    final PdfBorders borders = PdfBorders(
      left: linePen, right: linePen);
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);
    PdfGridRow row =grid.rows.add();

    //Add the rows to the grid
    row.cells[0].value = 'Description';
    row.cells[1].value = 'Amount (MMK)';
    row.cells[1].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.right);

    
    for(int i=0;i<category.length;i++){
      for(int j=0;j<category[i].lineList.length;j++){
        row = grid.rows.add();
        row.cells[0].value = category[i].lineList[j].name;
        row.cells[1].value = AppUtils.addThousnadSperator(category[i].lineList[j].total).toString();
        row.cells[1].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.right);
      }
    }
    grid.style = PdfGridStyle(
    cellPadding: PdfPaddings(left: 4, right: 4, top: 4, bottom: 4),
    backgroundBrush: PdfBrushes.white,
    textBrush: PdfBrushes.black,
    font: PdfStandardFont(PdfFontFamily.timesRoman, 16),);
    
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow headerRow = grid.rows[i];
      for (int j = 0; j < headerRow.cells.count; j++) {
        headerRow.cells[j].style.borders = borders;
      }
  }
    //Draw the grid
    grid.draw(
    page: page, bounds: Rect.fromLTWH(0, 220, pageSize.width, pageSize.height));

    page.graphics.drawString("Authorized Signature", PdfStandardFont(PdfFontFamily.timesRoman, 16),
    format: PdfStringFormat(alignment: PdfTextAlignment.right),
    bounds: Rect.fromLTWH(0, 640, pageSize.width, pageSize.height));

    //Create the footer with specific bounds
    PdfPageTemplateElement footer = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 50),);

  
    //Create the composite field with page number page count
    PdfCompositeField compositeField = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
    compositeField.bounds = footer.bounds;
    compositeField.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.left);

    //Add the composite field in footer
    compositeField.draw(footer.graphics,
        Offset(0, 20 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height),);

    PdfCompositeField compositeField1 = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: DateFormat("HH:mm").format(DateTime.now()));
    compositeField1.bounds = footer.bounds;
    compositeField1.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.left);
    //Add the composite field in footer
    compositeField1.draw(footer.graphics,
        Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height),);
        

    //Add the footer at the bottom of the document
    document.template.bottom = footer;
    
    var dio = Dio();
    
    final List<int> bytes = document.save();
    document.dispose();
    
    if(Platform.isAndroid){
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        print("request");
        await Permission.storage.request();
      }
      // the downloads folder path
      String path =
      await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_DOWNLOADS);
      String fullPath = "$path/$fileName";
      File file = File(fullPath);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fullPath);
    }else{
      var path = await getApplicationDocumentsDirectory();
      final file = new File('${path?.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('${path?.path}/$fileName');
    }
  }
}


