// To parse this JSON data, do
//
//     final getPosTranReceipt = getPosTranReceiptFromJson(jsonString);

import 'dart:convert';

List<GetPosTranReceipt> getPosTranReceiptFromJson(String str) =>
    List<GetPosTranReceipt>.from(
        json.decode(str).map((x) => GetPosTranReceipt.fromJson(x)));

String getPosTranReceiptToJson(List<GetPosTranReceipt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPosTranReceipt {
  GetPosTranReceipt({
    this.id,
    this.docNo,
    this.lineItemNo,
    this.paymentType,
    this.receiptAmt,
    this.refType,
    this.refNo,
    this.pointBurn,
    this.currencyCode,
    this.currencyAmt,
    this.exchangeRate,
  });

  int id;
  String docNo;
  int lineItemNo;
  int paymentType;
  double receiptAmt;
  String refType;
  String refNo;
  double pointBurn;
  String currencyCode;
  double currencyAmt;
  double exchangeRate;

  factory GetPosTranReceipt.fromJson(Map<String, dynamic> json) =>
      GetPosTranReceipt(
        id: json["id"],
        docNo: json["docNo"],
        lineItemNo: json["lineItemNo"],
        paymentType: json["paymentType"],
        receiptAmt: json["receiptAmt"].toDouble(),
        refType: json["refType"],
        refNo: json["refNo"],
        pointBurn: json["pointBurn"].toDouble(),
        currencyCode: json["currencyCode"],
        currencyAmt: json["currencyAmt"].toDouble(),
        exchangeRate: json["exchangeRate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "docNo": docNo,
        "lineItemNo": lineItemNo,
        "paymentType": paymentType,
        "receiptAmt": receiptAmt,
        "refType": refType,
        "refNo": refNo,
        "pointBurn": pointBurn,
        "currencyCode": currencyCode,
        "currencyAmt": currencyAmt,
        "exchangeRate": exchangeRate,
      };
}
