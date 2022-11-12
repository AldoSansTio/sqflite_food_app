import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/setting_page_controller.dart';

class SettingPageView extends GetView<SettingPageController> {
  const SettingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        20.verticalSpace,
        const Text("Notifications").paddingSymmetric(horizontal: 10),
        20.verticalSpace,
        Obx(
          () => Card(
            child: ListTile(
              title: const Text("Pengingat Sarapan"),
              leading: const Icon(Icons.wb_sunny),
              trailing: Switch(
                value: controller.sarapanToggle.value,
                onChanged: (value) {
                  controller.toogleSarapan();
                },
              ),
            ),
          ),
        ),
        Obx(
          () => Card(
            child: ListTile(
              title: const Text("Pengingat Makan Siang"),
              leading: const Icon(Icons.lunch_dining),
              trailing: Switch(
                value: controller.siangToggle.value,
                onChanged: (value) async {
                  await controller.toogleSiang();
                },
              ),
            ),
          ),
        ),
        Obx(
          () => Card(
            child: ListTile(
              title: const Text("Pengingat Makan Malam"),
              leading: const Icon(Icons.dinner_dining),
              trailing: Switch(
                value: controller.malamToggle.value,
                onChanged: (value) {
                  controller.toogleMalam();
                },
              ),
            ),
          ),
        ),
      ]).paddingSymmetric(horizontal: 10),
    );
  }
}
