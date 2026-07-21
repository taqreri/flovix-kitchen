
import 'package:flovix_kitchen/model/offline_transaction_model/Offline_transaction_model.dart';
import 'package:flovix_kitchen/model/transaction_detail/Invoice.dart';
import 'package:flovix_kitchen/model/transaction_detail/Transaction_details_model.dart';

class PosMainScreenArgument{
final int?id;
final bool isFromTransactionScreen;
final bool isHoldOrder;
final bool isCompleted;
final bool isOrder;
//final Invoice ?offlineTransactionData;
final Invoice ?invoice;
final int? invId;
final OfflineTransactionModel? offlineTransactionModel;
final TransactionDetailsModel? transactionDetailsModel;

PosMainScreenArgument({this.id,this.isFromTransactionScreen=false,
  this.isCompleted=false,
  this.invoice,
 // this.offlineTransactionData,
  this.offlineTransactionModel,
  this.transactionDetailsModel,
  this.isHoldOrder=false,
  this.isOrder=false,this.invId});

}