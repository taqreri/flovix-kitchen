/// rate : "10"
/// value : 7.5465
/// tax_id : 1534

class Taxes {
  Taxes({
      this.rate, 
      this.value, 
      this.taxId,});

  Taxes.fromJson(dynamic json) {
    rate = json['rate'];
    value = json['value'];
    taxId = json['tax_id'];
  }
  String? rate;
  double? value;
  int? taxId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['value'] = value;
    map['tax_id'] = taxId;
    return map;
  }

}