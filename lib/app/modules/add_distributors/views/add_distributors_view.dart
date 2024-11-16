import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/all_imports.dart';
import '../../../widget/common_drop_down.dart';
import '../../../widget/common_textfield.dart';
import '../controllers/add_distributors_controller.dart';

class AddDistributorsView extends GetView<AddDistributorsController> {
  const AddDistributorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDistributorsController>(
      assignId: true,
      init: AddDistributorsController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            controller.update();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Distributors/Retailers '),
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsets.all(10.w),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.retailer.value = AppStrings.retailer;
                          controller.update();
                        },
                        child: Container(
                          height: 60.h,
                          color: controller.retailer.value == AppStrings.retailer ? AppColors.black : AppColors.white,
                          alignment: Alignment.center,
                          child: AppText(
                            AppStrings.retailer,
                            fontSize: 20.sp,
                            fontFamily: FontFamily.regular,
                            color: controller.retailer.value == AppStrings.retailer ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.retailer.value = AppStrings.distributor;
                          controller.update();
                        },
                        child: Container(
                          height: 60.h,
                          color: controller.retailer.value == AppStrings.distributor ? AppColors.black : AppColors.white,
                          alignment: Alignment.center,
                          child: AppText(
                            AppStrings.distributor,
                            fontSize: 20.sp,
                            fontFamily: FontFamily.regular,
                            color: controller.retailer.value == AppStrings.distributor ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.businessName,
                  controller: controller.businessName,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.businessType,
                  controller: controller.businessType,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CustomDropdown(
                  value: controller.selectedBrand,
                  hintText: "Select",
                  title: AppStrings.selectBrand,
                  items: controller.items,
                  onChanged: (String? newValue) {
                    controller.selectedBrand = newValue;
                    controller.update();
                  },
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        value: controller.state,
                        title: AppStrings.state,
                        hintText: "Select",
                        items: controller.items,
                        onChanged: (String? newValue) {
                          controller.state = newValue;
                          controller.update();
                        },
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: CustomDropdown(
                        value: controller.city,
                        title: AppStrings.city,
                        hintText: "Select",
                        items: controller.items,
                        onChanged: (String? newValue) {
                          controller.city = newValue;
                          controller.update();
                        },
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        value: controller.region,
                        title: AppStrings.region,
                        hintText: "Select",
                        items: controller.items,
                        onChanged: (String? newValue) {
                          controller.region = newValue;
                          controller.update();
                        },
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: CustomDropdown(
                        value: controller.area,
                        title: AppStrings.area,
                        hintText: "Select",
                        items: controller.items,
                        onChanged: (String? newValue) {
                          controller.area = newValue;
                          controller.update();
                        },
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                CustomDropdown(
                  value: controller.bankName,
                  title: AppStrings.selectBank,
                  hintText: "Select",
                  items: controller.items,
                  onChanged: (String? newValue) {
                    controller.bankName = newValue;
                    controller.update();
                  },
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.address,
                  controller: controller.address,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.gst,
                  controller: controller.gst,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.pin,
                  controller: controller.pin,
                  keyboardType: TextInputType.number,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.name,
                  controller: controller.name,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                10.verticalSpace,
                CommonTextFiled(
                  title: AppStrings.mobile,
                  controller: controller.mobile,
                  keyboardType: TextInputType.phone,
                  isMaxLines: true,
                  maxLines: 1,
                ),
                20.verticalSpace,
                GestureDetector(
                  onTap: () {
                    controller.validation();
                  },
                  child: Container(
                    height: 60.h,
                    color: AppColors.black,
                    alignment: Alignment.center,
                    child: AppText(
                      AppStrings.submit,
                      fontSize: 24.sp,
                      fontFamily: FontFamily.regular,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
