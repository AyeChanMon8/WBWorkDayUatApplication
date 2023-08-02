import 'package:rxdart/rxdart.dart';
import 'package:winbrother_hr_app/shared_pref.dart';


class ThemeBloc {
  /*final nightMode = PublishSubject<String>();
  Observable<String> get nightModeStream => nightMode.stream;

  changeDarkMode(String b) async {
    await SharedPref.setData(key: SharedPref.isNightMode, value: b).then((s) {
      nightMode.sink.add(b);
    });
  }

  listenDarkMode() async {
    await SharedPref.getData(key: SharedPref.isNightMode).then((s) {
      if (s == null || s == "off") {
        nightMode.sink.add("off");
      } else {
        nightMode.sink.add("on");
      }
    });
  }

  void dispose() {
    nightMode.close();
  }*/
}
