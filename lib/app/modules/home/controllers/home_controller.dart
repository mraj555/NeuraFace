import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  File? image;

  ImagePicker picker = ImagePicker();

  List<Tab> tabs = [Tab(text: "Register"), Tab(text: "Recognize")];
  late TabController controller;

  TextEditingController name = TextEditingController();

  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: tabs.length, vsync: this);

    controller.addListener(() {
      index.value = controller.index;
      update();
    });
  }

  ///Functionality For Pick or Capture Image
  onPickOrCaptureImage(ImageSource source, int index) async {
    XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      image = File(file.path);
    }
    update();
  }

  ///Functionality for Remove or Clear Image
  onRemoveImage({index = 0}) {
    if (image != null) image = null;
    if (index == 0) name.clear();
    update();
  }
}
