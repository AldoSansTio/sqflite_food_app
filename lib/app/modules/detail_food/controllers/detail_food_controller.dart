import 'dart:io';

import 'package:firebase_food_app/app/data/Food.dart';
import 'package:firebase_food_app/app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class DetailFoodController extends GetxController with StateMixin {
  var db = DbHelper();
  Color dominantColor = Colors.red;
  var food = Get.arguments as int;


  Future<void> deleteMenu(int id) async {
    await db.deleteFood(id);
  }

  Future<void> updateMenu(int id, String nama, int waktuPembuatan,
      String deskripsi, String jenis, String image, String resep) async {
    change(null, status: RxStatus.loading());
    final data = Food(
        nama: nama,
        deskripsi: deskripsi,
        waktuPembuatan: int.parse(waktuPembuatan.toString()),
        jenis: jenis,
        resep: resep,
        images: image);
    db.updateFood(data);
  }

  Future<void> updateMenuWithImage(
    int id,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    File images,
    String resep,
  ) async {
    change(null, status: RxStatus.loading());
    String image = db.base64String(await images.readAsBytes());
    final data = Food(
      id: id,
      nama: nama,
      waktuPembuatan: waktuPembuatan,
      deskripsi: deskripsi,
      jenis: jenis,
      images: image,
      resep: resep,
    );
    db.updateFood(data);
  }

  Future<Color> updatePaletteGenerator(String path) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(path),
    );
    return paletteGenerator.dominantColor!.color;
  }

  @override
  void onInit() async {
    super.onInit();

    change(null, status: RxStatus.empty());
  }
}
