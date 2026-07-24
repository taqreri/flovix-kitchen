import 'package:flovix_kitchen/services/kitchen/kitchen_order_model.dart';
import 'package:flovix_kitchen/utils/colors/colors.dart';
import 'package:flovix_kitchen/utils/helper/divider.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';

/// Figma-style notes dialog: product notes first, then invoice note.
Future<void> showOrderNotesDialog(
  BuildContext context,
  KitchenOrderTicket ticket,
) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (ctx) => _KitchenOrderNotesDialog(ticket: ticket),
  );
}

class _KitchenOrderNotesDialog extends StatelessWidget {
  const _KitchenOrderNotesDialog({required this.ticket});

  final KitchenOrderTicket ticket;

  @override
  Widget build(BuildContext context) {
    final productEntries = ticket.items
        .map((item) {
          final noteText = _productNoteText(item);
          if (noteText.isEmpty) return null;
          return (label: _qtyLabel(item), note: noteText);
        })
        .whereType<({String label, String note})>()
        .toList();
    final invoiceNote = (ticket.notes ?? '').trim();
    final hasAny = productEntries.isNotEmpty || invoiceNote.isNotEmpty;

    return Dialog(
      backgroundColor: GlobalColors.whiteColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, 0.2),
        vertical: SizeConfig.height(context, 0.08),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.012)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: SizeConfig.width(context, 0.4).clamp(340.0, 480.0),
          maxHeight: SizeConfig.height(context, 0.72),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.width(context, 0.018),
            SizeConfig.height(context, 0.018),
            SizeConfig.width(context, 0.018),
            SizeConfig.height(context, 0.02),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        color: GlobalColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize:
                            SizeConfig.width(context, GlobalColors.pixel18),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.width(context, 0.004)),
                      child: Icon(
                        Icons.close_rounded,
                        color: GlobalColors.bodyColor,
                        size: SizeConfig.width(context, 0.02),
                      ),
                    ),
                  ),
                ],
              ),
              buildVerticalDivider(context: context, fraction: 0.012),
              const Divider(
                height: 1,
                thickness: 1,
                color: GlobalColors.fieldBorder,
              ),
              buildVerticalDivider(context: context, fraction: 0.014),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!hasAny)
                        Text(
                          'No notes for this order.',
                          style: TextStyle(
                            color: GlobalColors.productNotesColor,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel13,
                            ),
                          ),
                        ),
                      for (final entry in productEntries) ...[
                        Text(
                          entry.label,
                          style: TextStyle(
                            color: GlobalColors.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.width(
                              context,
                              GlobalColors.pixel14,
                            ),
                          ),
                        ),
                        buildVerticalDivider(
                          context: context,
                          fraction: 0.008,
                        ),
                        _NoteBox(text: entry.note),
                        buildVerticalDivider(
                          context: context,
                          fraction: 0.018,
                        ),
                      ],
                      Text(
                        'Invoice Note',
                        style: TextStyle(
                          color: GlobalColors.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.width(
                            context,
                            GlobalColors.pixel14,
                          ),
                        ),
                      ),
                      buildVerticalDivider(context: context, fraction: 0.008),
                      _NoteBox(
                        text: invoiceNote.isEmpty
                            ? 'No invoice note.'
                            : invoiceNote,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _qtyLabel(KitchenOrderItem item) {
  final qty = item.qty % 1 == 0
      ? item.qty.toInt().toString()
      : item.qty.toString();
  return '${qty}x ${item.name}';
}

String _productNoteText(KitchenOrderItem item) {
  final parts = <String>[
    if ((item.notes ?? '').trim().isNotEmpty) item.notes!.trim(),
    ...item.modifiers
        .map((m) => m.trim())
        .where((text) => text.isNotEmpty),
  ];
  return parts.join('\n');
}

class _NoteBox extends StatelessWidget {
  const _NoteBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, 0.012),
        vertical: SizeConfig.height(context, 0.014),
      ),
      decoration: BoxDecoration(
        color: GlobalColors.whiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.008)),
        border: Border.all(color: GlobalColors.fieldBorder),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: GlobalColors.productNotesColor,
          height: 1.45,
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig.width(context, GlobalColors.pixel12),
        ),
      ),
    );
  }
}
