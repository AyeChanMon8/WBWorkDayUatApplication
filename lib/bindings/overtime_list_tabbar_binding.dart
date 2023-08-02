import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/overtime_list_controller.dart';
import 'package:winbrother_hr_app/controllers/overtime_response_list_controller.dart';

class OverTimeTabbarBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => OverTimeListController(),fenix : true);
   Get.lazyPut(() => OverTimeResponseListController(),fenix: true);

  }

}