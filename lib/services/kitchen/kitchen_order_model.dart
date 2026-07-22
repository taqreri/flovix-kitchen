class KitchenOrderItem {
  KitchenOrderItem({
    required this.name,
    required this.qty,
    this.notes,
    this.category,
    this.modifiers = const [],
  });

  final String name;
  final double qty;
  final String? notes;
  final String? category;
  final List<String> modifiers;

  factory KitchenOrderItem.fromJson(Map<String, dynamic> json) {
    final modifiersRaw = json['modifiers'];
    return KitchenOrderItem(
      name: '${json['name'] ?? ''}',
      qty: _toDouble(json['qty']) ?? 1,
      notes: json['notes']?.toString(),
      category: json['category']?.toString(),
      modifiers: modifiersRaw is List
          ? modifiersRaw.map((e) => '$e').where((e) => e.isNotEmpty).toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        if (notes != null) 'notes': notes,
        if (category != null) 'category': category,
        'modifiers': modifiers,
      };
}

class KitchenOrderTicket {
  KitchenOrderTicket({
    required this.id,
    required this.receivedAt,
    required this.raw,
    this.invoiceNumber,
    this.table,
    this.customerName,
    this.orderType,
    this.notes,
    this.items = const [],
    this.total,
    this.status = 'pending',
  });

  final String id;
  final DateTime receivedAt;
  final Map<String, dynamic> raw;
  final String? invoiceNumber;
  final String? table;
  final String? customerName;
  final String? orderType;
  final String? notes;
  final List<KitchenOrderItem> items;
  final double? total;
  String status;

  factory KitchenOrderTicket.fromPayload(Map<String, dynamic> payload) {
    final invoice = payload['invoice'] is Map
        ? Map<String, dynamic>.from(payload['invoice'] as Map)
        : <String, dynamic>{};
    final itemsRaw = payload['items'];
    final totals = payload['totals'] is Map
        ? Map<String, dynamic>.from(payload['totals'] as Map)
        : <String, dynamic>{};

    final localId = invoice['localId']?.toString();
    final serverId = invoice['serverId']?.toString();
    final number = invoice['number']?.toString();
    final id = [
      if (serverId != null && serverId.isNotEmpty) 's:$serverId',
      if (localId != null && localId.isNotEmpty) 'l:$localId',
      if (number != null && number.isNotEmpty) 'n:$number',
      't:${DateTime.now().millisecondsSinceEpoch}',
    ].join('|');

    final items = itemsRaw is List
        ? itemsRaw
            .whereType<Map>()
            .map((e) => KitchenOrderItem.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <KitchenOrderItem>[];

    return KitchenOrderTicket(
      id: id,
      receivedAt: DateTime.now(),
      raw: payload,
      invoiceNumber: number,
      table: invoice['table']?.toString(),
      customerName: invoice['customerName']?.toString(),
      orderType: invoice['orderType']?.toString(),
      notes: invoice['notes']?.toString(),
      items: items,
      total: _toDouble(totals['total']),
      status: 'pending',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'receivedAt': receivedAt.toIso8601String(),
        'invoiceNumber': invoiceNumber,
        'table': table,
        'customerName': customerName,
        'orderType': orderType,
        'notes': notes,
        'items': items.map((e) => e.toJson()).toList(),
        'total': total,
        'status': status,
        'raw': raw,
      };

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse('$value');
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse('$value');
}
