import 'package:firebase_food_app/app/utils/notifications_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingPageController extends GetxController {
  final sarapanToggle = false.obs;
  final siangToggle = false.obs;
  final malamToggle = false.obs;

  GetStorage box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    NotifictionApi.init();

    if (await box.read('sarapan') != null) {
      sarapanToggle.value = box.read('sarapan');
    }
    if (await box.read('siang') != null) {
      siangToggle.value = box.read('siang');
    }
    if (await box.read('malam') != null) {
      malamToggle.value = box.read('malam');
    }
  }

  void toogleSarapan() async {
    sarapanToggle.toggle();
    box.write("sarapan", sarapanToggle.value);
    if (sarapanToggle.value) {
      NotifictionApi.scheduledNotification(
        id: 1,
        title: "Pengingat Sarapan",
        body: "Sudah waktunya sarapan nih, jangan lupa sarapan ya",
        payload: "sarapan",
        scheduledDate: const Time(7, 0, 0),
      ).then((value) {
        Get.snackbar("Berhasil", "Pengingat sarapan berhasil diaktifkan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      });
    } else {
      NotifictionApi.cancelNotification(1).then((value) => Get.snackbar(
          "Berhasil", "Pengingat sarapan berhasil dinonaktifkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white));
    }
  }

  Future<void> toogleSiang() async {
    siangToggle.toggle();
    box.write("siang", siangToggle.value);
    if (siangToggle.value) {
      await NotifictionApi.scheduledNotification(
        id: 2,
        title: "Pengingat Makan Siang",
        body: "Jangan lupa makan siang ya",
        payload: "siang",
        scheduledDate: const Time(12, 0, 0),
      ).then((value) {
        Get.snackbar("Berhasil", "Pengingat makan siang berhasil diaktifkan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      });
    } else {
      NotifictionApi.cancelNotification(2).then((value) {
        Get.snackbar("Berhasil", "Pengingat makan siang berhasil dinonaktifkan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    }
  }

  void toogleMalam() {
    malamToggle.toggle();
    box.write("malam", malamToggle.value);
    if (malamToggle.value) {
      NotifictionApi.scheduledNotification(
        id: 3,
        title: "Pengingat Makan Malam",
        body: "Jangan lupa makan malam ya",
        payload: "malam",
        scheduledDate: const Time(18, 0, 0),
      ).then((value) {
        Get.snackbar("Berhasil", "Pengingat makan malam berhasil diaktifkan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      });
    } else {
      NotifictionApi.cancelNotification(3).then((value) {
        Get.snackbar("Berhasil", "Pengingat makan malam berhasil dinonaktifkan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    }
  }
}
