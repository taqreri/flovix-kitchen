
class VariationChild {
  VariationChild({
      this.id, 
      this.varName, 
      this.varNameAr, 
      this.attributes,});

  VariationChild.fromJson(dynamic json) {
    id = json['id'];
    varName = json['var_name'];
    varNameAr = json['var_name_ar'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attributes.fromJson(v));
      });
    }
  }
  int? id;
  String? varName;
  String? varNameAr;
  List<Attributes>? attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['var_name'] = varName;
    map['var_name_ar'] = varNameAr;
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name_en : "red"
/// name_ar : "أحمر"

class Attributes {
  Attributes({
      this.id, 
      this.nameEn, 
      this.nameAr,});

  Attributes.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
  int? id;
  String? nameEn;
  String? nameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    return map;
  }

}