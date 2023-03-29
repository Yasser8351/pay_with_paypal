import 'dart:convert';

import '../utils/base_http_service.dart';
import '../utils/fib_logger.dart';

abstract class IAccountTransactionHistoryService {
  Future<List<dynamic>> getTransactionHistory();
}

class AccountTransactionHistoryService extends BaseHttpService
    implements IAccountTransactionHistoryService {
  @override
  String get path => '/GetKey';

  @override
  Future<List<dynamic>> getTransactionHistory() async {
    try {
      List<dynamic> transactions = [];
      Map<String, dynamic> body = {
        "key": "20",
        "Service": "get key",
      };

      var res = await post(body: body);
      Map<String, dynamic> data = jsonDecode(res.data['transactions']);
      int noOfTran = data['NoOftran'] ?? 0;

      for (var i = 1; i <= noOfTran; i++) {
        // transactions.add(AccountTransaction.fromJson(data[i.toString()]));
      }

      return transactions;
    } catch (e) {
      FibLogger.e('Error', e);
      rethrow;
    }
  }
}
