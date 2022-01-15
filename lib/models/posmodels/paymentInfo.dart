// To parse this JSON data, do
//
//     final paymentInfo = paymentInfoFromJson(jsonString);

import 'dart:convert';

List<PaymentInfo> paymentInfoFromJson(String str) => List<PaymentInfo>.from(
    json.decode(str).map((x) => PaymentInfo.fromJson(x)));

String paymentInfoToJson(List<PaymentInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentInfo {
  PaymentInfo({
    this.id,
    this.paytype,
    this.code,
    this.detail,
    this.valuetype,
    this.value,
    this.pcamt,
    this.pcpc,
  });

  int id;
  String paytype;
  String code;
  String detail;
  int valuetype;
  double value;
  double pcamt;
  double pcpc;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        id: json["Id"],
        paytype: json["paytype"],
        code: json["code"],
        detail: json["detail"],
        valuetype: json["valuetype"],
        value: json["value"].toDouble(),
        pcamt: json["pcamt"].toDouble(),
        pcpc: json["pcpc"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "paytype": paytype,
        "code": code,
        "detail": detail,
        "valuetype": valuetype,
        "value": value,
        "pcamt": pcamt,
        "pcpc": pcpc,
      };
}
