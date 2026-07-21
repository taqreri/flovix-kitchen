/// id : 1
/// dine_in : 1
/// floor_name : "Main Hall"
/// floor_id : 1
/// table_id : 1
/// table_name : "Table 1"
/// dinners : 3
/// sale_person_id : 2
/// sale_person_name : "AK"
/// shipping_name : "N/A"
/// shipping_id : -1

class ShippingLocalModel {
  ShippingLocalModel({
    this.id,
    this.dineIn,
    this.floorName,
    this.floorId,
    this.tableId,
    this.tableName,
    this.dinners,
    this.salePersonId,
    this.salePersonName,
    this.deliveryManId,
    this.deliveyManName,
    this.shippingName,
    this.shippingId,});

  ShippingLocalModel.fromJson(dynamic json) {
    id = json['id'];
    dineIn = json['dine_in'];
    floorName = json['floor_name'];
    floorId = json['floor_id'];
    tableId = json['table_id'];
    tableName = json['table_name'];
    dinners = json['dinners'];
    salePersonId = json['sale_person_id'];
    salePersonName = json['sale_person_name'];
    deliveyManName = json['delivery_man_name'];
    shippingName = json['shipping_name'];
    shippingId = json['shipping_id'];
    deliveryManId = json['delivery_man_id'];
  }

  int? id;
  int? dineIn;
  String? floorName;
  int? floorId;
  int? tableId;
  String? tableName;
  int? deliveryManId;
  int? dinners;
  int? salePersonId;
  String? deliveyManName;
  String? salePersonName;
  String? shippingName;
  int? shippingId;

  factory ShippingLocalModel.fromMap(Map<String, dynamic> map) {
    return ShippingLocalModel(
      id: map['id'] ?? 0,
      dineIn: map['dine_in'],
      floorName: map['floor_name'],
      floorId: map['floor_id'],
      tableId: map['table_id'],
      tableName: map['table_name'],
      dinners: map['dinners'],
      deliveryManId: map['delivery_man_id'],
      salePersonId: map['sale_person_id'],
      salePersonName: map['sale_person_name'],
      deliveyManName: map['delivery_man_name'],
      shippingName: map['shipping_name'],
      shippingId: map['shipping_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['dine_in'] = dineIn;
    map['floor_name'] = floorName;
    map['floor_id'] = floorId;
    map['table_id'] = tableId;
    map['table_name'] = tableName;
    map['delivery_man_id'] = deliveryManId;
    map['dinners'] = dinners;
    map['sale_person_id'] = salePersonId;
    map['sale_person_name'] = salePersonName;
    map['delivery_man_name'] = deliveyManName;
    map['shipping_name'] = shippingName;
    map['shipping_id'] = shippingId;
    return map;
  }

}