// To parse this JSON data, do
//
//     final PosShiftLogin = PosShiftLoginFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';

List<PosShiftLogin> posShiftLoginFromJson(String str) =>
    List<PosShiftLogin>.from(
        json.decode(str).map((x) => PosShiftLogin.fromJson(x)));

// List<PosShiftLogin> posShiftLoginFromJson(String str) =>
//     List<PosShiftLogin>.from(
//         json.decode(str).map((x) => PosShiftLogin.fromJson(x)));

String posShiftLoginToJson(List<PosShiftLogin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PosShiftLogin {
  PosShiftLogin({
    this.id,
    this.cashierId,
    this.cashierName,
    this.cashierPassword,
    this.cashierLevel,
    this.shopId,
    this.cashierPosFg,
    //  this.singInDate,
    // this.singInTime,
    // this.singOutDate,
    //  this.singOutTime,
    this.shiftStatus,
    this.posId,
    this.startReceiptNo,
    this.endReceiptNo,
    this.startRefundNo,
    this.endRefundNo,
    this.begCash,
    this.cashIn,
    this.cashOut,
    this.cashSales,
    this.roundReceive,
    this.cashBalance,
    this.grossAmt,
    this.deiscount,
    this.netSales,
    this.charge,
    this.recvByCash,
    this.recvByCoupon,
    this.recvByCreditCd,
    this.recvByDebitCd,
    this.recvByPoint,
    this.recvByCashCd,
    this.recvByOthers,
    this.countVoid,
    this.countCancel,
    this.countOpenDrawer,
    this.countCashIn,
    this.countCashOut,
    this.countRefund,
    this.totalVoidAmt,
    this.totalCashInAmt,
    this.totalCashOutamt,
    this.totalRefundAmt,
    this.posshiftID,
    this.promptPayLink,
    this.qrCodeAccount,
  });
  int id;
  String cashierId;
  String cashierName;
  String cashierPassword;
  int cashierLevel;
  String shopId;
  int cashierPosFg;
  //DateTime singInDate;
  //DateTime singInTime;
  // DateTime singOutDate;
  // DateTime singOutTime;
  String shiftStatus;
  String posId;
  String startReceiptNo;
  String endReceiptNo;
  String startRefundNo;
  String endRefundNo;

  double begCash;
  double cashIn;
  double cashOut;
  double cashSales;
  double roundReceive;
  double cashBalance;
  double grossAmt;
  double deiscount;
  double netSales;
  double charge;
  double recvByCash;
  double recvByCoupon;
  double recvByCreditCd;
  double recvByDebitCd;
  double recvByPoint;
  double recvByCashCd;
  double recvByOthers;

  int countVoid;
  int countCancel;
  int countOpenDrawer;
  int countCashIn;
  int countCashOut;
  int countRefund;

  double totalVoidAmt;
  double totalCashInAmt;
  double totalCashOutamt;
  double totalRefundAmt;
  int posshiftID;
  String promptPayLink;
  String qrCodeAccount;

  factory PosShiftLogin.fromJson(Map<String, dynamic> json) {
    PosShiftLogin result;
    try {
      // "[{"id":1,"cashierId":"999","cashierName":"Non-Cashier","cashierPassword":"999",
      // "cashierLevel":9,"ShopId":"GS001","CashierPosFg":1,"shiftStatus":"C","posId":"00123","startReceiptNo":"1001230921000001",
      // "endReceiptNo":"1001230921000001","startRefundNo":"2001230921000001","endRefundNo":"2001230921000001",
      // "begCash":1000.00,"cashIn":0.00,"cashOut":0.00,"cashSales":0.00,"roundReceive":0.00,
      // "cashBalance":100.00,"grossAmt":0.00,"deiscount":0.00,"netSales":0.00,"charge":0.00,
      // "recvByCash":0.00,"recvByCoupon":0.00,"recvByCreditCd":0.00,"recvByDebitCd":0.00,
      // "recvByPoint":0.00,"recvByCashCd":0.00,"recvByOthers":0.00,"countVoid":0,"countCancel":0,
      // "countOpenDrawer":0,"countCashIn":0,"countCashOut":0,"countRefund":0,"totalVoidAmt":0.00,
      // "totalCashInAmt":0.00,"totalCashOutamt":0.00,"totalRefundAmt":0.00}]"
      result = PosShiftLogin(
        id: json["id"],
        cashierId: json["cashierId"],
        cashierName: json["cashierName"],
        cashierPassword: json["cashierPassword"],
        cashierLevel: json["cashierLevel"],
        shopId: json["shopId"],
        cashierPosFg: json["cashierPosFg"],
        //   singInDate: DateTime.parse(json["SingInDate"]),
        //   singInTime: DateTime.parse(json["SingInTime"]),
        //   singOutDate: DateTime.parse(json["SingOutDate"]),
        //   singOutTime: DateTime.parse(json["SingOutTime"]),
        shiftStatus: json["shiftStatus"],
        posId: json["posId"],
        startReceiptNo: json["startReceiptNo"],
        endReceiptNo: json["endReceiptNo"],
        startRefundNo: json["startRefundNo"],
        endRefundNo: json["endRefundNo"],

        begCash: json["begCash"] * 1.0,
        cashIn: json["cashIn"] * 1.0,
        cashOut: json["cashOut"] * 1.0,
        cashSales: json["cashSales"] * 1.0,
        roundReceive: json["roundReceive"] * 1.0,
        cashBalance: json["cashBalance"] * 1.0,
        grossAmt: json["grossAmt"] * 1.0,
        deiscount: json["deiscount"] * 1.0,
        netSales: json["netSales"] * 1.0,

        charge: json["charge"],
        recvByCash: json["recvByCash"],
        recvByCoupon: json["recvByCoupon"],
        recvByCreditCd: json["recvByCreditCd"],
        recvByDebitCd: json["recvByDebitCd"],
        recvByPoint: json["recvByPoint"],
        recvByCashCd: json["recvByCashCd"],
        recvByOthers: json["recvByOthers"],

        countVoid: json["countVoid"],
        countCancel: json["countCancel"],
        countOpenDrawer: json["countOpenDrawer"],
        countCashIn: json["countCashIn"],

        countCashOut: json["countCashOut"],
        countRefund: json["countRefund"],

        totalVoidAmt: json["totalVoidAmt"] * 1.0,
        totalCashInAmt: json["totalCashInAmt"] * 1.0,
        totalCashOutamt: json["totalCashOutamt"] * 1.0,
        totalRefundAmt: json["totalRefundAmt"] * 1.0,
        posshiftID: json["posshiftID"],

        promptPayLink: json["promptPayLink"],
        qrCodeAccount: json["qrCodeAccount"],
      );
      return result;
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "CashierId": cashierId,
        "CashierName": cashierName,
        "CashierPassword": cashierPassword,
        "CashierLevel": cashierLevel,
        "ShopId": shopId,
        "CashierPosFg": cashierPosFg,
        //   "SingInDate":
        //       "${singInDate.year.toString().padLeft(4, '0')}-${singInDate.month.toString().padLeft(2, '0')}-${singInDate.day.toString().padLeft(2, '0')}",
        //   "SingInTime": singInTime.toIso8601String(),
        //   "SingOutDate":
        //        "${singOutDate.year.toString().padLeft(4, '0')}-${singOutDate.month.toString().padLeft(2, '0')}-${singOutDate.day.toString().padLeft(2, '0')}",
        //   "SingOutTime": singOutTime.toIso8601String(),
        "ShiftStatus": shiftStatus,
        "PosID": posId,
        "StartReceiptNo": startReceiptNo,
        "EndReceiptNo": endReceiptNo,
        "StartRefundNo": startRefundNo,
        "EndRefundNo": endRefundNo,
        "BegCash": begCash,
        "CashIn": cashIn,
        "CashOut": cashOut,
        "CashSales": cashSales,
        "RoundReceive": roundReceive,
        "CashBalance": cashBalance,
        "GrossAmt": grossAmt,
        "Deiscount": deiscount,
        "NetSales": netSales,
        "Charge": charge,
        "RecvByCash": recvByCash,
        "RecvByCoupon": recvByCoupon,
        "RecvByCreditCd": recvByCreditCd,
        "RecvByDebitCd": recvByDebitCd,
        "RecvByPoint": recvByPoint,
        "RecvByCashCd": recvByCashCd,
        "RecvByOthers": recvByOthers,
        "CountVoid": countVoid,
        "CountCancel": countCancel,
        "CountOpenDrawer": countOpenDrawer,
        "CountCashIn": countCashIn,
        "CountCashOut": countCashOut,
        "CountRefund": countRefund,
        "TotalVoidAmt": totalVoidAmt,
        "TotalCashInAmt": totalCashInAmt,
        "TotalCashOutamt": totalCashOutamt,
        "TotalRefundAmt": totalRefundAmt,
        "posshiftID": posshiftID,

        "promptPayLink": promptPayLink,
        "qrCodeAccount": qrCodeAccount,
      };
}
