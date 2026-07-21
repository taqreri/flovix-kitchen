import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BranchInfoModel {
  final int structId;
  final int parentStructId;
  final String structName;
  final String structNameAr;
  final String detail;
  final String detailAr;
  final String address;
  final String addressAr;
  final String logo;
  final String type;
  final String website;
  final String email;
  final String phoneNumber;
  final String fax;
  final String taxNumber;
  final String policeRegNum;
  final String tmaRegNum;
  final String companyRegNum;
  final String mobileNumber;
  final int countryId;
  final String timeZone;
  final int locationId;
  final int companyId;
  final int structStatus;
  final int costCenter;
  final String buildingNo;
  final String streetName;
  final String districtName;
  final String postCode;
  final String invNote;
  final int invNoteCheck;
  final String bankName;
  final String accountNumber;
  final String iban;
  final int branchShift;
  final int tag;

  BranchInfoModel({
    required this.structId,
    required this.parentStructId,
    required this.structName,
    required this.structNameAr,
    required this.detail,
    required this.detailAr,
    required this.address,
    required this.addressAr,
    required this.logo,
    required this.type,
    required this.website,
    required this.email,
    required this.phoneNumber,
    required this.fax,
    required this.taxNumber,
    required this.policeRegNum,
    required this.tmaRegNum,
    required this.companyRegNum,
    required this.mobileNumber,
    required this.countryId,
    required this.timeZone,
    required this.locationId,
    required this.companyId,
    required this.structStatus,
    required this.costCenter,
    required this.buildingNo,
    required this.streetName,
    required this.districtName,
    required this.postCode,
    required this.invNote,
    required this.invNoteCheck,
    required this.bankName,
    required this.accountNumber,
    required this.iban,
    required this.branchShift,
    required this.tag,
  });

  static String taxNumberFromJson(Map<String, dynamic> json) {
    const keys = [
      'tax_number',
      'taxNumber',
      'vat_number',
      'vat_no',
      'trn',
      'tax_registration_number',
      'commercial_tax_number',
      'branch_tax_number',
    ];
    for (final key in keys) {
      final value = json[key]?.toString().trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return '';
  }

  static String _firstNonEmptyKey(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key]?.toString().trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return '';
  }

  factory BranchInfoModel.fromJson(Map<String, dynamic> json) {
    return BranchInfoModel(
      structId: json['struct_id'] ?? 0,
      parentStructId: json['parent_struct_id'] ?? 0,
      structName: _firstNonEmptyKey(json, [
        'struct_name',
        'structName',
        'company_name',
        'branch_name',
        'name',
      ]),
      structNameAr: json['struct_name_ar'] ?? json['structNameAr'] ?? '',
      detail: _firstNonEmptyKey(json, ['detail', 'detail_en', 'description']),
      detailAr: json['detail_ar'] ?? '',
      address: _firstNonEmptyKey(json, [
        'address',
        'address_en',
        'street_address',
      ]),
      addressAr: json['address_ar'] ?? '',
      logo: json['logo'] ?? '',
      type: json['type'] ?? '',
      website: json['website'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: _firstNonEmptyKey(json, [
        'phone_number',
        'phone',
        'phoneNumber',
        'mobile_number',
        'mobile',
      ]),
      fax: json['fax'] ?? '',
      taxNumber: taxNumberFromJson(json),
      policeRegNum: json['police_reg_num'] ?? '',
      tmaRegNum: json['tma_reg_num'] ?? '',
      companyRegNum: json['company_reg_num'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      countryId: json['country_id'] ?? 0,
      timeZone: json['time_zone'] ?? '',
      locationId: json['location_id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      structStatus: json['struct_status'] ?? 0,
      costCenter: json['cost_center'] ?? 0,
      buildingNo: json['building_no'] ?? '',
      streetName: json['street_name'] ?? '',
      districtName: json['district_name'] ?? '',
      postCode: json['post_code'] ?? '',
      invNote: json['inv_note'] ?? '',
      invNoteCheck: json['inv_note_check'] ?? 0,
      bankName: json['bank_name'] ?? '',
      accountNumber: json['account_number'] ?? '',
      iban: json['iban'] ?? '',
      branchShift: json['branch_shift'] ?? 0,
      tag: json['tag'] ?? 0,
    );
  }

  Future<BranchInfoModel?> getBranchInformation() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('branchInformation');
    if (jsonString != null && jsonString.isNotEmpty) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return BranchInfoModel.fromJson(jsonMap);
    }
    return null;

}

}