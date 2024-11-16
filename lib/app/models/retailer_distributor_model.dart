class RetailerDistributorModel {
  String? st;
  String? msg;
  String? limit;
  int? numberOfPage;
  String? total;
  String? page;
  List<Data>? data;

  RetailerDistributorModel({
    this.st,
    this.msg,
    this.limit,
    this.numberOfPage,
    this.total,
    this.page,
    this.data,
  });

  // Factory constructor for creating an instance from a JSON object
  factory RetailerDistributorModel.fromJson(Map<String, dynamic> json) {
    return RetailerDistributorModel(
      st: json['st'] as String?,
      msg: json['msg'] as String?,
      limit: json['limit'] as String?,
      numberOfPage: json['number_of_page'] as int?,
      total: json['total'] as String?,
      page: json['page'] as String?,
      data: (json['data'] as List?)?.map((e) => Data.fromJson(e)).toList(),
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'st': st,
      'msg': msg,
      'limit': limit,
      'number_of_page': numberOfPage,
      'total': total,
      'page': page,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  final String? id;
  final String? type;
  final String? businessName;
  final String? businessType;
  final String? gstNo;
  final String? address;
  final String? pincode;
  final String? name;
  final String? mobile;
  final String? state;
  final String? city;
  final String? regionId;
  final String? areaId;
  final String? appPk;
  final String? image;
  final String? bankAccountId;
  final String? isApproved;
  final String? openTime;
  final String? closeTime;
  final String? parentId;
  final String? isAsync;
  final String? brands;
  final String? isDelete;

  Data({
    this.id,
    this.type,
    this.businessName,
    this.businessType,
    this.gstNo,
    this.address,
    this.pincode,
    this.name,
    this.mobile,
    this.state,
    this.city,
    this.regionId,
    this.areaId,
    this.appPk,
    this.image,
    this.bankAccountId,
    this.isApproved,
    this.openTime,
    this.closeTime,
    this.parentId,
    this.isAsync,
    this.brands,
    this.isDelete,
  });

  // Factory constructor for creating an instance from a JSON object
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String?,
      type: json['type'] as String?,
      businessName: json['business_name'] as String?,
      businessType: json['business_type'] as String?,
      gstNo: json['gst_no'] as String?,
      address: json['address'] as String?,
      pincode: json['pincode'] as String?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      regionId: json['region_id'] as String?,
      areaId: json['area_id'] as String?,
      appPk: json['app_pk'] as String?,
      image: json['image'] as String?,
      bankAccountId: json['bank_account_id'] as String?,
      isApproved: json['isApproved'] as String?,
      openTime: json['open_time'] as String?,
      closeTime: json['close_time'] as String?,
      parentId: json['parent_id'] as String?,
      isAsync: json['is_async'] as String?,
      brands: json['brands'] as String?,
      isDelete: json['is_delete'] as String?,
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'business_name': businessName,
      'business_type': businessType,
      'gst_no': gstNo,
      'address': address,
      'pincode': pincode,
      'name': name,
      'mobile': mobile,
      'state': state,
      'city': city,
      'region_id': regionId,
      'area_id': areaId,
      'app_pk': appPk,
      'image': image,
      'bank_account_id': bankAccountId,
      'isApproved': isApproved,
      'open_time': openTime,
      'close_time': closeTime,
      'parent_id': parentId,
      'is_async': isAsync,
      'brands': brands,
      'is_delete': isDelete,
    };
  }

  // Factory constructor for creating an instance from a Map (used for SQLite)
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'],
      type: map['type'],
      businessName: map['business_name'],
      businessType: map['business_type'],
      gstNo: map['gst_no'],
      address: map['address'],
      pincode: map['pincode'],
      name: map['name'],
      mobile: map['mobile'],
      state: map['state'],
      city: map['city'],
      regionId: map['region_id'],
      areaId: map['area_id'],
      appPk: map['app_pk'],
      image: map['image'],
      bankAccountId: map['bank_account_id'],
      isApproved: map['isApproved'],
      openTime: map['open_time'],
      closeTime: map['close_time'],
      parentId: map['parent_id'],
      isAsync: map['is_async'],
      brands: map['brands'],
      isDelete: map['is_delete'],
    );
  }

  // Convert the object to a Map (used for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'business_name': businessName,
      'business_type': businessType,
      'gst_no': gstNo,
      'address': address,
      'pincode': pincode,
      'name': name,
      'mobile': mobile,
      'state': state,
      'city': city,
      'region_id': regionId,
      'area_id': areaId,
      'app_pk': appPk,
      'image': image,
      'bank_account_id': bankAccountId,
      'isApproved': isApproved,
      'open_time': openTime,
      'close_time': closeTime,
      'parent_id': parentId,
      'is_async': isAsync,
      'brands': brands,
      'is_delete': isDelete,
    };
  }
}
