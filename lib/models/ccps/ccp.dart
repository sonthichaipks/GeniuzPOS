// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

List<CardsCoupon> cardcouponFromJson(String str) => List<CardsCoupon>.from(
    json.decode(str).map((x) => CardsCoupon.fromJson(x)));

String salmanToJson(CardsCoupon data) => json.encode(data.toJson());

class CardsCoupon {
  CardsCoupon({
    this.ccpid,
    this.ccpName,
    this.ccpType,
    this.ccpLogo,
    this.ccpAmount,
    this.expireDate,
    this.ccpNumber,
    this.ccpApproveCode,
  });

  final String ccpid;
  final String ccpName;
  final String ccpType;
  final String ccpLogo;
  final double ccpAmount;
  final String expireDate;
  final String ccpNumber;
  final String ccpApproveCode;

  factory CardsCoupon.fromJson(Map<String, dynamic> json) => CardsCoupon(
        ccpid: json["ccpid"],
        ccpName: json["ccpName"],
        ccpType: json["ccpType"],
        ccpLogo: json["ccpLogo"],
        ccpAmount: json["ccpAmount"].toDouble(),
        expireDate: json["expireDate"],
        ccpNumber: json["ccpNumber"],
        ccpApproveCode: json["ccpApproveCode"],
      );

  Map<String, dynamic> toJson() => {
        "ccpid": ccpid,
        "ccpName": ccpName,
        "ccpType": ccpType,
        "ccpLogo": ccpLogo,
        "ccpAmount": ccpAmount.toString(),
        "expireDate": expireDate,
        "ccpNumber": ccpNumber,
        "ccpApproveCode": ccpApproveCode,
      };
}

class CCPItems {
  CCPItems(
    this.ccpid,
    this.ccpName,
    this.ccpType,
    this.ccpLogo,
    this.ccpAmount,
    this.expireDate,
    this.ccpNumber,
    this.ccpApproveCode,
  );
  final String ccpid;
  final String ccpName;
  final String ccpType;
  final String ccpLogo;
  final double ccpAmount;
  final String expireDate;
  final String ccpNumber;
  final String ccpApproveCode;
}
