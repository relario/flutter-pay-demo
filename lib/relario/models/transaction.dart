import 'package:json_annotation/json_annotation.dart';

import 'payment.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction {
  String? transactionId;
  int? merchantId;
  String? productId;
  String? productName;
  String? customerId;
  int? smsCount;
  int? callDuration;
  String? customerIpAddress;
  String? smsBody;
  String? iosClickToSmsUrl;
  String? androidClickToSmsUrl;
  List<String>? phoneNumbersList;
  List<Payment>? payments;
  int? createdAt;

  String? audioFileName;

  String? customerCountryCode;

  String? customerLanguage;

  String? customerMccmnc;

  String? customerMsisdn;

  String? paymentType;

  String? status;
  bool? test;

  int updatedAt;

  Transaction(
      this.transactionId,
      this.merchantId,
      this.productId,
      this.productName,
      this.customerId,
      this.smsCount,
      this.callDuration,
      this.customerIpAddress,
      this.smsBody,
      this.iosClickToSmsUrl,
      this.androidClickToSmsUrl,
      this.phoneNumbersList,
      this.payments,
      this.createdAt,
      this.audioFileName,
      this.customerCountryCode,
      this.customerLanguage,
      this.customerMccmnc,
      this.customerMsisdn,
      this.paymentType,
      this.status,
      this.test,
      this.updatedAt);


  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

}