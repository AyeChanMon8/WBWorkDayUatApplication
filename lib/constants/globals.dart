import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/models/menu_option_model.dart';

class Globals {
  static final String defaultLanguage = 'en';

  //static final String baseURL = "https://www.wbholdings.biz/api"; // LIVE
  // static final String baseURL = "http://46.137.251.232:8013/api";
  //static final String baseURL = "http://13.214.89.170:8013/api"; // TEST
  //   static final String baseURL = "http://www.uatwbholdings.biz/api";
  //static final String baseURL = "http://100.21.115.20:8069/api"; // Production Server
  //static final String baseURL = "http://100.21.115.20:8013/api"; // UAT
  //static final String baseURL = "http://192.168.100.3:8023/api"; //local
  static final String baseURL = "http://192.168.100.3:8023/api"; //local
  //static final String baseURL = "http://52.74.227.97/api"; //local
  //static final String baseURL = "http://172.20.10.2:8013/api";
  //static final RxBool ph_hardware_back = true.obs;
  static final String username = "__system__";
  static final String password = "sysadmin";
  static final String token = "TOKEN";
  static final String tokenDate = "TOKEN_DATE";
  static final String check_in_or_not = "false";
  static final int pag_limit = 100;
  static final String app_version = "6.18";

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "en", value: "English"), //English
    MenuOptionsModel(key: "mm", value: "Myanmar"), //Spanish
  ];
  static final Color primaryColor = Color.fromARGB(255, 63, 51, 128);
}
