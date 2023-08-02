import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/purchase_order_controller.dart';

class PurchaseOrderBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => PurchaseOrderController(),fenix : true);

  }
}
