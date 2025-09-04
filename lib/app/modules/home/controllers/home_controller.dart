import 'dart:io';
import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  File? image;

  ImagePicker picker = ImagePicker();

  List<Tab> tabs = [Tab(text: "Register"), Tab(text: "Recognize")];
  late TabController controller;

  TextEditingController name = TextEditingController();

  RxInt index = 0.obs;

  FaceDetector detector = FaceDetector(options: FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate));

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: tabs.length, vsync: this);

    controller.addListener(() {
      if (controller.indexIsChanging) {
        index.value = controller.index;
        onRemoveImage();
      }
      update();
    });
  }

  ///Functionality For Pick or Capture Image
  onPickOrCaptureImage(ImageSource source, int index) async {
    XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      image = File(file.path);
      onFaceDetection();
    }
    update();
  }

  ///Functionality for Remove or Clear Image
  onRemoveImage({index = 0}) {
    if (image != null) image = null;
    if (index == 0) name.clear();
    update();
  }

  ///Functionality for Face Detection
  onFaceDetection() async {
    InputImage input_image = InputImage.fromFile(image!);

    final List<Face> faces = await detector.processImage(input_image);

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;
      debugPrint("Rect= $boundingBox");
    }
  }
}
