import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuraface/app/theme/app_theme.dart';
import 'package:neuraface/app/utils/image_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NeuraFace'), centerTitle: true, backgroundColor: Colors.black, foregroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabBar(tabs: controller.tabs, controller: controller.controller, isScrollable: false, physics: NeverScrollableScrollPhysics(), indicatorWeight: 3),
            Expanded(
              child: TabBarView(
                controller: controller.controller,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(2, (index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.blue_zodiac, AppTheme.daisy_bush, AppTheme.violent_violet],
                              stops: [0.0, 0.5, 1.0],
                              transform: GradientRotation(155.2 * 3.1416 / 180),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(12.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(),
                              Flexible(
                                child: GetBuilder<HomeController>(
                                  builder: (_) {
                                    return Container(
                                      height: 400.h,
                                      width: 250.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15).r,
                                        image: controller.image != null ? DecorationImage(image: FileImage(controller.image!), fit: BoxFit.contain) : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: controller.image == null
                                          ? Icon(Icons.image_outlined, size: 100.sp, color: Colors.grey.withValues(alpha: 0.8))
                                          : null,
                                    );
                                  },
                                ),
                              ),
                              Obx(
                                () => controller.index.value == 0
                                    ? Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              controller: controller.name,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: "Enter Name",
                                                isDense: true,
                                                isCollapsed: true,
                                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8).r,
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15).r,
                                                  borderSide: BorderSide(color: AppTheme.daisy_bush),
                                                ),
                                                disabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15).r,
                                                  borderSide: BorderSide(color: AppTheme.daisy_bush),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15).r,
                                                  borderSide: BorderSide(color: AppTheme.daisy_bush),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15).r,
                                                  borderSide: BorderSide(color: AppTheme.daisy_bush),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15).r,
                                                  borderSide: BorderSide(color: AppTheme.daisy_bush),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          GetBuilder<HomeController>(
                                            builder: (_) {
                                              return IconButton(
                                                onPressed: controller.image != null ? () {} : null,
                                                icon: Icon(Icons.send),
                                                style: IconButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.blue,
                                                  disabledBackgroundColor: Colors.grey,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ///Gallery Icon
                            TextButton.icon(
                              onPressed: () => controller.onPickOrCaptureImage(ImageSource.gallery, controller.index.value),
                              label: Text("Gallery"),
                              icon: ImageIcon(AssetImage(ImageUtils.gallery), size: 20.sp),
                              style: TextButton.styleFrom(foregroundColor: Colors.white),
                            ),
                            TextButton.icon(
                              onPressed: () => controller.onPickOrCaptureImage(ImageSource.camera, controller.index.value),
                              label: Text("Camera"),
                              icon: ImageIcon(AssetImage(ImageUtils.camera), size: 20.sp),

                              style: TextButton.styleFrom(foregroundColor: Colors.white),
                            ),
                            TextButton.icon(
                              onPressed: () => controller.onRemoveImage(index: controller.index.value),
                              label: Text("Remove"),
                              icon: ImageIcon(AssetImage(ImageUtils.remove), size: 20.sp),
                              style: TextButton.styleFrom(foregroundColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
