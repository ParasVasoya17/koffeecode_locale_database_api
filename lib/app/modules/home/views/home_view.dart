import '../../../utils/all_imports.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      init: HomeController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text("${AppStrings.retailer} ${AppStrings.distributor}"),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  10.verticalSpace,
                  TextField(
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                      labelText: "Search Distributors",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      controller.searchDistributors(value);
                      controller.update();
                    },
                  ),
                  10.verticalSpace,
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
                  // Distributor List
                  Expanded(
                    child: Obx(
                      () {
                        // Use searchResults for filtering
                        final results = controller.searchResults;

                        if (results.isEmpty) {
                          return const Center(child: Text("No distributors found."));
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          controller: controller.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            return controller.searchResults[index].type != controller.retailer.value
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.ADD_DISTRIBUTORS, arguments: [controller.searchResults[index].id, controller.searchResults[index]]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.w),
                                      margin: EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                        // border: Border.all(
                                        //   color: AppColors.black,
                                        // ),
                                        boxShadow: const [
                                          BoxShadow(color: AppColors.grey),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  controller.searchResults[index].businessName ?? "",
                                                  fontSize: 25.sp,
                                                  maxLines: 1,
                                                  fontFamily: FontFamily.regular,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.wrong_location_rounded),
                                                    10.horizontalSpace,
                                                    Expanded(
                                                      child: AppText(
                                                        controller.searchResults[index].address ?? "N/A",
                                                        fontSize: 20.sp,
                                                        maxLines: 2,
                                                        fontFamily: FontFamily.regular,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    AppText(
                                                      AppStrings.status,
                                                      fontSize: 20.sp,
                                                      maxLines: 2,
                                                      fontFamily: FontFamily.regular,
                                                      color: AppColors.black,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    AppText(
                                                      controller.searchResults[index].isApproved ?? "N/A",
                                                      fontSize: 20.sp,
                                                      maxLines: 2,
                                                      fontFamily: FontFamily.regular,
                                                      color: AppColors.green,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Icon(Icons.more_vert_rounded, size: 20.w),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
