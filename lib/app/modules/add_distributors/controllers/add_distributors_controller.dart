import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../helper/database_helper.dart';
import '../../../models/retailer_distributor_model.dart';
import '../../../utils/all_imports.dart';

class AddDistributorsController extends GetxController {
  Data? retailerDistributorData;

  RxString id = "".obs;
  RxString retailer = AppStrings.retailer.obs;

  TextEditingController businessName = TextEditingController();
  TextEditingController businessType = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();

  String? selectedBrand;
  String? state;
  String? city;
  String? region;
  String? area;
  String? bankName;
  final List<String> items = ["Option 1", "Option 2", "Option 3", "Option 4"];

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      id.value = Get.arguments[0];
      retailerDistributorData = Get.arguments[1];
      await initializeData();
      update();
    }
    super.onInit();
  }

  initializeData() {
    businessName.text = retailerDistributorData?.businessName ?? "";
    businessType.text = retailerDistributorData?.businessType ?? "";
    address.text = retailerDistributorData?.address ?? "";
    gst.text = retailerDistributorData?.gstNo ?? "";
    pin.text = retailerDistributorData?.pincode ?? "";
    name.text = retailerDistributorData?.name ?? "";
    mobile.text = retailerDistributorData?.mobile ?? "";

    // selectedBrand = retailerDistributorData?.brands;
    // state = retailerDistributorData?.state;
    // city = retailerDistributorData?.city;
    // region = retailerDistributorData?.regionId;
    // area = retailerDistributorData?.areaId;
    // bankName = retailerDistributorData?.bankAccountId;
    retailer.value = retailerDistributorData?.type ?? AppStrings.retailer;

    update();
  }

  addDistributors() async {
    Loading.show();
    var headers = {
      'Authorization': '4ccda7514adc0f13595a585205fb9761',
    };
    FormData data = id.value.isNotEmpty
        ? FormData.fromMap({
            'business_name': businessName.text,
            'business_type': businessType.text,
            'gst_no': gst.text,
            'address': address.text,
            'pincode': pin.text,
            'name': name.text,
            'mobile': mobile.text,
            'state': state,
            'city': city,
            'region_id': region,
            'area_id': area,
            'app_pk': retailerDistributorData?.appPk ?? "1",
            'id': id.value,
            'user_id': '45',
            'bank_account_id': bankName,
            'type': retailer.value,
            'brand_ids': selectedBrand
          })
        : FormData.fromMap({
            'business_name': businessName.text,
            'business_type': businessType.text,
            'gst_no': gst.text,
            'address': address.text,
            'pincode': pin.text,
            'name': name.text,
            'mobile': mobile.text,
            'state': state,
            'city': city,
            'region_id': region,
            'area_id': area,
            'app_pk': '1',
            'user_id': '45',
            'bank_account_id': bankName,
            'type': retailer.value,
            'brand_ids': selectedBrand
          });

    var dio = Dio();
    var response = await dio.request(
      AppApiConstants.baseUrl + AppApiConstants.addUpdateDistributors,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Fluttertoast.showToast(
        msg: response.statusMessage ?? "Success",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AppColors.white,
        backgroundColor: AppColors.black,
        timeInSecForIosWeb: 5,
      );
      if (id.value.isNotEmpty) {
        await updateDataInLocale();
      }
      Get.offAllNamed(Routes.BOTTOM_BAR);
    } else {
      print(response.statusMessage);
      Fluttertoast.showToast(
        msg: response.statusMessage ?? "error!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AppColors.white,
        backgroundColor: AppColors.black,
        timeInSecForIosWeb: 5,
      );
    }
    Loading.dismiss();
  }

  validation() {
    if (businessName.text.trim().isEmpty ||
        businessType.text.trim().isEmpty ||
        address.text.trim().isEmpty ||
        gst.text.trim().isEmpty ||
        pin.text.trim().isEmpty ||
        name.text.trim().isEmpty ||
        mobile.text.trim().isEmpty ||
        selectedBrand == null ||
        state == null ||
        city == null ||
        region == null ||
        area == null ||
        bankName == null) {
      Fluttertoast.showToast(
        msg: "Please Fill All Data!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AppColors.white,
        backgroundColor: AppColors.black,
        timeInSecForIosWeb: 5,
      );
    } else {
      addDistributors();
    }
  }

  updateDataInLocale() async {
    try {
      Data data = Data(
        address: address.text,
        image: retailerDistributorData?.image ?? "",
        appPk: retailerDistributorData?.appPk ?? "1",
        areaId: area,
        bankAccountId: bankName,
        brands: selectedBrand,
        businessName: businessName.text,
        businessType: businessType.text,
        city: city,
        closeTime: retailerDistributorData?.closeTime,
        gstNo: gst.text,
        id: id.value,
        isApproved: retailerDistributorData?.isApproved,
        isAsync: retailerDistributorData?.isAsync,
        isDelete: retailerDistributorData?.isDelete,
        mobile: mobile.text,
        name: name.text,
        openTime: retailerDistributorData?.openTime,
        parentId: retailerDistributorData?.parentId,
        pincode: pin.text,
        regionId: region,
        state: state,
        type: retailerDistributorData?.type,
      );
      await DatabaseHelper().updateDataById(id.value, data);
    } on Exception catch (e) {
      print("error $e");
    }
  }
}
