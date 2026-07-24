import 'package:flovix_kitchen/screens/kitchen/kitchen_display_screen.dart' show KdsStatus;
import 'package:flovix_kitchen/widgets/kitchen_order_notes_dialog.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_model.dart';
import 'package:flovix_kitchen/services/kitchen/kitchen_order_store.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/helper/divider.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';

/// Column-wise list card: Identity | Time/Status | Items | Actions
class OrderListRowWidget extends StatefulWidget {
  const OrderListRowWidget({required this.ticket});

  final KitchenOrderTicket ticket;

  @override
  State<OrderListRowWidget> createState() => _OrderListRowWidgetState();
}

class _OrderListRowWidgetState extends State<OrderListRowWidget> {
  late Set<int> _checked;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _checked = _initialChecked(widget.ticket);
  }

  @override
  void didUpdateWidget(covariant OrderListRowWidget oldWidget) {
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
                          Icon(
                            status.icon,
                            size: SizeConfig.width(context, 0.012),
                            color: status.accent,
                          ),
                          buildHorizontalDivider(
                            context: context,
                            fraction: 0.004,
                          ),
                          Flexible(
                            child: Text(
                              status.label,
                              style: TextStyle(
                                color: status.accent,
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
    final visibleItems = widget.ticket.items.take(3).toList();
    final moreCount = widget.ticket.items.length - visibleItems.length;

    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.whiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.012)),
        boxShadow: const [
          BoxShadow(
            color: GlobalColors.kdsCardShadow,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(SizeConfig.width(context, 0.012)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.width(context, 0.032).clamp(36.0, 44.0),
                height: SizeConfig.width(context, 0.032).clamp(36.0, 44.0),
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
                    fontSize: SizeConfig.width(context, GlobalColors.pixel12),
                  ),
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.008),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Icon(
                      status.icon,
                      size: SizeConfig.width(context, 0.012),
                      color: status.accent,
                    ),
                    buildHorizontalDivider(context: context, fraction: 0.004),
                    Text(
                      status.label,
                      style: TextStyle(
                        color: status.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.width(
                          context,
                          GlobalColors.pixel10,
                        ),
                      ),
                    ),
                  ],
                ),
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
                    color: GlobalColors.bodyColor,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                  ),
                ),
              ),
              Text(
                _estimateLabel,
                style: TextStyle(
                  color: _isDelayed
                      ? GlobalColors.kdsCancelled
                      : GlobalColors.bodyColor,
                  fontWeight: _isDelayed ? FontWeight.w700 : FontWeight.w500,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                ),
              ),
            ],
          ),
          buildVerticalDivider(context: context, fraction: 0.004),
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: status.accent,
                  shape: BoxShape.circle,
                ),
              ),
              buildHorizontalDivider(context: context, fraction: 0.006),
              Text(
                status.subLabel,
                style: TextStyle(
                  color: status.accent,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                ),
              ),
            ],
          ),
          buildVerticalDivider(context: context, fraction: 0.012),
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
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.004),
                      ),
                      child: Text(
                        '+$moreCount more',
                        style: TextStyle(
                          color: GlobalColors.kdsMuted,
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
                  '${qty}x ${item.name}',
                  style: TextStyle(
                    color: GlobalColors.textColor,
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
                        color: GlobalColors.kdsMuted,
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
                  Text(
                    item.notes!,
                    style: TextStyle(
                      color: GlobalColors.kdsProcessing,
                      fontSize: SizeConfig.width(context, GlobalColors.pixel10),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    ? GlobalColors.kdsCompleted
                    : GlobalColors.whiteColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: strike
                      ? GlobalColors.kdsCompleted
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
      color: GlobalColors.kdsNotesBg,
      borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.008)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.008)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context, 0.01),
            vertical: SizeConfig.height(context, 0.01),
          ),
          child: Row(
            children: [
              Icon(
                Icons.sticky_note_2_outlined,
                size: SizeConfig.width(context, 0.014),
                color: GlobalColors.bodyColor,
              ),
              buildHorizontalDivider(context: context, fraction: 0.006),
              Expanded(
                child: Text(
                  'Notes',
                  style: TextStyle(
                    color: GlobalColors.bodyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.width(context, GlobalColors.pixel11),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: SizeConfig.width(context, 0.016),
                color: GlobalColors.kdsMuted,
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
              color: GlobalColors.bodyColor,
              background: GlobalColors.kdsNotesBg,
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
              color: GlobalColors.whiteColor,
              background: isNew
                  ? GlobalColors.kdsNew
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