import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_food_app/app/data/Food.dart';
import 'package:firebase_food_app/app/routes/app_pages.dart';
import 'package:firebase_food_app/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //search bar
              children: [
                Image.asset("assets/images/food.jpg").paddingOnly(right: 10.w),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: HomeSearchDelegate(controller));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 18.r,
                              color: Colors.grey[500],
                            ),
                            20.horizontalSpace,
                            Text(
                              "Search",
                              style: TextStyle(fontSize: 12.sp),
                            )
                          ],
                        ).paddingAll(10.r),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_FOOD);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Katalog Resep Makanan",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.SETTING_PAGE);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.red,
                  ))
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  controller.buttonText.length,
                  (index) => button(
                    index: index,
                    text: controller.buttonText[index],
                    image: controller.iconButton[index],
                  ).paddingOnly(right: 10.w),
                )
              ],
            ).paddingSymmetric(vertical: 10.h),
          ),
          10.verticalSpace,
          Flexible(
            child: Obx(
              () => FutureBuilder<List<Food>>(
                  future: controller.readRecipe(controller
                      .buttonText[controller.selectedValueIndex.value]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.h,
                          crossAxisCount: 2,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL,
                                arguments: snapshot.data![index].id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.h,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                    topRight: Radius.circular(
                                      ScreenUtil().setWidth(10),
                                    ),
                                  ),
                                  child: Image(
                                    image: MemoryImage(
                                      controller.getImage(
                                          snapshot.data![index].images),
                                    ),
                                    height: 100.h,
                                    width: 200.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        snapshot.data![index].nama,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.alarm,
                                                color: Colors.grey[600],
                                              ),
                                              5.horizontalSpace,
                                              Text(
                                                "${snapshot.data![index].waktuPembuatan} Menit",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.r,
                                              vertical: 5.r,
                                            ),
                                            height: 26.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                                color: getColor(snapshot
                                                        .data?[index].jenis ??
                                                    "")),
                                            child: Text(
                                              "${snapshot.data?[index].jenis}",
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      15.verticalSpace,
                                    ],
                                  ).paddingOnly(
                                      top: 10.h, left: 10.w, right: 10.w),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: snapshot.data?.length,
                      );
                    } else {
                      return const Center(
                        child: Text("Data Kosong"),
                      );
                    }
                  }),
            ),
          )
        ],
      ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
    );
  }

  Widget button(
      {required String text, required int index, required String image}) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedValueIndex.value = index;
        },
        child: Container(
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: controller.selectedValueIndex.value == index
                ? Colors.red
                : Colors.white,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(10),
            ),
            border: Border.all(
              color: Colors.red,
              width: 1.h,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 20.h,
                  width: 20.w,
                ),
                5.horizontalSpace,
                Text(
                  text,
                  style: TextStyle(
                    color: controller.selectedValueIndex.value == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: ScreenUtil().setSp(11),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
