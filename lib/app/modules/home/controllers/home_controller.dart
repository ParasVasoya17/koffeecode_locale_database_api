import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/debouncer.dart';
import '../../../models/retailer_distributor_model.dart';
import '../../../utils/all_imports.dart';

class HomeController extends GetxController {
  RetailerDistributorModel? retailerDistributorData;
  ScrollController scrollController = ScrollController();
  final Debounce debounce = Debounce(milliseconds: 500);
  int pageNo = 1;
  bool _isLoading = false;
  bool isAllDataLoaded = false;
  RxBool isDistributorDataLoaded = false.obs;
  RxString retailer = AppStrings.retailer.obs;

  TextEditingController searchController = TextEditingController();
  RxList<Data> searchResults = <Data>[].obs;

  @override
  Future<void> onInit() async {
    searchController.addListener(() {
      searchDistributors(searchController.text);
    });

    scrollController.addListener(_onScroll);
    await loadLocalData();
    if (retailerDistributorData == null) {
      loadMoreDistributors(isLoading: true);
    } else {
      pageNo = int.parse(retailerDistributorData?.page ?? "1");
    }
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      loadMoreDistributors(isLoading: true);
    }
  }

  clearPagination() {
    isAllDataLoaded = false;
    pageNo = 1;
    isDistributorDataLoaded.value = false;
    retailerDistributorData = null;
  }

  // Future<void> loadMoreDistributors({bool? isLoading}) async {
  //   if (!_isLoading && !isAllDataLoaded) {
  //     Loading.show();
  //     _isLoading = true;
  //     String apiName = "${AppApiConstants.baseUrl + AppApiConstants.getDistributors}/$pageNo";
  //
  //     var headers = {
  //       'Authorization': '4ccda7514adc0f13595a585205fb9761',
  //     };
  //     var data = '''''';
  //     var dio = Dio();
  //     var response = await dio.request(
  //       apiName,
  //       options: Options(
  //         method: 'GET',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     RetailerDistributorModel model = RetailerDistributorModel.fromJson(response.data);
  //     if (response.statusCode == 200) {
  //       if (retailerDistributorData == null) {
  //         retailerDistributorData = model.data!.isEmpty ? null : model;
  //       } else {
  //         retailerDistributorData?.data?.addAll(model.data ?? []);
  //       }
  //
  //       if (model.data!.isEmpty || model.data!.length < 20) {
  //         isAllDataLoaded = true;
  //       } else {
  //         pageNo++;
  //       }
  //
  //       _isLoading = false;
  //       isDistributorDataLoaded.value = true;
  //       update();
  //     } else {
  //       print(response.statusMessage);
  //     }
  //     Loading.dismiss();
  //     update();
  //   }
  // }

  Future<void> loadMoreDistributors({bool? isLoading}) async {
    print("isconnected ${await isConnected()}  ${!_isLoading}---${!isAllDataLoaded}");
    if (await isConnected()) {
      if (!_isLoading && !isAllDataLoaded) {
        Loading.show();
        _isLoading = true;

        String apiName = "${AppApiConstants.baseUrl + AppApiConstants.getDistributors}/$pageNo";

        var headers = {
          'Authorization': '4ccda7514adc0f13595a585205fb9761',
        };
        var dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 10), // 5 seconds
          receiveTimeout: const Duration(seconds: 10),
        ));
        var response = await dio.get(apiName, options: Options(headers: headers));

        if (response.statusCode == 200) {
          RetailerDistributorModel model = RetailerDistributorModel.fromJson(response.data);
          if (model.data != null && model.data!.isNotEmpty) {
            try {
              for (var item in model.data!) {
                await DatabaseHelper().insertData(item);
              }
            } catch (e) {
              print("error retailerDistributorData?.data $e");
            }

            // Refresh the local data list
            try {
              await loadLocalData();
              print("retailerDistributorData?.data ${retailerDistributorData?.data?[0].isApproved} ");
            } on Exception catch (e) {
              // TODO
            }
          }

          // Check for pagination
          if (model.data!.isEmpty || /*model.data!.length < 20*/ model.numberOfPage == pageNo) {
            isAllDataLoaded = true;
          } else {
            pageNo++;
          }
        } else {
          print(response.statusMessage);
        }

        _isLoading = false;
        Loading.dismiss();
        update();
      } else {
        Fluttertoast.showToast(
          msg: "All data loaded!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          textColor: AppColors.white,
          backgroundColor: AppColors.black,
          timeInSecForIosWeb: 5,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "No Internet!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AppColors.white,
        backgroundColor: AppColors.black,
        timeInSecForIosWeb: 5,
      );
    }
  }

  void searchDistributors(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(retailerDistributorData?.data ?? []);
    } else {
      searchResults.assignAll(
        retailerDistributorData?.data
                ?.where((item) =>
                    /*item.type == retailer.value &&*/
                    ((item.businessName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                        (item.address?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                        (item.name?.toLowerCase().contains(query.toLowerCase()) ?? false)))
                .toList() ??
            [],
      );
    }
  }

  Future<void> loadLocalData() async {
    final data = await DatabaseHelper().fetchAllData();
    retailerDistributorData ??= RetailerDistributorModel(data: []);
    retailerDistributorData?.data = data;
    searchResults.assignAll(retailerDistributorData?.data ?? []);
    update();
  }

  Future<void> updateCustomer(Data updatedData) async {
    await DatabaseHelper().updateData(updatedData);
    await loadLocalData(); // Refresh local data
  }

  Future<void> deleteCustomer(String id) async {
    await DatabaseHelper().deleteData(id);
    await loadLocalData(); // Refresh local data
  }

  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      }
    } on Exception catch (e) {
      print("error  $e");
    }
    return false;
  }
}
