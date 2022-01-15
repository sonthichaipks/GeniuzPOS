// To parse this JSON data, do
//
//     final csPlu = csPluFromJson(jsonString);

import 'dart:convert';

List<CsPlu> csPluFromJson(String str) =>
    List<CsPlu>.from(json.decode(str).map((x) => CsPlu.fromJson(x)));

String csPluToJson(List<CsPlu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsPlu {
  CsPlu({
    this.id,
    this.articleCode,
    this.skuCode,
    this.pluCode,
    this.pluIntCode,
    this.pluDesc,
    this.pluShortDesc,
    this.styleId,
    this.colorId,
    this.sizeId,
    this.tasteId,
    this.matTypeId,
    this.sellUnit,
    this.sellUnitRatio,
    this.sellUnitPrice1,
    this.sellUnitPrice2,
    this.sellUnitPrice3,
    this.sellUnitPrice4,
    this.sellUnitPrice5,
    this.sellUnitPrice6,
    this.deliverCost,
    this.articleStyle,
    this.supplCode,
    this.vatType,
    this.vatRateCode,
    this.qtyOnHand,
    this.stockFg,
    this.allowSaleOverStock,
    this.mbDiscMethod,
    this.mbDiscPs,
    this.sellUnitPriceNo,
    this.mbPriceFg,
  });

  int id;
  String articleCode;
  String skuCode;
  String pluCode;
  String pluIntCode;
  String pluDesc;
  String pluShortDesc;
  String styleId;
  String colorId;
  String sizeId;
  String tasteId;
  String matTypeId;
  String sellUnit;
  double sellUnitRatio;
  double sellUnitPrice1;
  double sellUnitPrice2;
  double sellUnitPrice3;
  double sellUnitPrice4;
  double sellUnitPrice5;
  double sellUnitPrice6;
  double deliverCost;
  String articleStyle;
  String supplCode;
  String vatType;
  String vatRateCode;
  double qtyOnHand;
  int stockFg;
  int allowSaleOverStock;
  int mbDiscMethod;
  double mbDiscPs;
  int sellUnitPriceNo;
  int mbPriceFg;

  factory CsPlu.fromJson(Map<String, dynamic> json) => CsPlu(
        id: json["id"],
        articleCode: json["articleCode"],
        skuCode: json["skuCode"],
        pluCode: json["pluCode"],
        pluIntCode: json["pluIntCode"],
        pluDesc: json["pluDesc"],
        pluShortDesc: json["pluShortDesc"],
        styleId: json["styleId"],
        colorId: json["colorId"],
        sizeId: json["sizeId"],
        tasteId: json["tasteId"],
        matTypeId: json["matTypeId"],
        sellUnit: json["sellUnit"],
        sellUnitRatio: json["sellUnitRatio"].toDouble(),
        sellUnitPrice1: json["sellUnitPrice1"].toDouble(),
        sellUnitPrice2: json["sellUnitPrice2"].toDouble(),
        sellUnitPrice3: json["sellUnitPrice3"].toDouble(),
        sellUnitPrice4: json["sellUnitPrice4"].toDouble(),
        sellUnitPrice5: json["sellUnitPrice5"].toDouble(),
        sellUnitPrice6: json["sellUnitPrice6"].toDouble(),
        deliverCost: json["deliverCost"].toDouble(),
        articleStyle: json["articleStyle"],
        supplCode: json["supplCode"],
        vatType: json["vatType"],
        vatRateCode: json["vatRateCode"],
        qtyOnHand: json["qtyOnHand"].toDouble(),
        stockFg: json["stockFg"],
        allowSaleOverStock: json["allowSaleOverStock"],
        mbDiscMethod: json["mbDiscMethod"],
        mbDiscPs: json["mbDiscPs"].toDouble(),
        sellUnitPriceNo: json["sellUnitPriceNo"],
        mbPriceFg: json["mbPriceFg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "articleCode": articleCode,
        "skuCode": skuCode,
        "pluCode": pluCode,
        "pluIntCode": pluIntCode,
        "pluDesc": pluDesc,
        "pluShortDesc": pluShortDesc,
        "styleId": styleId,
        "colorId": colorId,
        "sizeId": sizeId,
        "tasteId": tasteId,
        "matTypeId": matTypeId,
        "sellUnit": sellUnit,
        "sellUnitRatio": sellUnitRatio,
        "sellUnitPrice1": sellUnitPrice1,
        "sellUnitPrice2": sellUnitPrice2,
        "sellUnitPrice3": sellUnitPrice3,
        "sellUnitPrice4": sellUnitPrice4,
        "sellUnitPrice5": sellUnitPrice5,
        "sellUnitPrice6": sellUnitPrice6,
        "deliverCost": deliverCost,
        "articleStyle": articleStyle,
        "supplCode": supplCode,
        "vatType": vatType,
        "vatRateCode": vatRateCode,
        "qtyOnHand": qtyOnHand,
        "stockFg": stockFg,
        "allowSaleOverStock": allowSaleOverStock,
        "mbDiscMethod": mbDiscMethod,
        "mbDiscPs": mbDiscPs,
        "sellUnitPriceNo": sellUnitPriceNo,
        "mbPriceFg": mbPriceFg,
      };
}
