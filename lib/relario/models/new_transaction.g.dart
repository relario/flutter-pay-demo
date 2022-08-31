// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTransaction _$NewTransactionFromJson(Map<String, dynamic> json) =>
    NewTransaction(
      json['paymentType'] as String,
      json['customerId'] as String,
      json['productId'] as String,
      json['productName'] as String,
      json['customerIpAddress'] as String,
      json['customerMsisdn'] as String?,
      json['customerMccmnc'] as String?,
      json['smsCount'] as int,
    );

Map<String, dynamic> _$NewTransactionToJson(NewTransaction instance) =>
    <String, dynamic>{
      'paymentType': instance.paymentType,
      'customerId': instance.customerId,
      'productId': instance.productId,
      'productName': instance.productName,
      'customerIpAddress': instance.customerIpAddress,
      'customerMsisdn': instance.customerMsisdn,
      'customerMccmnc': instance.customerMccmnc,
      'smsCount': instance.smsCount,
    };
