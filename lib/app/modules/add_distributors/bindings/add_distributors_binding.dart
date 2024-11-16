import 'package:get/get.dart';

import '../controllers/add_distributors_controller.dart';

class AddDistributorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDistributorsController>(
      () => AddDistributorsController(),
    );
  }
}
