/// uom_id : 21
/// uom_name : "piece"
/// uom_name_ar : "كرتون"
/// uom_value : 1

class UomModel {
  UomModel({
      this.uomId, 
      this.uomName, 
      this.uomNameAr, 
      this.uomValue,});

  UomModel.fromJson(dynamic json) {
    uomId = json['uom_id'] is int
        ? json['uom_id']
        : int.tryParse('${json['uom_id'] ?? ''}');
    uomName = json['uom_name'];
    uomNameAr = json['uom_name_ar'];
    final rawValue = json['uom_value'];
    if (rawValue is int) {
      uomValue = rawValue;
    } else if (rawValue is double) {
      uomValue = rawValue.toInt();
    } else if (rawValue is String) {
      uomValue = int.tryParse(rawValue.trim()) ??
          double.tryParse(rawValue.trim())?.toInt();
    }
  }
  int? uomId;
  String? uomName;
  String? uomNameAr;
  int? uomValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uom_id'] = uomId;
    map['uom_name'] = uomName;
    map['uom_name_ar'] = uomNameAr;
    map['uom_value'] = uomValue;
    return map;
  }

}