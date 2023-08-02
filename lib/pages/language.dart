// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/auth_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final AuthController controller = Get.put(
    AuthController(),
  );
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 1,
        title: Text(
          "Langauge",
          style: TextStyle(color: Colors.black),
        ),
      ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                   bottom: BorderSide(color: Colors.grey.withOpacity(.5))),
//             ),
//             child: ListTile(
// //               onTap: () async {
// // //              application.onLocaleChanged(Locale("en"));

// //                 // await SharedPref.setData(key: SharedPref.langauge, value: "en")
// //                     .then((b) {
// //                   application.onLocaleChanged(Locale(languagesMap["English"]));
// //                 });
// //               },
//               title: Text(
//                 ("english"),
//               ),
//               trailing: Icon(Icons.chevron_right),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                   bottom: BorderSide(color: Colors.grey.withOpacity(.5))),
//             ),
//             child: ListTile(
//               // onTap: () async {
//               //   await SharedPref.setData(key: SharedPref.langauge, value: "mm")
//               //       .then((b) {
//               //     application.onLocaleChanged(Locale(languagesMap["မြန်မာ"]));
//               //   });
//               // },

//               // onTap: () {
//               //   controller.updateLanguage();
//               // },
//               title: Text(
//                 ("myanmar"),
//               ),
//               trailing: Icon(Icons.chevron_right),
//             ),
//           ),
//         ],
//       ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Image(image: AssetImage('assets/images/myanmarflag.png')),
                SizedBox(width: 10),
                Text(
                  "Myanmar",
                  style: subTitleStyle(),
                ),
                SizedBox(width: 13),
                Radio(
                  value: "my",
                  groupValue: controller.currentLanguageStore.value,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    controller.updateLanguage(val);
                  },
                ),
              ],
            ),

            Row(
              children: [
                Image(image: AssetImage('assets/images/unitedflag.png')),
                SizedBox(width: 10),
                Text(
                  "English(US)",
                  style: subTitleStyle(),
                ),
                Radio(
                  value: "en",
                  groupValue: controller.currentLanguageStore.value,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    controller.updateLanguage(val);
                  },
                ),
              ],
            )

            // SizedBox(
            //   width: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
