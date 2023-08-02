// @dart=2.9
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/user.dart';
import 'dart:async';
import 'package:winbrother_hr_app/services/auth_service.dart';
import 'package:winbrother_hr_app/ui/components/loading.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  AuthService authService;
  final otp = ''.obs;
  final language = "".obs;
  final store = GetStorage();
  String get currentLanguage => language.value;
  final RxBool show_loading = false.obs;

  // AuthController({@required this.authService}) : assert(authService != null);

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final RxBool isLogin = false.obs;
  Rx<User> loginUser = Rx<User>();

  generateToken() async {
    showLoadingIndicator();
    String mobile = phoneController.text.trim();
    otp.value = '';
    await authService.generateToken(mobile).then((data) {
      otp.value = data;
      //hideLoadingIndicator();
    });
  }

  loginMobile(mobile, token) {
    isLogin.value = true;
  }

  // Gets current language stored
  RxString get currentLanguageStore {
    String currentLang = null;
    if (store.read('language') == null) {
      currentLang = "en";
      updateLanguage(currentLang);
      language.value = currentLang;
    } else {}
    language.value = store.read('language');
    return language;
  }

  // gets the language locale app is set to
  Locale get getLocale {
    if ((currentLanguageStore.value == '') ||
        (currentLanguageStore.value == null)) {
      language.value = Globals.defaultLanguage;
      updateLanguage(Globals.defaultLanguage);
    }
    // gets the default language key (from the translation language system)
    Locale _updatedLocal = AppLocalizations.languages.keys.first;
    if (store.read('language') != null) {
      language.value = store.read('language');
    }
    // looks for matching language key stored and sets to it
    AppLocalizations.languages.keys.forEach((locale) {
      if (locale.languageCode == currentLanguage) {
        _updatedLocal = locale;
      }
    });
    return _updatedLocal;
  }

  // updates the language stored
  Future<void> updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    Locale loc = getLocale;
    Get.updateLocale(loc);
    update();
  }

  @override
  void onReady() async {
    //run every time auth state changes
    super.onReady();
  }

  @override
  void onClose() {
    phoneController?.dispose();
    otpController?.dispose();
    super.onClose();
  }

  // Sign out
  Future<void> signOut() {
    otp.value = '';
    phoneController.clear();
    otpController.clear();
    isLogin.value = false;
    loginUser.value = null;
  }
}
