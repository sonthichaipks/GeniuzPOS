// To parse this JSON data, do
//
//     final getPosTranDt = getPosTranDtFromJson(jsonString);

import 'dart:convert';

List<GetPosTranDt> getPosTranDtFromJson(String str) => List<GetPosTranDt>.from(
    json.decode(str).map((x) => GetPosTranDt.fromJson(x)));

String getPosTranDtToJson(List<GetPosTranDt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPosTranDt {
  GetPosTranDt({
    this.id,
    this.docNo,
    this.lineItemNo,
    this.lineItemType,
    this.refLineItemNo,
    this.pluCode,
    this.qty,
    this.serialNo,
    this.unitPrice,
    this.exPrice,
    this.discPc,
    this.discamt,
    this.discCouponType,
    this.discCouponNo,
    this.promoId,
    this.chargePc,
    this.chargeAmt,
    this.itemVatType,
    this.itemPromoFg,
    this.itemPromoId,
    this.itemDiscount,
    this.itemCharge,
    this.itemNetExprice,
    this.allocatedBillDiscount,
    this.itemNetSales,
    this.itemVatRate,
    this.itemVat,
    this.itemDesc,
    this.qtyRefund,
  });

  int id;
  String docNo;
  int lineItemNo;
  String lineItemType;
  int refLineItemNo;
  String pluCode;
  double qty;
  String serialNo;
  double unitPrice;
  double exPrice;
  double discPc;
  double discamt;
  String discCouponType;
  String discCouponNo;
  String promoId;
  double chargePc;
  double chargeAmt;
  String itemVatType;
  int itemPromoFg;
  String itemPromoId;
  double itemDiscount;
  double itemCharge;
  double itemNetExprice;
  double allocatedBillDiscount;
  double itemNetSales;
  double itemVatRate;
  double itemVat;
  String itemDesc;
  double qtyRefund;

  factory GetPosTranDt.fromJson(Map<String, dynamic> json) => GetPosTranDt(
        id: json["id"],
        docNo: json["docNo"],
        lineItemNo: json["lineItemNo"],
        lineItemType: json["lineItemType"],
        refLineItemNo: json["refLineItemNo"],
        pluCode: json["pluCode"],
        qty: json["qty"].toDouble(),
        serialNo: json["serialNo"],
        unitPrice: json["unitPrice"].toDouble(),
        exPrice: json["exPrice"].toDouble(),
        discPc: json["discPc"].toDouble(),
        discamt: json["discamt"].toDouble(),
        discCouponType: json["discCouponType"],
        discCouponNo: json["discCouponNo"],
        promoId: json["promoId"],
        chargePc: json["chargePc"].toDouble(),
        chargeAmt: json["chargeAmt"].toDouble(),
        itemVatType: json["itemVatType"],
        itemPromoFg: json["itemPromoFg"],
        itemPromoId: json["itemPromoId"],
        itemDiscount: json["itemDiscount"].toDouble(),
        itemCharge: json["itemCharge"].toDouble(),
        itemNetExprice: json["itemNetExprice"].toDouble(),
        allocatedBillDiscount: json["allocatedBillDiscount"].toDouble(),
        itemNetSales: json["itemNetSales"].toDouble(),
        itemVatRate: json["itemVatRate"].toDouble(),
        itemVat: json["itemVat"].toDouble(),
        itemDesc: json["itemDesc"],
        qtyRefund: json["qtyRefund"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "docNo": docNo,
        "lineItemNo": lineItemNo,
        "lineItemType": lineItemType,
        "refLineItemNo": refLineItemNo,
        "pluCode": pluCode,
        "qty": qty,
        "serialNo": serialNo,
        "unitPrice": unitPrice,
        "exPrice": exPrice,
        "discPc": discPc,
        "discamt": discamt,
        "discCouponType": discCouponType,
        "discCouponNo": discCouponNo,
        "promoId": promoId,
        "chargePc": chargePc,
        "chargeAmt": chargeAmt,
        "itemVatType": itemVatType,
        "itemPromoFg": itemPromoFg,
        "itemPromoId": itemPromoId,
        "itemDiscount": itemDiscount,
        "itemCharge": itemCharge,
        "itemNetExprice": itemNetExprice,
        "allocatedBillDiscount": allocatedBillDiscount,
        "itemNetSales": itemNetSales,
        "itemVatRate": itemVatRate,
        "itemVat": itemVat,
        "itemDesc": itemDesc,
        "qtyRefund": qtyRefund,
      };
}
