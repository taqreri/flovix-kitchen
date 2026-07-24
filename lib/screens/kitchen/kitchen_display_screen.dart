import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_local_server.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_model.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_store.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/app_utils.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/helper/divider.dart';
import 'package:flovix_kitchen/utils/helper/helpers.dart';
import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flovix_kitchen/widgets/kitchen_order_notes_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

enum _KdsFilter { all, newOrders, processing, completed, cancelled }

enum _KdsViewMode { grid, list }

class KitchenDisplayScreen extends StatefulWidget {
  const KitchenDisplayScreen({super.key});

  @override
  State<KitchenDisplayScreen> createState() => _KitchenDisplayScreenState();
}

class _KitchenDisplayScreenState extends State<KitchenDisplayScreen> {
  KitchenLocalServerService? _server;
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  _KdsFilter _filter = _KdsFilter.all;
  _KdsViewMode _viewMode = _KdsViewMode.grid;
  DateTime _now = DateTime.now();
  Timer? _clockTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

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
    _clockTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
    // Wi‑Fi may come online after cold start — refresh advertised IP.
    _connectivitySub = Connectivity().onConnectivityChanged.listen((_) async {
      await _server?.refreshLanIp();
      if (mounted) setState(() {});
    });
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _connectivitySub?.cancel();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  List<KitchenOrderTicket> _applyFilters(List<KitchenOrderTicket> orders) {
    final query = _searchController.text.trim().toLowerCase();
    return orders.where((ticket) {
      final status = KdsStatus.fromTicket(ticket);
      final matchesFilter = switch (_filter) {
        _KdsFilter.all => true,
        _KdsFilter.newOrders => status == KdsStatus.newOrder,
        _KdsFilter.processing => status == KdsStatus.processing,
        _KdsFilter.completed => status == KdsStatus.completed,
        _KdsFilter.cancelled => status == KdsStatus.cancelled,
      };
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;

      final haystack = [
        ticket.invoiceNumber,
        ticket.table,
        ticket.customerName,
        ticket.orderType,
        ticket.notes,
        ...ticket.items.map((e) => e.name),
      ].whereType<String>().join(' ').toLowerCase();
      return haystack.contains(query);
    }).toList();
  }

  Map<_KdsFilter, int> _counts(List<KitchenOrderTicket> orders) {
    var neu = 0, processing = 0, completed = 0, cancelled = 0;
    for (final ticket in orders) {
      switch (KdsStatus.fromTicket(ticket)) {
        case KdsStatus.newOrder:
          neu++;
        case KdsStatus.processing:
          processing++;
        case KdsStatus.completed:
          completed++;
        case KdsStatus.cancelled:
          cancelled++;
      }
    }
    return {
      _KdsFilter.all: orders.length,
      _KdsFilter.newOrders: neu,
      _KdsFilter.processing: processing,
      _KdsFilter.completed: completed,
      _KdsFilter.cancelled: cancelled,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.kdsPageBg,
      body: SafeArea(
        child: Column(
          children: [
            _KdsHeader(
              now: _now,
              searchController: _searchController,
              searchFocus: _searchFocus,
              server: _server,
              onRefreshIp: () async {
                await _server?.refreshLanIp();
                if (mounted) setState(() {});
                return _server?.displayBaseUrl;
              },
            ),
            Expanded(
              child: StreamBuilder<List<KitchenOrderTicket>>(
                stream: KitchenOrderStore.instance.stream,
                initialData: KitchenOrderStore.instance.orders,
                builder: (context, snapshot) {
                  final allOrders = snapshot.data ?? const [];
                  final counts = _counts(allOrders);
                  final filtered = _applyFilters(allOrders);

                  return Column(
                    children: [
                      _KdsFilterBar(
                        filter: _filter,
                        viewMode: _viewMode,
                        counts: counts,
                        onFilterChanged: (value) =>
                            setState(() => _filter = value),
                        onViewModeChanged: (value) =>
                            setState(() => _viewMode = value),
                      ),
                      Expanded(
                        child: filtered.isEmpty
                            ? _EmptyOrders(
                                hasAny: allOrders.isNotEmpty,
                                server: _server,
                              )
                            : _viewMode == _KdsViewMode.grid
                            ? _OrdersGrid(orders: filtered)
                            : _OrdersList(orders: filtered),
                      ),
                    ],
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

enum KdsStatus {
  newOrder,
  processing,
  completed,
  cancelled;

  static KdsStatus fromTicket(KitchenOrderTicket ticket) {
    return fromStatus(ticket.status);
  }

  Color get accent => switch (this) {
    KdsStatus.newOrder => GlobalColors.kdsNew,
    KdsStatus.processing => GlobalColors.kdsProcessing,
    KdsStatus.completed => GlobalColors.kdsCompleted,
    KdsStatus.cancelled => GlobalColors.kdsCancelled,
  };

  Color get softBg => switch (this) {
    KdsStatus.newOrder => GlobalColors.kdsNewBg,
    KdsStatus.processing => GlobalColors.kdsProcessingBg,
    KdsStatus.completed => GlobalColors.kdsCompletedBg,
    KdsStatus.cancelled => GlobalColors.kdsCancelledBg,
  };

  String get label => switch (this) {
    KdsStatus.newOrder => 'New Order',
    KdsStatus.processing => 'In Progress',
    KdsStatus.completed => 'Completed',
    KdsStatus.cancelled => 'Cancelled',
  };

  String get subLabel => switch (this) {
    KdsStatus.newOrder => 'New Order Waiting',
    KdsStatus.processing => 'Cooking Now',
    KdsStatus.completed => 'Ready to Serve',
    KdsStatus.cancelled => 'Order Cancelled',
  };

  IconData get icon => switch (this) {
    KdsStatus.newOrder => Icons.circle,
    KdsStatus.processing => Icons.schedule,
    KdsStatus.completed => Icons.check_circle,
    KdsStatus.cancelled => Icons.cancel,
  };

  /// Asset path for status badge icons (new / processing / completed / cancelled).
  String get assetIcon => switch (this) {
        KdsStatus.newOrder => AppImages.newIcon,
        KdsStatus.processing => AppImages.in_progress,
        KdsStatus.completed => AppImages.completed,
        KdsStatus.cancelled => AppImages.cancelled,
      };
  Color get textColor => switch (this) {
    KdsStatus.newOrder => Colors.white,
    KdsStatus.processing => Colors.black,
    KdsStatus.completed => Colors.white,
    KdsStatus.cancelled => Colors.white,
  };
  /// Convenience: resolve status from ticket raw status string.
  static KdsStatus fromStatus(String? status) {
    return switch ((status ?? '').toLowerCase().trim()) {
      'preparing' || 'hold' || 'processing' || 'in_progress' || 'in progress' =>
        KdsStatus.processing,
      'ready' || 'served' || 'done' || 'completed' || 'complete' =>
        KdsStatus.completed,
      'cancelled' || 'canceled' || 'cancel' => KdsStatus.cancelled,
      'pending' || 'new' || 'new_order' || 'new order' => KdsStatus.newOrder,
      _ => KdsStatus.newOrder,
    };
  }
}

class _KdsHeader extends StatelessWidget {
  const _KdsHeader({
    required this.now,
    required this.searchController,
    required this.searchFocus,
    required this.server,
    required this.onRefreshIp,
  });

  final DateTime now;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final KitchenLocalServerService? server;
  final Future<String?> Function() onRefreshIp;

  @override
  Widget build(BuildContext context) {
    final name = SessionController.employeeName;
    final timeLabel = DateFormat('d MMM, h:mm a').format(now);
    final running = server?.isRunning ?? false;
    final lanIp = server?.lanIp;
    final hasLanIp = lanIp != null && lanIp.isNotEmpty;
    final isLoopback = lanIp == '127.0.0.1' || (lanIp?.startsWith('127.') ?? false);
    final url = server?.displayBaseUrl ?? 'http://127.0.0.1:18200';

    return Container(
      color: GlobalColors.whiteColor,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, 0.018),
        vertical: SizeConfig.height(context, 0.014),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'KDS',
                style: TextStyle(
                  color: GlobalColors.kdsColor,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel26),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.02),
              Container(
                height: SizeConfig.height(context, 0.06),
                width: SizeConfig.width(context, 0.4),
                decoration: BoxDecoration(
                  // color: Color(0xFFF1F5F9),
                  color: GlobalColors.kdsPageBg,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width(context, 0.02),
                  ),
                  border: Border.all(color: GlobalColors.fieldBorder),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context, 0.012),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: GlobalColors.searchIcon,
                      size: SizeConfig.width(context, 0.02),
                    ),
                    buildHorizontalDivider(context: context, fraction: 0.008),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocus,
                        decoration: InputDecoration(
                          hintText: 'Search...',

                          hintStyle: TextStyle(
                            color: GlobalColors.searchIcon,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel16,
                            ),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: TextStyle(
                          color: GlobalColors.textColor,
                          fontSize: SizeConfig.width(
                            context,
                            GlobalColors.pixel16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),

              Container(
                height: SizeConfig.height(context, 0.06),
                padding: EdgeInsets.all(SizeConfig.width(context, 0.008)),
                decoration: BoxDecoration(
                  color: GlobalColors.kdsPageBg,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.mic_outlined,
                  color: GlobalColors.searchIcon,
                  size: SizeConfig.width(context, 0.02),
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),
            ],
          ),
          Row(
            children: [
            /*  Container(
                height: SizeConfig.height(context, 0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context, 0.01),
                  vertical: SizeConfig.height(context, 0.01),
                ),
                decoration: BoxDecoration(
                  color: GlobalColors.kdsPageBg,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width(context, 0.02),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: SizeConfig.width(context, 0.014),
                      color: GlobalColors.searchIcon,
                    ),
                    buildHorizontalDivider(context: context, fraction: 0.006),
                    Text(
                      timeLabel,
                      style: TextStyle(
                        color: GlobalColors.textTimeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),*/
              _ServerIpChip(
                running: running,
                hasLanIp: hasLanIp,
                isLoopback: isLoopback,
                url: hasLanIp ? url : 'Detecting IP…',
                onPressed: () async {
                  final refreshed = await onRefreshIp();
                  final copyUrl = refreshed ?? server?.displayBaseUrl;
                  if (!context.mounted) return;
                  if (running && copyUrl != null && copyUrl.isNotEmpty) {
                    await Clipboard.setData(ClipboardData(text: copyUrl));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied $copyUrl')),
                      );
                    }
                  }
                },
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),
              IconButton(
                tooltip: running
                    ? (hasLanIp
                          ? 'Server: ${server?.displayBaseUrl}'
                          : 'Server running — detecting LAN IP…')
                    : 'Server stopped',
                onPressed: () async {
                  await onRefreshIp();
                },
                icon: Badge(
                  isLabelVisible: running,
                  smallSize: 8,
                  backgroundColor: GlobalColors.kdsCancelled,
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: GlobalColors.bodyColor,
                    size: SizeConfig.width(context, 0.02),
                  ),
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),
              Container(
                height: SizeConfig.height(context, 0.06),
                width: SizeConfig.width(context, 0.0005),
                color: GlobalColors.searchIcon,
              ),
              buildHorizontalDivider(context: context, fraction: 0.01),
              CircleAvatar(
                radius: SizeConfig.width(context, 0.016),
                backgroundColor: GlobalColors.primaryColor.withValues(
                  alpha: 0.15,
                ),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: TextStyle(
                    color: GlobalColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel14),
                  ),
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.008),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: GlobalColors.usernameColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.width(context, GlobalColors.pixel16),
                    ),
                  ),
                  Text(
                    'MANAGER',
                    style: TextStyle(
                      color: GlobalColors.kdsMuted,
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.width(context, GlobalColors.pixel10),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServerIpChip extends StatelessWidget {
  const _ServerIpChip({
    required this.running,
    required this.hasLanIp,
    required this.isLoopback,
    required this.url,
    required this.onPressed,
  });

  final bool running;
  final bool hasLanIp;
  final bool isLoopback;
  final String url;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GlobalColors.kdsPageBg,
      borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02)),
        child: Container(
          height: SizeConfig.height(context, 0.06),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context, 0.012),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                running ? Icons.dns_rounded : Icons.cloud_off_outlined,
                size: SizeConfig.width(context, 0.014),
                color: hasLanIp && !isLoopback
                    ? GlobalColors.kdsCancelled
                    : GlobalColors.searchIcon,
              ),
              buildHorizontalDivider(context: context, fraction: 0.006),
              Text(
                running ? url : 'Server stopped',
                style: TextStyle(
                  color: GlobalColors.textTimeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel12),
                ),
              ),
              if (hasLanIp) ...[
                buildHorizontalDivider(context: context, fraction: 0.006),
                Icon(
                  Icons.copy_rounded,
                  size: SizeConfig.width(context, 0.012),
                  color: GlobalColors.searchIcon,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _KdsFilterBar extends StatelessWidget {
  const _KdsFilterBar({
    required this.filter,
    required this.viewMode,
    required this.counts,
    required this.onFilterChanged,
    required this.onViewModeChanged,
  });

  final _KdsFilter filter;
  final _KdsViewMode viewMode;
  final Map<_KdsFilter, int> counts;
  final ValueChanged<_KdsFilter> onFilterChanged;
  final ValueChanged<_KdsViewMode> onViewModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.width(context, 0.018),
          SizeConfig.height(context, 0.016),
          SizeConfig.width(context, 0.018),
          SizeConfig.height(context, 0.016),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //height: SizeConfig.height(context, 0.1),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context, 0.01),
                vertical: SizeConfig.height(context, 0.015),
              ),
              decoration: BoxDecoration(
                borderRadius: AppUtils.borderRadius(
                  context: context,
                  radius: 0.01,
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: filter == _KdsFilter.all,
                      selectedColor: GlobalColors.kdsColor.withOpacity(0.1),
                      selectedTextColor: GlobalColors.kdsColor,
                      onTap: () => onFilterChanged(_KdsFilter.all),
                    ),
                    _FilterChip(
                      label:
                          'New Orders (${counts[_KdsFilter.newOrders] ?? 0})',
                      selected: filter == _KdsFilter.newOrders,
                      softColor: GlobalColors.kdsNewBg,
                      accent: GlobalColors.kdsNew,
                      onTap: () => onFilterChanged(_KdsFilter.newOrders),
                    ),
                    _FilterChip(
                      label:
                          'Processing (${counts[_KdsFilter.processing] ?? 0})',
                      selected: filter == _KdsFilter.processing,
                      softColor: GlobalColors.kdsProcessingBg.withOpacity(0.1),
                      accent: GlobalColors.kdsProcessing,
                      onTap: () => onFilterChanged(_KdsFilter.processing),
                    ),
                    _FilterChip(
                      label: 'Completed (${counts[_KdsFilter.completed] ?? 0})',
                      selected: filter == _KdsFilter.completed,
                      softColor: GlobalColors.kdsCompletedBg.withOpacity(0.1),
                      accent: GlobalColors.kdsCompleted,
                      onTap: () => onFilterChanged(_KdsFilter.completed),
                    ),
                    _FilterChip(
                      label: 'Cancelled (${counts[_KdsFilter.cancelled] ?? 0})',
                      selected: filter == _KdsFilter.cancelled,
                      softColor: GlobalColors.kdsCancelledBg.withOpacity(0.1),
                      accent: GlobalColors.kdsCancelled,
                      onTap: () => onFilterChanged(_KdsFilter.cancelled),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: AppUtils.borderRadius(
                    context: context,
                    radius: 0.01,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context, 0.01),
                  vertical: SizeConfig.height(context, 0.015),
                ),
                child: _ViewToggle(mode: viewMode, onChanged: onViewModeChanged)),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.selectedTextColor,
    this.softColor,
    this.accent,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? softColor;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? (selectedColor ?? softColor ?? GlobalColors.primaryColor)
        : (softColor ?? GlobalColors.whiteColor);
    final fg = selected
        ? (selectedTextColor ?? accent ?? GlobalColors.whiteColor)
        : (accent ?? GlobalColors.bodyColor);

    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.width(context, 0.008)),
      child: Material(
        color: bg,
        borderRadius: AppUtils.borderRadius(context: context, radius: 0.01),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context, 0.01),
              vertical: SizeConfig.height(context, 0.015),
            ),
            decoration: BoxDecoration(
              // borderRadius:
              //     BorderRadius.circular(SizeConfig.width(context, 0.008)),
              /*      border: Border.all(
                color: selected
                    ? Colors.transparent
                    : (accent?.withValues(alpha: 0.25) ??
                        GlobalColors.fieldBorder),
              ),*/
            ),
            child: Text(
              label,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.width(context, GlobalColors.pixel12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.mode, required this.onChanged});

  final _KdsViewMode mode;
  final ValueChanged<_KdsViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.height(context,0.05 );
    return Row(
      children: [
        _ViewIconButton(
          size: size,
          icon: AppImages.rowImage,
          selected: mode == _KdsViewMode.list,
          onTap: () => onChanged(_KdsViewMode.list),
        ),
        buildHorizontalDivider(context: context, fraction: 0.006),
        _ViewIconButton(
          size: size,
          icon: AppImages.columnImage,
          selected: mode == _KdsViewMode.grid,
          onTap: () => onChanged(_KdsViewMode.grid),
        ),
      ],
    );
  }
}

class _ViewIconButton extends StatelessWidget {
  const _ViewIconButton({
    required this.size,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final double size;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
      child: Container(
       // width: size,
      //  height: SizeConfig.height(context, 0.01),
        decoration: BoxDecoration(
          color: GlobalColors.whiteColor,
          //borderRadius: BorderRadius.circular(8),
  /*        border: Border.all(
            color: selected
                ? GlobalColors.primaryColor
                : GlobalColors.fieldBorder,
            width: selected ? 1.6 : 1,
          ),*/
        ),
        child: Image.asset(   icon,scale: 3,),
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders({required this.hasAny, required this.server});

  final bool hasAny;
  final KitchenLocalServerService? server;

  @override
  Widget build(BuildContext context) {
    final url = server?.displayBaseUrl;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width(context, 0.04)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant_menu_rounded,
              size: SizeConfig.width(context, 0.05),
              color: GlobalColors.kdsMuted,
            ),
            buildVerticalDivider(context: context, fraction: 0.016),
            Text(
              hasAny
                  ? 'No orders in this filter'
                  : 'Waiting for orders from POS…',
              style: TextStyle(
                color: GlobalColors.textColor,
                fontSize: SizeConfig.width(context, GlobalColors.pixel18),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (!hasAny && url != null) ...[
              buildVerticalDivider(context: context, fraction: 0.01),
              Text(
                url,
                style: TextStyle(
                  color: GlobalColors.bodyColor,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel12),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OrdersGrid extends StatelessWidget {
  const _OrdersGrid({required this.orders});

  final List<KitchenOrderTicket> orders;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        SizeConfig.width(context, 0.018),
        SizeConfig.height(context, 0.004),
        SizeConfig.width(context, 0.018),
        SizeConfig.height(context, 0.02),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       // maxCrossAxisExtent: SizeConfig.width(context, 0.31).clamp(280.0, 360.0),
        mainAxisSpacing: SizeConfig.height(context, 0.016),
        crossAxisSpacing: SizeConfig.width(context, 0.012),
        childAspectRatio: 1, crossAxisCount:3,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) => _OrderCard(ticket: orders[index]),
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.orders});

  final List<KitchenOrderTicket> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        SizeConfig.width(context, 0.018),
        SizeConfig.height(context, 0.004),
        SizeConfig.width(context, 0.018),
        SizeConfig.height(context, 0.02),
      ),
      itemCount: orders.length,
      separatorBuilder: (_, _) =>
          buildVerticalDivider(context: context, fraction: 0.012),
      itemBuilder: (context, index) => _OrderListRow(ticket: orders[index]),
    );
  }
}

/// Column-wise list card: Identity | Time/Status | Items | Actions
class _OrderListRow extends StatefulWidget {
  const _OrderListRow({required this.ticket});

  final KitchenOrderTicket ticket;

  @override
  State<_OrderListRow> createState() => _OrderListRowState();
}

class _OrderListRowState extends State<_OrderListRow> {
  late Set<int> _checked;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _checked = _initialChecked(widget.ticket);
  }

  @override
  void didUpdateWidget(covariant _OrderListRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.ticket.id != widget.ticket.id ||
        oldWidget.ticket.status != widget.ticket.status) {
      _checked = _initialChecked(widget.ticket);
      _expanded = false;
    }
  }

  Set<int> _initialChecked(KitchenOrderTicket ticket) {
    final status = KdsStatus.fromTicket(ticket);
    return {
      if (status == KdsStatus.completed)
        for (var i = 0; i < ticket.items.length; i++) i,
    };
  }

  String get _badgeLabel => widget.ticket.badgeCode;

  String get _orderTypeLabel => widget.ticket.orderTypeLabel;

  String get _elapsedLabel {
    final diff = DateTime.now().difference(widget.ticket.receivedAt);
    final m = diff.inMinutes.clamp(0, 99);
    final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return '${m.toString().padLeft(2, '0')}:$s ago';
  }

  bool get _isDelayed {
    final status = KdsStatus.fromTicket(widget.ticket);
    if (status == KdsStatus.completed || status == KdsStatus.cancelled) {
      return false;
    }
    return DateTime.now().difference(widget.ticket.receivedAt).inMinutes >= 25;
  }

  String get _estimateLabel {
    if (_isDelayed) {
      final over =
          DateTime.now().difference(widget.ticket.receivedAt).inMinutes - 20;
      final mm = over.abs().toString().padLeft(2, '0');
      return 'Delayed: -$mm:00 min';
    }
    return 'Est: 30 min';
  }

  @override
  Widget build(BuildContext context) {
    final status = KdsStatus.fromTicket(widget.ticket);
    final inv = widget.ticket.invoiceNumber?.trim();
    final orderTitle = inv == null || inv.isEmpty ? 'Order' : 'Order #$inv';
    final maxVisible = _expanded ? widget.ticket.items.length : 3;
    final visibleItems = widget.ticket.items.take(maxVisible).toList();
    final moreCount = widget.ticket.items.length - 3;
    final dividerColor = GlobalColors.fieldBorder;

    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.whiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
        boxShadow: const [
          BoxShadow(
            color: GlobalColors.kdsCardShadow,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, 0.012),
        vertical: SizeConfig.height(context, 0.014),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Column 1 — identity
            SizedBox(
              width: SizeConfig.width(context, 0.16).clamp(150.0, 210.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.width(context, 0.03).clamp(34.0, 42.0),
                    height: SizeConfig.width(context, 0.03).clamp(34.0, 42.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: status.accent,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.006),
                      ),
                    ),
                    child: Text(
                      _badgeLabel,
                      style: TextStyle(
                        color: GlobalColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel12,
                        ),
                      ),
                    ),
                  ),
                  buildHorizontalDivider(context: context, fraction: 0.008),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          orderTitle,
                          style: TextStyle(
                            color: GlobalColors.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel14,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _orderTypeLabel,
                          style: TextStyle(
                            color: GlobalColors.bodyColor,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(width: 1, thickness: 1, color: dividerColor),
            // Column 2 — time & status
            SizedBox(
              width: SizeConfig.width(context, 0.14).clamp(140.0, 190.0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context, 0.01),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Time: $_elapsedLabel',
                      style: TextStyle(
                        color: GlobalColors.bodyColor,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel11,
                        ),
                      ),
                    ),
                    buildVerticalDivider(context: context, fraction: 0.004),
                    Text(
                      _estimateLabel,
                      style: TextStyle(
                        color: _isDelayed
                            ? GlobalColors.kdsCancelled
                            : GlobalColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel12,
                        ),
                      ),
                    ),
                    buildVerticalDivider(context: context, fraction: 0.008),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context, 0.008),
                        vertical: SizeConfig.height(context, 0.005),
                      ),
                      decoration: BoxDecoration(
                        color: status.softBg,
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            status.assetIcon,
                            scale: 2.5,
                          ),
                          buildHorizontalDivider(
                            context: context,
                            fraction: 0.004,
                          ),
                          Flexible(
                            child: Text(
                              status.label,
                              style: TextStyle(
                                color:status.textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.width(
                                  context,
                                  GlobalColors.pixel10,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(width: 1, thickness: 1, color: dividerColor),
            // Column 3 — items
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context, 0.012),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < visibleItems.length; i++)
                      _ItemRow(
                        item: visibleItems[i],
                        checked: _checked.contains(i),
                        completedLook: status == KdsStatus.completed,
                        onToggle:
                            status == KdsStatus.completed ||
                                status == KdsStatus.cancelled
                            ? null
                            : () {
                                setState(() {
                                  if (_checked.contains(i)) {
                                    _checked.remove(i);
                                  } else {
                                    _checked.add(i);
                                  }
                                });
                              },
                      ),
                    if (moreCount > 0)
                      InkWell(
                        onTap: () => setState(() => _expanded = !_expanded),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.height(context, 0.002),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _expanded ? 'Show less' : '+$moreCount more',
                                style: TextStyle(
                                  color: GlobalColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.width(
                                    context,
                                    GlobalColors.pixel11,
                                  ),
                                ),
                              ),
                              Icon(
                                _expanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                size: SizeConfig.width(context, 0.014),
                                color: GlobalColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Column 4 — notes + actions
            SizedBox(
              width: SizeConfig.width(context, 0.18).clamp(170.0, 240.0),
              child: Row(
                children: [
                  Material(
                    color: GlobalColors.kdsNotesBg,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.width(context, 0.008),
                    ),
                    child: InkWell(
                      onTap: () => showOrderNotesDialog(context, widget.ticket),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.008),
                      ),
                      child: SizedBox(
                        width: SizeConfig.width(
                          context,
                          0.032,
                        ).clamp(36.0, 44.0),
                        height: SizeConfig.width(
                          context,
                          0.032,
                        ).clamp(36.0, 44.0),
                        child: Icon(
                          Icons.sticky_note_2_outlined,
                          size: SizeConfig.width(context, 0.016),
                          color: GlobalColors.bodyColor,
                        ),
                      ),
                    ),
                  ),
                  buildHorizontalDivider(context: context, fraction: 0.008),
                  Expanded(
                    child: _CardActions(ticket: widget.ticket, status: status),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatefulWidget {
  const _OrderCard({required this.ticket});

  final KitchenOrderTicket ticket;

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  late Set<int> _checked;

  @override
  void initState() {
    super.initState();
    final status = KdsStatus.fromTicket(widget.ticket);
    _checked = {
      if (status == KdsStatus.completed)
        for (var i = 0; i < widget.ticket.items.length; i++) i,
    };
  }

  @override
  void didUpdateWidget(covariant _OrderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.ticket.id != widget.ticket.id ||
        oldWidget.ticket.status != widget.ticket.status) {
      final status = KdsStatus.fromTicket(widget.ticket);
      _checked = {
        if (status == KdsStatus.completed)
          for (var i = 0; i < widget.ticket.items.length; i++) i,
      };
    }
  }

  String get badgeLabel => widget.ticket.badgeCode;


  String get _elapsedLabel {
    final diff = DateTime.now().difference(widget.ticket.receivedAt);
    final m = diff.inMinutes.clamp(0, 99);
    final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return '${m.toString().padLeft(2, '0')}:$s ago';
  }

  bool get _isDelayed {
    final status = KdsStatus.fromTicket(widget.ticket);
    if (status == KdsStatus.completed || status == KdsStatus.cancelled) {
      return false;
    }
    return DateTime.now().difference(widget.ticket.receivedAt).inMinutes >= 25;
  }

  String get _estimateLabel {
    if (_isDelayed) {
      final over =
          DateTime.now().difference(widget.ticket.receivedAt).inMinutes - 20;
      final mm = over.abs().toString().padLeft(2, '0');
      return 'Delayed: -$mm:00 min';
    }
    return 'Est: 30 min';
  }

  @override
  Widget build(BuildContext context) {
    final status = KdsStatus.fromTicket(widget.ticket);
    final inv = widget.ticket.invoiceNumber?.trim();
    final orderTitle = inv == null || inv.isEmpty ? '#' : '#$inv';
    final visibleItems = widget.ticket.items.take(4).toList();
    final moreCount = widget.ticket.items.length - visibleItems.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
        boxShadow: const [
          BoxShadow(
            color: GlobalColors.kdsCardShadow,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(context, 0.01),vertical: SizeConfig.height(context, 0.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.width(context, 0.045),
                height: SizeConfig.width(context, 0.045),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.ticket.isDineIn
                      ? GlobalColors.kdsNewBg
                      : GlobalColors.takeAway,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width(context, 0.006),
                  ),
                ),
                child: Text(
                  badgeLabel,
                  style: TextStyle(
                    color: GlobalColors.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel20),
                  ),
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.008),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [   Text(
                      orderTitle,
                      style: TextStyle(
                        color: GlobalColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel14,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width(context, 0.008),
                          vertical: SizeConfig.height(context, 0.01),
                        ),
                        decoration: BoxDecoration(
                          color: status.softBg,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.width(context, 0.01),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              status.assetIcon,
                              scale: 2.5,
                            ),
                            buildHorizontalDivider(
                              context: context,
                              fraction: 0.004,
                            ),

                            Text(
                              status.label,
                              style: TextStyle(
                                color:status.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.width(
                                  context,
                                  GlobalColors.pixel10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      Text(
                        widget.ticket.orderTypeLabel,
                        style: TextStyle(
                          color: GlobalColors.black60Color.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.width(
                            context,
                            GlobalColors.pixel11,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: status.softBg,
                              shape: BoxShape.circle,
                            ),
                          ),
                          buildHorizontalDivider(context: context, fraction: 0.006),
                          Text(
                            "${status.subLabel}",
                            style: TextStyle(
                              color:Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConfig.width(
                                context,
                                GlobalColors.pixel10,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],)

                  ],
                ),
              ),
              Column(
                children: [


                ],
              ),


            ],
          ),
          buildVerticalDivider(context: context, fraction: 0.01),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Time: $_elapsedLabel',
                  style: TextStyle(
                    color: GlobalColors.black60Color,fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                  ),
                ),
              ),
              Text(
                _estimateLabel,
                style: TextStyle(
                  color: _isDelayed
                      ? GlobalColors.kdsCancelled
                      : GlobalColors.black60Color,
                  fontWeight: _isDelayed ? FontWeight.w700 : FontWeight.w600,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                ),
              ),
            ],
          ),
          buildVerticalDivider(context: context, fraction: 0.01),
          Divider(color: GlobalColors.dividerColor,height: 0.02,thickness: 0.8,),
          buildVerticalDivider(context: context, fraction: 0.01),
          Expanded(
            child: Column(
              children: [
                for (var i = 0; i < visibleItems.length; i++)
                  _ItemRow(
                    item: visibleItems[i],
                    checked: _checked.contains(i),
                    completedLook: status == KdsStatus.completed,
                    onToggle:
                        status == KdsStatus.completed ||
                            status == KdsStatus.cancelled
                        ? null
                        : () {
                            setState(() {
                              if (_checked.contains(i)) {
                                _checked.remove(i);
                              } else {
                                _checked.add(i);
                              }
                            });
                          },
                  ),
                if (moreCount > 0)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.00),
                      ),
                      child: Text(
                        '+$moreCount more',
                        style: TextStyle(
                          color: GlobalColors.black60Color,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.width(
                            context,
                            GlobalColors.pixel11,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: GlobalColors.dividerColor,height: 0.02,thickness: 0.8,),
          buildVerticalDivider(context: context,fraction: 0.01),
          if(status != KdsStatus.completed &&
              status != KdsStatus.cancelled)
          _NotesBar(onTap: () => showOrderNotesDialog(context, widget.ticket)),
          buildVerticalDivider(context: context, fraction: 0.012),
          _CardActions(ticket: widget.ticket, status: status),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.item,
    required this.checked,
    required this.completedLook,
    required this.onToggle,
  });

  final KitchenOrderItem item;
  final bool checked;
  final bool completedLook;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final qty = item.qty % 1 == 0
        ? item.qty.toInt().toString()
        : item.qty.toString();
    final strike = checked || completedLook;

    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.height(context, 0.008)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${qty}x  ${item.name}',
                  style: TextStyle(
                    color: GlobalColors.productNameColor,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel12),
                    decoration: strike ? TextDecoration.lineThrough : null,
                    decorationColor: GlobalColors.kdsMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.modifiers.isNotEmpty)
                  ...item.modifiers
                      .take(2)
                      .map(
                        (mod) => Text(
                          mod.startsWith('+') || mod.startsWith('-')
                              ? mod
                              : '- $mod',
                          style: TextStyle(
                            color: GlobalColors.productNotesColor,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel10,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                if ((item.notes ?? '').isNotEmpty)
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: GlobalColors.productNotesColor,
                          shape: BoxShape.circle,
                        ),
                      ),buildHorizontalDivider(context: context,fraction: 0.005),
                      Text(
                        item.notes!,
                        style: TextStyle(
                          color: GlobalColors.productNotesColor,
                          fontSize: SizeConfig.width(context, GlobalColors.pixel10),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),


              ],
            ),
          ),
          buildHorizontalDivider(context: context, fraction: 0.006),
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: SizeConfig.width(context, 0.018).clamp(18.0, 22.0),
              height: SizeConfig.width(context, 0.018).clamp(18.0, 22.0),
              decoration: BoxDecoration(
                color: strike
                    ? GlobalColors.kdsColor
                    : GlobalColors.whiteColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: strike
                      ? GlobalColors.kdsColor
                      : GlobalColors.fieldBorder,
                  width: 1.4,
                ),
              ),
              child: strike
                  ? Icon(
                      Icons.check,
                      size: SizeConfig.width(context, 0.012),
                      color: GlobalColors.whiteColor,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesBar extends StatelessWidget {
  const _NotesBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GlobalColors.kdsNotesBg.withOpacity(0.1),
      borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.01)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context, 0.01),
            vertical: SizeConfig.height(context, 0.01),
          ),
          child: Row(
            children: [
              Image.asset(AppImages.notes,scale:2.3,),
              buildHorizontalDivider(context: context, fraction: 0.006),
              Expanded(
                child: Text(
                  'Notes',
                  style: TextStyle(
                    color: GlobalColors.kdsNotesBg,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: SizeConfig.width(context, 0.018),
                color: GlobalColors.kdsNotesBg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({required this.ticket, required this.status});

  final KitchenOrderTicket ticket;
  final KdsStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == KdsStatus.completed || status == KdsStatus.cancelled) {
      return SizedBox(
        height: SizeConfig.height(context, 0.048).clamp(40.0, 48.0),
        child: Center(
          child: Text(
            status.label,
            style: TextStyle(
              color: status.accent,
              fontWeight: FontWeight.w800,
              fontSize: SizeConfig.width(context, GlobalColors.pixel16),
            ),
          ),
        ),
      );
    }

    final isNew = status == KdsStatus.newOrder;
    return SizedBox(
      height: SizeConfig.height(context, 0.048).clamp(40.0, 48.0),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              label: isNew ? 'Cancel' : 'Hold',
              filled: false,
              color: GlobalColors.cancelTextColor,
              background: GlobalColors.cancelBg,
              onTap: () {
                if (isNew) {
                  KitchenOrderStore.instance.cancelOrder(ticket.id);
                } else {
                  KitchenOrderStore.instance.holdOrder(ticket.id);
                }
              },
            ),
          ),
          buildHorizontalDivider(context: context, fraction: 0.008),
          Expanded(
            child: _ActionButton(
              label: isNew ? 'Start' : 'Complete',
              filled: true,
              color: isNew
                  ?GlobalColors.whiteColor: GlobalColors.black60Color,
              background: isNew
                  ? GlobalColors.kdsNewBg
                  : GlobalColors.kdsProcessing,
              onTap: () {
                if (isNew) {
                  KitchenOrderStore.instance.startOrder(ticket.id);
                } else {
                  KitchenOrderStore.instance.completeOrder(ticket.id);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.filled,
    required this.color,
    required this.background,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.008)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.008)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.width(context, GlobalColors.pixel13),
            ),
          ),
        ),
      ),
    );
  }
}
