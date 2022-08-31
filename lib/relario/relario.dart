import 'dart:convert';

import 'package:http/http.dart';
import 'package:relario_flutter_demo/relario/models/transaction.dart';

import 'models/new_transaction.dart';

const String RELARIO_URL = "https://payment.relario.com/api/web";

class Ip {
  final String ip;

  const Ip({required this.ip});

  factory Ip.fromJson(Map<String, dynamic> json) {
    return Ip(
      ip: json['ip'],
    );
  }
}

class RelarioService {
  static RelarioService? _instance;

  final String _apiKey;

  factory RelarioService(String apiKey) {
    _instance ??= RelarioService._internal(apiKey);
    return _instance!;
  }

  RelarioService._internal(this._apiKey);

  Future<Transaction> createTransaction(NewTransaction newTransaction) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    };
    Uri url = Uri.parse("$RELARIO_URL/transactions");
    var response = await post(url, headers: headers, body: jsonEncode(newTransaction.toJson()));
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create transaction");
    }
  }

  Future<Transaction> getTransaction(String transactionId) async {
    Map<String, String> headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    };
    Uri url = Uri.parse("$RELARIO_URL/transactions/$transactionId");
    var response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create transaction");
    }
  }

  Future<Ip> getPublicIp() async {
    Uri uri = Uri.parse('https://api.ipify.org?format=json');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      return Ip.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get Public IP");
    }
  }
}
