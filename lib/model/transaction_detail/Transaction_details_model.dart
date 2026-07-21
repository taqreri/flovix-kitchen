import 'Invoice.dart';

/// invoice : {"invoice_id":1143,"inv_number":"150","inv_date":"2025-10-17","inv_warehouse":1,"class_id":0,"po_number":"0","rep_id":0,"ship_via_id":8,"fob_number":"0","main_inv_number":"150","inv_shipto":"","inv_cus_id":7,"inv_total":10.35,"inv_notes":"","inv_round_value":-0.35,"inv_discount_id":1522,"inv_disc_percent":"10.0000%","inv_tax_id":1586,"inv_tax":1.35,"inv_payment_id":13,"inv_due":10,"counter_id":4,"invoiceItems":[{"item_id":2969,"item_reg_num":61,"item_description":"101 - ربع برست حراق","item_price":10,"item_qty":1,"discount_percent":"0","item_discount":0,"item_total":10,"batch_id":"","item_tax":1.35,"inv_total":null,"tax_inclusive":0,"item_tax_id":1586,"tax_percent":"15.0000%","item_inv_disc":1,"item_unit":{"uom_value":1,"uom_name":"piece"},"uom_pos":0,"price-taxable":0,"item-type":4,"subof_id":[]}]}

  class TransactionDetailsModel {
  TransactionDetailsModel({
      this.invoice,});

  TransactionDetailsModel.fromJson(dynamic json) {
    invoice = json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null;
  }
  Invoice? invoice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (invoice != null) {
      map['invoice'] = invoice?.toJson();
    }
    return map;
  }

}