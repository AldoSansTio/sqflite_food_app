import 'package:get/get.dart';

import '../modules/add_food/bindings/add_food_binding.dart';
import '../modules/add_food/views/add_food_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detail_food/bindings/detail_food_binding.dart';
import '../modules/detail_food/views/detail_food_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/setting_page/bindings/setting_page_binding.dart';
import '../modules/setting_page/views/setting_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FOOD,
      page: () => const AddFoodView(),
      binding: AddFoodBinding(),
    ),
    // GetPage(
    //   name: _Paths.DETAIL_FOOD,
    //   page: () => const DetailFoodView(),
    //   binding: DetailFoodBinding(),
    // ),
    GetPage(
      name: _Paths.SETTING_PAGE,
      page: () => const SettingPageView(),
      binding: SettingPageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
