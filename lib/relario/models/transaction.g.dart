// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['transactionId'] as String?,
      json['merchantId'] as int?,
      json['productId'] as String?,
      json['productName'] as String?,
      json['customerId'] as String?,
      json['smsCount'] as int?,
      json['callDuration'] as int?,
      json['customerIpAddress'] as String?,
      json['smsBody'] as String?,
      json['iosClickToSmsUrl'] as String?,
      json['androidClickToSmsUrl'] as String?,
      (json['phoneNumbersList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['payments'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['createdAt'] as int?,
      json['audioFileName'] as String?,
      json['customerCountryCode'] as String?,
      json['customerLanguage'] as String?,
      json['customerMccmnc'] as String?,
      json['customerMsisdn'] as String?,
      json['paymentType'] as String?,
      json['status'] as String?,
      json['test'] as bool?,
      json['updatedAt'] as int,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'merchantId': instance.merchantId,
      'productId': instance.productId,
      'productName': instance.productName,
      'customerId': instance.customerId,
      'smsCount': instance.smsCount,
      'callDuration': instance.callDuration,
      'customerIpAddress': instance.customerIpAddress,
      'smsBody': instance.smsBody,
      'iosClickToSmsUrl': instance.iosClickToSmsUrl,
      'androidClickToSmsUrl': instance.androidClickToSmsUrl,
      'phoneNumbersList': instance.phoneNumbersList,
      'payments': instance.payments?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'audioFileName': instance.audioFileName,
      'customerCountryCode': instance.customerCountryCode,
      'customerLanguage': instance.customerLanguage,
      'customerMccmnc': instance.customerMccmnc,
      'customerMsisdn': instance.customerMsisdn,
      'paymentType': instance.paymentType,
      'status': instance.status,
      'test': instance.test,
      'updatedAt': instance.updatedAt,
    };
