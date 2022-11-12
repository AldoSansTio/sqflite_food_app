import 'package:get/get.dart';

import '../controllers/add_food_controller.dart';

class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFoodController>(
      () => AddFoodController(),
    );
  }
}
