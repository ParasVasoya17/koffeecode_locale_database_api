import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kooffee_code_sql/app/modules/add_distributors/views/add_distributors_view.dart';

import '../../../utils/app_colors.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      init: BottomBarController(),
      assignId: true,
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.update();
          },
          child: Scaffold(
              backgroundColor: AppColors.white,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              bottomNavigationBar: Container(
                height: 70.h,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.currentIndex.value = 0;
                          controller.update();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          // margin: EdgeInsets.only(top: 11.h),
                          color: controller.currentIndex.value == 0 ? AppColors.black : AppColors.transparent,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.home,
                            color: controller.currentIndex.value == 0 ? AppColors.white : AppColors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.currentIndex.value = 1;
                          controller.update();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          // margin: EdgeInsets.only(top: 11.h),
                          color: controller.currentIndex.value == 1 ? AppColors.black : AppColors.transparent,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add_box_outlined,
                            color: controller.currentIndex.value == 1 ? AppColors.white : AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: controller.currentIndex.value == 0 ? const HomeView() : const AddDistributorsView()),
        );
      },
    );
  }
}
