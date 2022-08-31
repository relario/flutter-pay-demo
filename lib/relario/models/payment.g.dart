// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['id'] as int?,
      json['transactionId'] as int?,
      json['cli'] as String?,
      json['ddi'] as String?,
      json['smsBody'] as String?,
      json['callDuration'] as String?,
      json['initiatedAt'] as int?,
      json['ipnStatus'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'cli': instance.cli,
      'ddi': instance.ddi,
      'smsBody': instance.smsBody,
      'callDuration': instance.callDuration,
      'initiatedAt': instance.initiatedAt,
      'ipnStatus': instance.ipnStatus,
    };
