import 'Taxes.dart';

/// taxes : [{"rate":"10","value":7.5465,"tax_id":1534}]
/// charge_id : 2

class ChargesTransactionDetailModel {
  ChargesTransactionDetailModel({
      this.taxes, 
      this.rate,
      this.value,
      this.chargeId,});

  ChargesTransactionDetailModel.fromJson(dynamic json) {
    if (json['taxes'] != null) {
      taxes = [];
      json['taxes'].forEach((v) {
        taxes?.add(Taxes.fromJson(v));
      });
    }
    chargeId = json['charge_id'];
    rate = json['rate']??"";
    value = json['value']??0.0;
  }
  List<Taxes>? taxes;
  int? chargeId;
  var rate;
  var value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (taxes != null) {
      map['taxes'] = taxes?.map((v) => v.toJson()).toList();
    }
    map['charge_id'] = chargeId;
    return map;
  }

}