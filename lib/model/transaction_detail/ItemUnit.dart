/// uom_value : 1
/// uom_name : "piece"

class ItemUnit {
  ItemUnit({
      this.uomValue,
    this.uomId,
      this.uomName,});

  ItemUnit.fromJson(dynamic json) {
    uomValue = json['uom_value'];
    uomName = json['uom_name'];
    uomId = json['uom_id'];
  }
  var uomValue;
  String? uomName;
  int? uomId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uom_id'] = uomId;
    map['uom_value'] = uomValue;
    map['uom_name'] = uomName;
    return map;
  }

}