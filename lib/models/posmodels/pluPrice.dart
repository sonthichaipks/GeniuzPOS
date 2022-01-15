// To parse this JSON data, do
//
//     final pluPrice = pluPriceFromJson(jsonString);

import 'dart:convert';

List<PluPrice> pluPriceFromJson(String str) =>
    List<PluPrice>.from(json.decode(str).map((x) => PluPrice.fromJson(x)));

String pluPriceToJson(List<PluPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PluPrice {
  PluPrice({
    this.id,
    this.pluCode,
    this.pluDesc,
    this.pluShortDesc,
    this.colorId,
    this.sizeId,
    this.articleStyle,
    this.supplCode,
    this.allowSaleOverStock,
    this.stockFg,
    this.mbDiscMethod,
    this.mbDiscPs,
    this.mbPriceFg,
    this.qtyOnHand,
    this.sellUnitRatio,
    this.promoId,
    this.basePriceByPos,
    this.basePriceByPoSpriceNo,
    this.gpNormal,
    this.gpPromo,
    this.mbId,
    this.mbPriceNo,
    this.mbPrice,
    this.promoDay,
    this.promoPrice,
  });

  int id;
  String pluCode;
  String pluDesc;
  String pluShortDesc;
  String colorId;
  String sizeId;
  String articleStyle;
  String supplCode;
  int allowSaleOverStock;
  int stockFg;
  int mbDiscMethod;
  double mbDiscPs;
  int mbPriceFg;
  double qtyOnHand;
  double sellUnitRatio;
  String promoId;
  double basePriceByPos;
  int basePriceByPoSpriceNo;
  double gpNormal;
  double gpPromo;
  String mbId;
  int mbPriceNo;
  double mbPrice;
  String promoDay;
  double promoPrice;

  factory PluPrice.fromJson(Map<String, dynamic> json) => PluPrice(
        id: json["id"],
        pluCode: json["pluCode"],
        pluDesc: json["pluDesc"],
        pluShortDesc: json["pluShortDesc"],
        colorId: json["colorId"],
        sizeId: json["sizeId"],
        articleStyle: json["articleStyle"],
        supplCode: json["supplCode"],
        allowSaleOverStock: json["allowSaleOverStock"],
        stockFg: json["stockFg"],
        mbDiscMethod: json["mbDiscMethod"],
        mbDiscPs: json["mbDiscPs"].toDouble(),
        mbPriceFg: json["mbPriceFg"],
        qtyOnHand: json["qtyOnHand"].toDouble(),
        sellUnitRatio: json["sellUnitRatio"].toDouble(),
        promoId: json["promoId"],
        basePriceByPos: json["basePriceByPos"].toDouble(),
        basePriceByPoSpriceNo: json["basePriceByPoSpriceNo"],
        gpNormal: json["gpNormal"].toDouble(),
        gpPromo: json["gpPromo"].toDouble(),
        mbId: json["mbId"],
        mbPriceNo: json["mbPriceNo"],
        mbPrice: json["mbPrice"].toDouble(),
        promoDay: json["promoDay"],
        promoPrice: json["promoPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pluCode": pluCode,
        "pluDesc": pluDesc,
        "pluShortDesc": pluShortDesc,
        "colorId": colorId,
        "sizeId": sizeId,
        "articleStyle": articleStyle,
        "supplCode": supplCode,
        "allowSaleOverStock": allowSaleOverStock,
        "stockFg": stockFg,
        "mbDiscMethod": mbDiscMethod,
        "mbDiscPs": mbDiscPs,
        "mbPriceFg": mbPriceFg,
        "qtyOnHand": qtyOnHand,
        "sellUnitRatio": sellUnitRatio,
        "promoId": promoId,
        "basePriceByPos": basePriceByPos,
        "basePriceByPoSpriceNo": basePriceByPoSpriceNo,
        "gpNormal": gpNormal,
        "gpPromo": gpPromo,
        "mbId": mbId,
        "mbPriceNo": mbPriceNo,
        "mbPrice": mbPrice,
        "promoDay": promoDay,
        "promoPrice": promoPrice,
      };
}
