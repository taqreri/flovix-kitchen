import 'dart:async';

import 'package:flutter/foundation.dart';

import 'kitchen_order_database.dart';
import 'kitchen_order_model.dart';

/// Kitchen ticket queue: persist to local DB first, then update in-memory UI.
class KitchenOrderStore {
  KitchenOrderStore._();

  static final KitchenOrderStore instance = KitchenOrderStore._();

  final List<KitchenOrderTicket> _orders = [];
  final StreamController<List<KitchenOrderTicket>> _controller =
      StreamController<List<KitchenOrderTicket>>.broadcast();

  bool _loaded = false;

  List<KitchenOrderTicket> get orders => List.unmodifiable(_orders);
  bool get isLoaded => _loaded;

  Stream<List<KitchenOrderTicket>> get stream async* {
    yield orders;
    yield* _controller.stream;
  }

  /// Load persisted tickets before the UI / LAN server accept new ones.
  Future<void> loadFromDisk() async {
    try {
      final saved = await KitchenOrderDatabase.instance.loadAll();
      _orders
        ..clear()
        ..addAll(saved);
      _loaded = true;
      _emit();
      debugPrint('[KitchenOrderStore] loaded ${saved.length} orders from DB');
    } catch (e, st) {
      _loaded = true;
      debugPrint('[KitchenOrderStore] loadFromDisk failed: $e');
      debugPrint('$st');
      _emit();
    }
  }

  /// Save to local DB, then append/replace in memory and notify UI.
  Future<KitchenOrderTicket> enqueue(Map<String, dynamic> payload) async {
    final ticket = KitchenOrderTicket.fromPayload(payload);
    debugPrint(
      '[KitchenOrder] orderType=${ticket.orderType} '
      'kind=${ticket.orderKind.name} label=${ticket.orderTypeLabel}',
    );

    // Drop older in-memory duplicates with same local/server invoice id.
    final removedIds = <String>[];
    _orders.removeWhere((o) {
      final same = _isSameInvoice(o, ticket);
      if (same) removedIds.add(o.id);
      return same;
    });
    if (removedIds.isNotEmpty) {
      await KitchenOrderDatabase.instance.deleteByIds(removedIds);
    }

    // Persist first — only then show on kitchen display.
    await KitchenOrderDatabase.instance.upsert(ticket);

    _orders.insert(0, ticket);
    _emit();
    return ticket;
  }

  Future<void> markStatus(String id, String status) async {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index < 0) return;
    _orders[index].status = status;
    await KitchenOrderDatabase.instance.updateStatus(id, status);
    _emit();
  }

  Future<void> startOrder(String id) => markStatus(id, 'preparing');

  Future<void> completeOrder(String id) => markStatus(id, 'ready');

  Future<void> cancelOrder(String id) => markStatus(id, 'cancelled');

  Future<void> holdOrder(String id) => markStatus(id, 'pending');

  Future<void> clearCompleted() async {
    final toRemove = _orders
        .where(
          (o) =>
              o.status == 'served' ||
              o.status == 'done' ||
              o.status == 'ready' ||
              o.status == 'cancelled',
        )
        .map((o) => o.id)
        .toList();
    if (toRemove.isEmpty) return;

    await KitchenOrderDatabase.instance.deleteByIds(toRemove);
    _orders.removeWhere((o) => toRemove.contains(o.id));
    _emit();
  }

  /// Clear all in-memory and persisted kitchen tickets (logout).
  Future<void> clearAll() async {
    await KitchenOrderDatabase.instance.clearAll();
    _orders.clear();
    _emit();
  }

  bool _isSameInvoice(KitchenOrderTicket a, KitchenOrderTicket b) {
    final aInv = a.raw['invoice'];
    final bInv = b.raw['invoice'];
    if (aInv is! Map || bInv is! Map) return false;
    final aLocal = aInv['localId']?.toString();
    final bLocal = bInv['localId']?.toString();
    final aServer = aInv['serverId']?.toString();
    final bServer = bInv['serverId']?.toString();
    if (aLocal != null &&
        aLocal.isNotEmpty &&
        bLocal != null &&
        bLocal.isNotEmpty &&
        aLocal == bLocal) {
      return true;
    }
    if (aServer != null &&
        aServer.isNotEmpty &&
        bServer != null &&
        bServer.isNotEmpty &&
        aServer == bServer) {
      return true;
    }
    return false;
  }

  void _emit() {
    if (!_controller.isClosed) {
      _controller.add(orders);
    }
  }

  void dispose() {
    _controller.close();
  }
}
