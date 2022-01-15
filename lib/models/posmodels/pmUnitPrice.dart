// To parse this JSON data, do
//
//     final pmUnitPrice = pmUnitPriceFromJson(jsonString);

import 'dart:convert';

List<PmUnitPrice> pmUnitPriceFromJson(String str) => List<PmUnitPrice>.from(
    json.decode(str).map((x) => PmUnitPrice.fromJson(x)));

String pmUnitPriceToJson(List<PmUnitPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PmUnitPrice {
  PmUnitPrice({
    this.id,
    this.itemCode,
    this.promoId,
    this.promoName,
    this.promoDesc,
    this.promoStatus,
    this.promoApproveFg,
    this.promoDayFg,
    this.promoDay,
    this.promoCustFg,
    this.promoType,
    this.promoPrice,
    this.promoDiscPc,
    this.gpNormal,
    this.gpPromo,
    this.basePriceByPoSpriceNo,
    this.basePriceByPos,
    this.proPriceByPriceNo,
    this.proPriceByDisc,
    this.mbId,
    this.mbPriceNo,
    this.mbPrice,
  });
  int id;
  String itemCode;
  String promoId;
  String promoName;
  String promoDesc;
  int promoStatus;
  int promoApproveFg;
  int promoDayFg;
  String promoDay;
  int promoCustFg;
  int promoType;
  double promoPrice;
  double promoDiscPc;
  double gpNormal;
  double gpPromo;
  int basePriceByPoSpriceNo;
  double basePriceByPos;
  double proPriceByPriceNo;
  double proPriceByDisc;
  String mbId;
  int mbPriceNo;
  double mbPrice;

  factory PmUnitPrice.fromJson(Map<String, dynamic> json) => PmUnitPrice(
        id: json["id"],
        itemCode: json["ItemCode"],
        promoId: json["PromoId"],
        promoName: json["PromoName"],
        promoDesc: json["PromoDesc"],
        promoStatus: json["PromoStatus"],
        promoApproveFg: json["PromoApproveFg"],
        promoDayFg: json["PromoDayFg"],
        promoDay: json["PromoDay"],
        promoCustFg: json["PromoCustFg"],
        promoType: json["PromoType"],
        promoPrice: json["PromoPrice"].toDouble(),
        promoDiscPc: json["PromoDiscPc"].toDouble(),
        gpNormal: json["GpNormal"].toDouble(),
        gpPromo: json["GpPromo"].toDouble(),
        basePriceByPoSpriceNo: json["BasePriceByPOSpriceNo"],
        basePriceByPos: json["BasePriceByPOS"].toDouble(),
        proPriceByPriceNo: json["ProPriceByPriceNo"].toDouble(),
        proPriceByDisc: json["ProPriceByDisc"].toDouble(),
        mbId: json["MbId"],
        mbPriceNo: json["MbPriceNo"],
        mbPrice: json["MbPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ItemCode": itemCode,
        "PromoId": promoId,
        "PromoName": promoName,
        "PromoDesc": promoDesc,
        "PromoStatus": promoStatus,
        "PromoApproveFg": promoApproveFg,
        "PromoDayFg": promoDayFg,
        "PromoDay": promoDay,
        "PromoCustFg": promoCustFg,
        "PromoType": promoType,
        "PromoPrice": promoPrice,
        "PromoDiscPc": promoDiscPc,
        "GpNormal": gpNormal,
        "GpPromo": gpPromo,
        "BasePriceByPOSpriceNo": basePriceByPoSpriceNo,
        "BasePriceByPOS": basePriceByPos,
        "ProPriceByPriceNo": proPriceByPriceNo,
        "ProPriceByDisc": proPriceByDisc,
        "MbId": mbId,
        "MbPriceNo": mbPriceNo,
        "MbPrice": mbPrice,
      };
}
