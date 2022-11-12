import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_food_app/app/data/Food.dart';
import 'package:firebase_food_app/app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

class DetailController extends GetxController with StateMixin {
  var db = DbHelper();
  var foodId = Get.arguments as int;
  late Food foods;
  Color dominantColor = Colors.red;
  final image = XFile("").obs;

  Future<Food> getFood(int id) async {
    return db.getById(id);
  }

  Future<void> deleteMenu(int id) async {
    await db.deleteFood(id);
  }

  Future<void> updateMenu(
    int id,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    String images,
    String resep,
  ) async {
    change(null, status: RxStatus.loading());
    final data = Food(
        nama: nama,
        deskripsi: deskripsi,
        waktuPembuatan: int.parse(waktuPembuatan.toString()),
        jenis: jenis,
        resep: resep,
        images: images);
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

  Uint8List getImage(String base64String) {
    return db.dataFromBase64String(base64String);
  }
  String base64ToString(Uint8List data) {
    return db.base64String(data);
  }

  Future pickImage(bool gallery) async {
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
  void onInit() async {
    super.onInit();

    change(null, status: RxStatus.empty());
  }
}
