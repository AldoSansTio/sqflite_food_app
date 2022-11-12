import 'dart:io';

import 'package:firebase_food_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/add_food_controller.dart';

class AddFoodView extends GetView<AddFoodController> {
  const AddFoodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('NEW RECIPE',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp)),
        centerTitle: true,
        leading: const SizedBox(),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70.h,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  "Super Cool you are creating a new recipe!\n"
                  "Let's get started",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ).paddingSymmetric(horizontal: 20.w),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Text("Give your recipe a name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  TextField(
                    controller: controller.namaController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Menu',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  30.verticalSpace,
                  Text("Lets see the final result",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  20.verticalSpace,
                  Row(
                    children: [
                      controller.image.value.path != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.file(
                                File(controller.image.value.path),
                                height: 200.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await controller.getImage(true);
                              },
                              child: Container(
                                height: 200.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text("Tambah Foto"),
                                ),
                              ),
                            ),
                      Obx(
                        () => Center(
                          child: controller.image.value.path != ""
                              ? IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    controller.image.value = XFile("");
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  Text("Jenis Resep",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  10.verticalSpace,
                  Container(
                    width: 1.sw,
                    height: 50.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                        alignment: Alignment.center,
                        isExpanded: true,
                        underline: const SizedBox(),
                        iconSize: 30,
                        dropdownColor: Colors.red,
                        value: controller.selectedJenis.value,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        items: controller.selectJenis.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.selectedJenis.value = newValue.toString();
                        }),
                  ),
                  20.verticalSpace,
                  Text("Estimasi Waktu Memasak (menit)",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  TextField(
                    controller: controller.waktuPembuatanController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Waktu Pembuatan',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  20.verticalSpace,
                  Text("Deskripsi",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  20.verticalSpace,
                  TextField(
                    controller: controller.deskripsiController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Deskripsi',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  20.verticalSpace,
                  Text("Resep, bahan dan langkah",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp)),
                  20.verticalSpace,
                  TextField(
                    controller: controller.resepController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Resep dan Cara Pembuatan',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (controller.namaController.text.isEmpty ||
                          controller.waktuPembuatanController.text.isEmpty ||
                          controller.deskripsiController.text.isEmpty ||
                          controller.selectedJenis.value.isEmpty ||
                          controller.image.value.path.isEmpty) {
                        Get.snackbar('Error', 'Lengkapi data terlebih dahulu',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            snackStyle: SnackStyle.FLOATING);
                      } else {
                        await controller.saveImages(
                            File(controller.image.value.path),
                            controller.namaController.text,
                            int.parse(controller.waktuPembuatanController.text),
                            controller.deskripsiController.text,
                            controller.selectedJenis.value,
                            controller.resepController.text);
                        Get.snackbar("Berhasil", "Menu berhasil ditambahkan.",
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                        Get.toNamed(Routes.HOME);
                      }
                    },
                    child: Container(
                        width: 1.sw,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text('Add Menu',
                                style: TextStyle(color: Colors.white)))),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
