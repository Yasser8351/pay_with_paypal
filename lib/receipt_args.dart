
import 'package:fib/receipt_config.dart';

class ReceiptArgs {
  final List<ReceiptConfig> receiptConfig;
  final bool isSuccess;
  final String message;
  String transactionType;

  ReceiptArgs({
    required this.receiptConfig,
    this.isSuccess = false,
    this.message = '',
    this.transactionType = '',
  });
}
