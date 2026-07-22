import 'dart:async';

import 'kitchen_order_model.dart';

/// In-memory kitchen ticket queue with a broadcast stream for the KDS UI.
class KitchenOrderStore {
  KitchenOrderStore._();

  static final KitchenOrderStore instance = KitchenOrderStore._();

  final List<KitchenOrderTicket> _orders = [];
  final StreamController<List<KitchenOrderTicket>> _controller =
      StreamController<List<KitchenOrderTicket>>.broadcast();

  List<KitchenOrderTicket> get orders => List.unmodifiable(_orders);

  Stream<List<KitchenOrderTicket>> get stream async* {
    yield orders;
    yield* _controller.stream;
  }

  KitchenOrderTicket enqueue(Map<String, dynamic> payload) {
    final ticket = KitchenOrderTicket.fromPayload(payload);
    // Prefer newer ticket with same local/server id.
    _orders.removeWhere((o) {
      final a = o.raw['invoice'];
      final b = ticket.raw['invoice'];
      if (a is! Map || b is! Map) return false;
      final aLocal = a['localId']?.toString();
      final bLocal = b['localId']?.toString();
      final aServer = a['serverId']?.toString();
      final bServer = b['serverId']?.toString();
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
    });
    _orders.insert(0, ticket);
    _emit();
    return ticket;
  }

  void markStatus(String id, String status) {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index < 0) return;
    _orders[index].status = status;
    _emit();
  }

  void clearCompleted() {
    _orders.removeWhere((o) => o.status == 'served' || o.status == 'done');
    _emit();
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
