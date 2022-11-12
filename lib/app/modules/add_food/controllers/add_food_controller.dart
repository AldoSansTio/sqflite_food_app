import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_food_app/app/data/Food.dart';
import 'package:firebase_food_app/app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodController extends GetxController {
  
  var db = DbHelper(); //Digunakan sebagai penghubung dengan Database

  final image = XFile("").obs; //Digunakan untuk menampung file gambar.

  //TextEditingController untuk setiap textfield
  TextEditingController namaController = TextEditingController();
  TextEditingController waktuPembuatanController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController resepController = TextEditingController();

  //variabel yang menampung jenis makanan untuk filter
  final selectJenis = [
    "Makanan",
    "Minuman",
    "Kuah",
  ];

  //variabel untuk menampung filter yang dipilih
  final selectedJenis = "Makanan".obs;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    if (pickedFile != null) {
      image.value = pickedFile;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    waktuPembuatanController.dispose();
    deskripsiController.dispose();
    resepController.dispose();
    super.onClose();
  }


  Future<void> saveImages(
    File images,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    String resep,
  ) async {
    Get.bottomSheet(
      Container(
          height: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          )),
    );
    String image = db.base64String(await images.readAsBytes());
    final data = Food(
        nama: nama,
        deskripsi: deskripsi,
        waktuPembuatan: int.parse(waktuPembuatan.toString()),
        jenis: jenis,
        resep: resep,
        images: image);
    db.insertFood(data);
    Get.back();
  }
}
