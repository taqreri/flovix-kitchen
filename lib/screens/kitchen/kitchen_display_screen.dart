import 'package:flovix_kitchen/services/kitchen/kitchen_local_server.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_model.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_store.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class KitchenDisplayScreen extends StatefulWidget {
  const KitchenDisplayScreen({super.key});

  @override
  State<KitchenDisplayScreen> createState() => _KitchenDisplayScreenState();
}

class _KitchenDisplayScreenState extends State<KitchenDisplayScreen> {
  KitchenLocalServerService? _server;

  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    if (getIt.isRegistered<KitchenLocalServerService>()) {
      _server = getIt<KitchenLocalServerService>();
      _server!.refreshLanIp().then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final server = _server;

    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              server: server,
              onRefresh: () async {
                await server?.refreshLanIp();
                if (mounted) setState(() {});
              },
            ),
            Expanded(
              child: StreamBuilder<List<KitchenOrderTicket>>(
                stream: KitchenOrderStore.instance.stream,
                initialData: KitchenOrderStore.instance.orders,
                builder: (context, snapshot) {
                  final orders = snapshot.data ?? const [];
                  if (orders.isEmpty) {
                    return const Center(
                      child: Text(
                        'Waiting for orders from POS…',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 360,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final ticket = orders[index];
                      return _OrderCard(
                        ticket: ticket,
                        onBump: () {
                          final next = switch (ticket.status) {
                            'pending' => 'preparing',
                            'preparing' => 'ready',
                            'ready' => 'served',
                            _ => 'served',
                          };
                          KitchenOrderStore.instance
                              .markStatus(ticket.id, next);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.server, required this.onRefresh});

  final KitchenLocalServerService? server;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final running = server?.isRunning ?? false;
    final hasLan = server?.hasUsableLanIp ?? false;
    final url = server?.displayBaseUrl ?? 'http://<SET_LAN_IP>:18200';
    final candidates = server?.candidateIps ?? const <String>[];

    return Material(
      color: const Color(0xFF0B1220),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                 Icon(
                  Icons.restaurant_menu,
                  color: GlobalColors.primaryColor5BB0B0,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Kitchen Display',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: !running
                          ? const Color(0xFF7F1D1D)
                          : hasLan
                              ? const Color(0xFF064E3B)
                              : const Color(0xFF92400E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      !running
                          ? 'Server stopped'
                          : hasLan
                              ? 'Listening · $url'
                              : 'Listening · LAN IP not found — do NOT use 127.0.0.1 in POS',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (hasLan)
                  IconButton(
                    tooltip: 'Copy URL for POS',
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: url));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied $url')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy, color: Colors.white70),
                  ),
                IconButton(
                  tooltip: 'Refresh IP',
                  onPressed: () => onRefresh(),
                  icon: const Icon(Icons.refresh, color: Colors.white70),
                ),
                IconButton(
                  tooltip: 'Clear served',
                  onPressed: () => KitchenOrderStore.instance.clearCompleted(),
                  icon: const Icon(
                    Icons.cleaning_services_outlined,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            if (running && !hasLan && candidates.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Try these IPs in POS KDS Settings: ${candidates.map((ip) => 'http://$ip:${server?.port ?? 18200}').join('  ·  ')}',
                style: const TextStyle(color: Color(0xFFFBBF24), fontSize: 12),
              ),
            ],
            if (running && !hasLan && candidates.isEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Connect this device to Wi‑Fi/Ethernet, then tap Refresh. '
                'POS must use this device LAN IP — never 127.0.0.1.',
                style: TextStyle(color: Color(0xFFFBBF24), fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.ticket, required this.onBump});

  final KitchenOrderTicket ticket;
  final VoidCallback onBump;

  Color get _statusColor {
    return switch (ticket.status) {
      'preparing' => const Color(0xFFB45309),
      'ready' => const Color(0xFF047857),
      'served' => const Color(0xFF4B5563),
      _ => GlobalColors.primaryColor,
    };
  }

  String get _title {
    final parts = <String>[];
    final table = ticket.table?.trim() ?? '';
    if (table.isNotEmpty) {
      parts.add(table.toLowerCase().startsWith('t') ? table : 'Table $table');
    }
    final inv = ticket.invoiceNumber?.trim() ?? '';
    if (inv.isNotEmpty) parts.add('#$inv');
    return parts.isEmpty ? 'New order' : parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('HH:mm').format(ticket.receivedAt);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _statusColor, width: 2.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _statusColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if ((ticket.customerName ?? '').isNotEmpty ||
              (ticket.notes ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Text(
                [
                  if ((ticket.customerName ?? '').isNotEmpty)
                    ticket.customerName!,
                  if ((ticket.notes ?? '').isNotEmpty) ticket.notes!,
                ].join(' · '),
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: ticket.items.length,
              separatorBuilder: (_, _) => const Divider(height: 12),
              itemBuilder: (context, index) {
                final item = ticket.items[index];
                final qty = item.qty % 1 == 0
                    ? item.qty.toInt().toString()
                    : item.qty.toString();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$qty× ${item.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF111827),
                      ),
                    ),
                    if ((item.notes ?? '').isNotEmpty)
                      Text(
                        item.notes!,
                        style: const TextStyle(
                          color: Color(0xFFB45309),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (item.modifiers.isNotEmpty)
                      Text(
                        item.modifiers.join(', '),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _statusColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(42),
              ),
              onPressed: ticket.status == 'served' ? null : onBump,
              child: Text(
                switch (ticket.status) {
                  'pending' => 'Start preparing',
                  'preparing' => 'Mark ready',
                  'ready' => 'Mark served',
                  _ => 'Served',
                },
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
