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

enum KitchenOrderKind { dineIn, takeaway, pickup, delivery, other }

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

  KitchenOrderKind get orderKind => resolveOrderKind(orderType);

  /// Short badge: DI / TA / P / DL (or table code for dine-in).
  String get badgeCode {
    switch (orderKind) {
      case KitchenOrderKind.takeaway:
        return 'TA';
      case KitchenOrderKind.pickup:
        return 'P';
      case KitchenOrderKind.delivery:
        return 'DL';
      case KitchenOrderKind.dineIn:
      case KitchenOrderKind.other:
        final cleaned =
            (table ?? '').trim().replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
        if (cleaned.isNotEmpty) {
          return cleaned.length <= 3
              ? cleaned.toUpperCase()
              : cleaned.substring(0, 3).toUpperCase();
        }
        return orderKind == KitchenOrderKind.dineIn ? 'DI' : 'OT';
    }
  }

  /// Human label for UI (never raw snake_case).
  String get orderTypeLabel {
    final fromPayload = _payloadOrderTypeLabel;
    if (fromPayload != null && fromPayload.isNotEmpty) {
      final lower = fromPayload.toLowerCase();
      final looksCanonical = fromPayload.contains('_') ||
          lower == 'dine_in' ||
          lower == 'takeaway' ||
          lower == 'pickup' ||
          lower == 'delivery';
      if (!looksCanonical) return fromPayload;
    }

    switch (orderKind) {
      case KitchenOrderKind.takeaway:
        return 'Takeaway';
      case KitchenOrderKind.pickup:
        return 'Pickup';
      case KitchenOrderKind.delivery:
        return 'Delivery';
      case KitchenOrderKind.dineIn:
        return 'Dine In';
      case KitchenOrderKind.other:
        final rawType = (orderType ?? '').trim();
        if (rawType.isEmpty) return 'Dine In';
        return rawType
            .replaceAll('_', ' ')
            .split(RegExp(r'\s+'))
            .where((w) => w.isNotEmpty)
            .map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
            .join(' ');
    }
  }

  String? get _payloadOrderTypeLabel {
    final invoice = raw['invoice'];
    if (invoice is! Map) return null;
    for (final key in [
      'orderTypeLabel',
      'order_type_label',
      'orderTypeName',
      'order_type_name',
    ]) {
      final text = invoice[key]?.toString().trim() ?? '';
      if (text.isNotEmpty && text.toLowerCase() != 'null') return text;
    }
    return null;
  }

  bool get isTakeaway => orderKind == KitchenOrderKind.takeaway;
  bool get isDineIn => orderKind == KitchenOrderKind.dineIn;

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

    final orderType = _readOrderType(invoice, payload);

    return KitchenOrderTicket(
      id: id,
      receivedAt: DateTime.now(),
      raw: payload,
      invoiceNumber: number,
      table: _readTable(invoice, payload),
      customerName: (invoice['customerName'] ??
              invoice['customer_name'] ??
              payload['customerName'] ??
              payload['customer_name'])
          ?.toString(),
      orderType: orderType,
      notes: (invoice['notes'] ?? payload['notes'])?.toString(),
      items: items,
      total: _toDouble(totals['total']),
      status: 'pending',
    );
  }

  /// POS may send camelCase, snake_case, numeric ids, or dine_in flags.
  static String? _readOrderType(
    Map<String, dynamic> invoice,
    Map<String, dynamic> payload,
  ) {
    // Prefer human-readable names over ids / defaults like "dine_in".
    final namedCandidates = <dynamic>[
      invoice['orderTypeName'],
      invoice['order_type_name'],
      invoice['orderTypeLabel'],
      invoice['order_type_label'],
      payload['orderTypeName'],
      payload['order_type_name'],
    ];
    final idCandidates = <dynamic>[
      invoice['orderType'],
      invoice['order_type'],
      invoice['type'],
      invoice['saleType'],
      invoice['sale_type'],
      invoice['orderMode'],
      invoice['order_mode'],
      payload['orderType'],
      payload['order_type'],
      payload['type'],
      payload['saleType'],
      payload['sale_type'],
    ];

    String? firstNonEmpty(List<dynamic> candidates) {
      for (final candidate in candidates) {
        if (candidate == null) continue;
        final value = candidate.toString().trim();
        if (value.isEmpty || value.toLowerCase() == 'null') continue;
        return value;
      }
      return null;
    }

    final named = firstNonEmpty(namedCandidates);
    if (named != null) return named;

    final idOrType = firstNonEmpty(idCandidates);
    if (idOrType != null) return idOrType;

    final dineIn = invoice['dine_in'] ??
        invoice['dineIn'] ??
        invoice['is_dine_in'] ??
        invoice['isDineIn'] ??
        payload['dine_in'] ??
        payload['dineIn'];

    if (dineIn != null) {
      final normalized = dineIn.toString().toLowerCase().trim();
      if (normalized == '0' ||
          normalized == 'false' ||
          normalized == 'no' ||
          normalized == 'takeaway' ||
          normalized == 'take_away') {
        return 'takeaway';
      }
      if (normalized == '1' ||
          normalized == 'true' ||
          normalized == 'yes' ||
          normalized == 'dine_in' ||
          normalized == 'dinein') {
        return 'dine_in';
      }
    }

    return null;
  }

  static String? _readTable(
    Map<String, dynamic> invoice,
    Map<String, dynamic> payload,
  ) {
    final candidates = <dynamic>[
      invoice['table'],
      invoice['tableName'],
      invoice['table_name'],
      invoice['tableNo'],
      invoice['table_no'],
      invoice['tableNumber'],
      invoice['table_number'],
      payload['table'],
      payload['tableName'],
      payload['table_name'],
    ];
    for (final candidate in candidates) {
      if (candidate == null) continue;
      final value = candidate.toString().trim();
      if (value.isEmpty || value.toLowerCase() == 'null') continue;
      return value;
    }
    return null;
  }

  static KitchenOrderKind resolveOrderKind(String? raw) {
    final t = (raw ?? '')
        .toLowerCase()
        .trim()
        .replaceAll('-', '_')
        .replaceAll(' ', '_');

    if (t.isEmpty) return KitchenOrderKind.dineIn;

    // Numeric ids commonly used by POS order-type APIs.
    if (t == '2' || t == '02') return KitchenOrderKind.takeaway;
    if (t == '3' || t == '03') return KitchenOrderKind.pickup;
    if (t == '4' || t == '04') return KitchenOrderKind.delivery;
    if (t == '1' || t == '01') return KitchenOrderKind.dineIn;

    // Takeaway / TA — check before loose "di" matching.
    if (t == 'ta' ||
        t == 'takeaway' ||
        t == 'take_away' ||
        t == 'takeaway_order' ||
        t.contains('take_away') ||
        t.contains('takeaway') ||
        t.startsWith('take')) {
      return KitchenOrderKind.takeaway;
    }

    if (t == 'p' ||
        t == 'pickup' ||
        t == 'pick_up' ||
        t.contains('pickup') ||
        t.contains('pick_up')) {
      return KitchenOrderKind.pickup;
    }

    if (t == 'dl' ||
        t == 'delivery' ||
        t.contains('deliver') ||
        t.contains('delivery')) {
      return KitchenOrderKind.delivery;
    }

    if (t == 'di' ||
        t == 'dine' ||
        t == 'dine_in' ||
        t == 'dinein' ||
        t.contains('dine_in') ||
        t.contains('dinein') ||
        t.contains('dine')) {
      return KitchenOrderKind.dineIn;
    }

    return KitchenOrderKind.other;
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
