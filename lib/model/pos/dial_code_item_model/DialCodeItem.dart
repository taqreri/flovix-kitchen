class DialCodeItem {
  DialCodeItem({
      this.id,
      this.iso,
      this.name,
      this.nicename,
      this.iso3,
      this.numcode,
      this.dialCode,
      this.countryNameAr,});

  DialCodeItem.fromJson(dynamic json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    dialCode = json['dial_code'];
    countryNameAr = json['country_name_ar'];
  }
  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  int? dialCode;
  String? countryNameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['iso'] = iso;
    map['name'] = name;
    map['nicename'] = nicename;
    map['iso3'] = iso3;
    map['numcode'] = numcode;
    map['dial_code'] = dialCode;
    map['country_name_ar'] = countryNameAr;
    return map;
  }

}