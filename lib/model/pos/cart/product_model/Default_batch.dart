class DefaultBatch {
  DefaultBatch({
      this.id, 
      this.name, 
      this.stock, 
      this.cost, 
      this.expiry,});

  DefaultBatch.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'] : int.tryParse('${json['id'] ?? ''}');
    stock = _parseStock(json['stock']);
  }
  int? id;
  String? name;
  int? stock;
  int? cost;
  String? expiry;

  static int? _parseStock(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value.trim());
    return null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['stock'] = stock;
    map['cost'] = cost;
    map['expiry'] = expiry;
    return map;
  }

}