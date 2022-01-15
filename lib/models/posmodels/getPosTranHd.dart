// To parse this JSON data, do
//
//     final getPosTranHd = getPosTranHdFromJson(jsonString);

import 'dart:convert';

List<GetPosTranHd> getPosTranHdFromJson(String str) => List<GetPosTranHd>.from(
    json.decode(str).map((x) => GetPosTranHd.fromJson(x)));

String getPosTranHdToJson(List<GetPosTranHd> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPosTranHd {
  GetPosTranHd({
    this.id,
    this.docNo,
    this.docDate,
    this.docTime,
    this.refDocNo,
    this.posId,
    this.cashierId,
    this.mbId,
    this.salesmanId,
    this.salesVatType,
    this.grossSales,
    this.allItemDiscount,
    this.allItemCharge,
    this.billDiscount,
    this.netSales,
    this.billCharge,
    this.docAmt,
    this.vat,
    this.roundAdjust,
    this.netSalesNormal,
    this.netSalesPromo,
    this.netSalesExVat,
    this.netSalesNonVat,
    this.vatOfNetSales,
    this.vatOfCharge,
    this.receiveCash,
    this.receiveCreditCd,
    this.receiveDebitCd,
    this.receiveCoupon,
    this.receiveCashCd,
    this.receivePoint,
    this.receiveOthers,
  });

  int id;
  String docNo;
  DateTime docDate;
  DateTime docTime;
  String refDocNo;
  String posId;
  String cashierId;
  String mbId;
  String salesmanId;
  String salesVatType;
  double grossSales;
  double allItemDiscount;
  double allItemCharge;
  double billDiscount;
  double netSales;
  double billCharge;
  double docAmt;
  double vat;
  double roundAdjust;
  double netSalesNormal;
  double netSalesPromo;
  double netSalesExVat;
  double netSalesNonVat;
  double vatOfNetSales;
  double vatOfCharge;
  double receiveCash;
  double receiveCreditCd;
  double receiveDebitCd;
  double receiveCoupon;
  double receiveCashCd;
  double receivePoint;
  double receiveOthers;

  factory GetPosTranHd.fromJson(Map<String, dynamic> json) => GetPosTranHd(
        id: json["id"],
        docNo: json["docNo"],
        docDate: DateTime.parse(json["docDate"]),
        docTime: DateTime.parse(json["docTime"]),
        refDocNo: json["refDocNo"],
        posId: json["posId"],
        cashierId: json["cashierId"],
        mbId: json["mbId"],
        salesmanId: json["salesmanId"],
        salesVatType: json["salesVatType"],
        grossSales: json["grossSales"].toDouble(),
        allItemDiscount: json["allItemDiscount"].toDouble(),
        allItemCharge: json["allItemCharge"].toDouble(),
        billDiscount: json["billDiscount"].toDouble(),
        netSales: json["netSales"].toDouble(),
        billCharge: json["billCharge"].toDouble(),
        docAmt: json["docAmt"].toDouble(),
        vat: json["vat"].toDouble(),
        roundAdjust: json["roundAdjust"].toDouble(),
        netSalesNormal: json["netSalesNormal"].toDouble(),
        netSalesPromo: json["netSalesPromo"].toDouble(),
        netSalesExVat: json["netSalesExVat"].toDouble(),
        netSalesNonVat: json["netSalesNonVat"].toDouble(),
        vatOfNetSales: json["vatOfNetSales"].toDouble(),
        vatOfCharge: json["vatOfCharge"].toDouble(),
        receiveCash: json["receiveCash"].toDouble(),
        receiveCreditCd: json["receiveCreditCd"].toDouble(),
        receiveDebitCd: json["receiveDebitCd"].toDouble(),
        receiveCoupon: json["receiveCoupon"].toDouble(),
        receiveCashCd: json["receiveCashCd"].toDouble(),
        receivePoint: json["receivePoint"].toDouble(),
        receiveOthers: json["receiveOthers"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "docNo": docNo,
        "docDate": docDate.toIso8601String(),
        "docTime": docTime.toIso8601String(),
        "refDocNo": refDocNo,
        "posId": posId,
        "cashierId": cashierId,
        "mbId": mbId,
        "salesmanId": salesmanId,
        "salesVatType": salesVatType,
        "grossSales": grossSales,
        "allItemDiscount": allItemDiscount,
        "allItemCharge": allItemCharge,
        "billDiscount": billDiscount,
        "netSales": netSales,
        "billCharge": billCharge,
        "docAmt": docAmt,
        "vat": vat,
        "roundAdjust": roundAdjust,
        "netSalesNormal": netSalesNormal,
        "netSalesPromo": netSalesPromo,
        "netSalesExVat": netSalesExVat,
        "netSalesNonVat": netSalesNonVat,
        "vatOfNetSales": vatOfNetSales,
        "vatOfCharge": vatOfCharge,
        "receiveCash": receiveCash,
        "receiveCreditCd": receiveCreditCd,
        "receiveDebitCd": receiveDebitCd,
        "receiveCoupon": receiveCoupon,
        "receiveCashCd": receiveCashCd,
        "receivePoint": receivePoint,
        "receiveOthers": receiveOthers,
      };
}
