import 'package:get/get.dart';

import '../controllers/setting_page_controller.dart';

class SettingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingPageController>(
      () => SettingPageController(),
    );
  }
}
