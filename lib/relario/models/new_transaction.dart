import 'package:json_annotation/json_annotation.dart';

part 'new_transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class NewTransaction {
  String paymentType = 'sms';
  String customerId;
  String productId;
  String productName;
  String customerIpAddress;
  String? customerMsisdn;
  String? customerMccmnc;
  int smsCount;

  NewTransaction(
      this.paymentType,
      this.customerId,
      this.productId,
      this.productName,
      this.customerIpAddress,
      this.customerMsisdn,
      this.customerMccmnc,
      this.smsCount);

  Map<String, dynamic> toJson() => _$NewTransactionToJson(this);
}