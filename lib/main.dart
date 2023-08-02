// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/pages/app.dart';
import 'package:winbrother_hr_app/pages/pre_page.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize(debug: debug);  package downloader not need now
  await GetStorage.init();
  runApp(App());
}
