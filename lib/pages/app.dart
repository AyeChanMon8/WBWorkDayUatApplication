import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/bindings/home_binding.dart';
import 'package:winbrother_hr_app/controllers/auth_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/pages/language.dart';
import 'package:winbrother_hr_app/pages/leave_trip_tabbar.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/theme/app_theme.dart';
import 'package:winbrother_hr_app/ui/components/loading.dart';
import 'login_page.dart';

class App extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    Get.put<AuthController>(AuthController());
    var supportLocales = AppLocalizations.languages.keys.toList();
    return GetBuilder<AuthController>(
        builder: (controller) => Loading(
              child: GetMaterialApp(
                enableLog: true,
                locale: controller.getLocale,
                defaultTransition: Transition.fade,
                localizationsDelegates: [
                  const AppLocalizationsDelegate(), // <- Your custom delegate
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: supportLocales,
                debugShowCheckedModeBanner: false,
                initialBinding: HomeBinding(),
                initialRoute: '/',
                theme: appThemeData,
                getPages: AppPages.pages,
                // home: LeaveTripTabBar(),
                //home: LoginPage(),
                // home: controller.isLogin ? SignUpPage() : LoginPage(),
              ),
            ));

    // return GetMaterialApp(
    //   locale: AppLocalizations.languages.keys.first,
    //   localizationsDelegates: [
    //     const AppLocalizationsDelegate(), // <- Your custom delegate
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //   ],
    //   debugShowCheckedModeBanner: false,
    //   initialBinding: HomeBinding(),
    //   initialRoute: '/',
    //   home: LoginPage(),
    //   theme: appThemeData,
    //   defaultTransition: Transition.fade,
    //   getPages: AppPages.pages,
    //   //home: LoginPage(),
    //   // home: Language(),
    //   // supportedLocales: [const Locale('en', 'US'), const Locale('mm', 'MM')],

    //   supportedLocales: AppLocalizations.languages.keys.toList(),
    //   // supportedLocales:
    //   //     AppLocalizations.languages.keys.where((locale) => false),
    // );
  }
}
