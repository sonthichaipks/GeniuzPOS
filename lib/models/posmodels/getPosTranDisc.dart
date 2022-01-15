// To parse this JSON data, do
//
//     final getPosTranDisc = getPosTranDiscFromJson(jsonString);

import 'dart:convert';

List<GetPosTranDisc> getPosTranDiscFromJson(String str) =>
    List<GetPosTranDisc>.from(
        json.decode(str).map((x) => GetPosTranDisc.fromJson(x)));

String getPosTranDiscToJson(List<GetPosTranDisc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPosTranDisc {
  GetPosTranDisc({
    this.id,
    this.docNo,
    this.lineItemNo,
    this.lineItemType,
    this.discPc,
    this.discAmt,
    this.discCouponType,
    this.discCouponNo,
    this.promoId,
    this.chargePc,
    this.chargeAmt,
  });

  int id;
  String docNo;
  int lineItemNo;
  String lineItemType;
  double discPc;
  double discAmt;
  String discCouponType;
  String discCouponNo;
  String promoId;
  double chargePc;
  double chargeAmt;

  factory GetPosTranDisc.fromJson(Map<String, dynamic> json) => GetPosTranDisc(
        id: json["id"],
        docNo: json["docNo"],
        lineItemNo: json["lineItemNo"],
        lineItemType: json["lineItemType"],
        discPc: json["discPc"].toDouble(),
        discAmt: json["discAmt"].toDouble(),
        discCouponType: json["discCouponType"],
        discCouponNo: json["discCouponNo"],
        promoId: json["promoId"],
        chargePc: json["chargePc"].toDouble(),
        chargeAmt: json["chargeAmt"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "docNo": docNo,
        "lineItemNo": lineItemNo,
        "lineItemType": lineItemType,
        "discPc": discPc,
        "discAmt": discAmt,
        "discCouponType": discCouponType,
        "discCouponNo": discCouponNo,
        "promoId": promoId,
        "chargePc": chargePc,
        "chargeAmt": chargeAmt,
      };
}
