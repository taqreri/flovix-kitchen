

import 'DialCodeItem.dart';

class DialCodeModel {
  DialCodeModel({
      this.dialCodeList,
      this.selected,});

  DialCodeModel.fromJson(dynamic json) {
    if (json['dial_code_list'] != null) {
      dialCodeList = [];
      json['dial_code_list'].forEach((v) {
        dialCodeList?.add(DialCodeItem.fromJson(v));
      });
    }
selected = json['default'];
  }
  List<DialCodeItem>? dialCodeList;
  int? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dialCodeList != null) {
      map['dial_code_list'] = dialCodeList?.map((v) => v.toJson()).toList();
    }
    map['default'] = selected;
    return map;
  }

}