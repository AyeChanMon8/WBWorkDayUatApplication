import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/travel_request_update_controller.dart';

class TravelRequestUpdateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TravelRequestUpdateController(),fenix: true);
  }

}