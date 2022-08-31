import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(explicitToJson: true)
class Payment {
  int? id;
  int? transactionId;
  String? cli;
  String? ddi;
  String? smsBody;
  String? callDuration;
  int? initiatedAt;
  String? ipnStatus;

  Payment(this.id, this.transactionId, this.cli, this.ddi, this.smsBody,
      this.callDuration, this.initiatedAt, this.ipnStatus);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

}