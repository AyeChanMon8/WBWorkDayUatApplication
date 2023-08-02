// @dart=2.9

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/auth_controller.dart';
import 'package:winbrother_hr_app/controllers/forget_password_controller.dart';
import 'package:winbrother_hr_app/controllers/login_controller.dart';
import 'package:winbrother_hr_app/controllers/otp_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';

class OtpConfirmPage extends StatelessWidget {
  OtpController controller = Get.put(OtpController());
  TextEditingController userOtpController = TextEditingController();

  bool _obscureText = true;
  // String barcode;
  var box = GetStorage();
  String otp_code;
  String emp_id;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    otp_code = Get.arguments[0]['value'];
    emp_id = Get.arguments[1]['emp_id'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('OTP'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100, left: 90, right: 90),
                child: Image.asset('assets/icon/icon.jpg'),
              ),
              SizedBox(
                height: 110,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      controller: controller.userOtpController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (labels?.otp),
                      ),
                      onChanged: (text) {},
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  color: textFieldTapColor,
                  onPressed: () {
                    // controller.forgetPassword();
                    controller.compareOtpCode(otp_code,emp_id);
                  },
                  child: Text(
                    (labels?.submit),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
