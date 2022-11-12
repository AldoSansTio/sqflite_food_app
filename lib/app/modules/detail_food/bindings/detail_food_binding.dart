import 'package:get/get.dart';

import '../controllers/detail_food_controller.dart';

class DetailFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailFoodController>(
      () => DetailFoodController(),
    );
  }
}
