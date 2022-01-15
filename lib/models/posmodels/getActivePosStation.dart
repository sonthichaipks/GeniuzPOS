// To parse this JSON data, do
//
//     final psActivePosStation = psActivePosStationFromJson(jsonString);

import 'dart:convert';

List<PsActivePosStation> psActivePosStationFromJson(String str) =>
    List<PsActivePosStation>.from(
        json.decode(str).map((x) => PsActivePosStation.fromJson(x)));

String psActivePosStationToJson(List<PsActivePosStation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsActivePosStation {
  PsActivePosStation({
    this.id,
    this.posId,
    this.posPermitNo,
    this.shopId,
    this.branchName,
    this.whsId,
    this.lastReceiptRunNo,
    this.lastRefundRunNo,
    this.cashierPosFg,
    this.posScreenType,
    this.posTouchPanelId,
    this.maxCashInDrawer,
    this.autoChargeFg,
    this.autoChargeRate,
    this.mandatorySalesmanFg,
    this.mandatoryMemberFg,
    this.cashierId,
    this.shiftStatus,
    this.singInTime,
    this.nwType,
    this.nwIp,
    this.nwCommand,
    this.securityAuth,
    this.securityRef1,
    this.securityRef2,
  });

  int id;
  String posId;
  String posPermitNo;
  String shopId;
  String branchName;
  String whsId;
  int lastReceiptRunNo;
  int lastRefundRunNo;
  int cashierPosFg;
  String posScreenType;
  String posTouchPanelId;
  double maxCashInDrawer;
  int autoChargeFg;
  double autoChargeRate;
  int mandatorySalesmanFg;
  int mandatoryMemberFg;
  String cashierId;
  String shiftStatus;
  DateTime singInTime;
  int nwType;
  String nwIp;
  int nwCommand;
  int securityAuth;
  String securityRef1;
  String securityRef2;

  factory PsActivePosStation.fromJson(Map<String, dynamic> json) =>
      PsActivePosStation(
        id: json["id"],
        posId: json["posId"],
        posPermitNo: json["posPermitNo"],
        shopId: json["shopId"],
        branchName: json["branchName"],
        whsId: json["whsId"],
        lastReceiptRunNo: json["lastReceiptRunNo"],
        lastRefundRunNo: json["lastRefundRunNo"],
        cashierPosFg: json["cashierPosFg"],
        posScreenType: json["posScreenType"],
        posTouchPanelId: json["posTouchPanelId"],
        maxCashInDrawer: (json["maxCashInDrawer"] == null)
            ? 0.0
            : json["maxCashInDrawer"].toDouble(),
        autoChargeFg: json["autoChargeFg"],
        autoChargeRate: (json["autoChargeRate"] == null)
            ? 0.0
            : json["autoChargeRate"].toDouble(),
        mandatorySalesmanFg: json["mandatorySalesmanFg"],
        mandatoryMemberFg: json["mandatoryMemberFg"],
        cashierId: json["cashierId"],
        shiftStatus: json["shiftStatus"],
        singInTime: (json["singInTime"] == null)
            ? DateTime.now()
            : DateTime.parse(json["singInTime"]),
        nwType: json["nwType"],
        nwIp: json["nw_Ip"],
        nwCommand: json["nw_Command"],
        securityAuth: json["security_Auth"],
        securityRef1: json["security_Ref1"],
        securityRef2: json["security_Ref2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "posId": posId,
        "posPermitNo": posPermitNo,
        "shopId": shopId,
        "branchName": branchName,
        "whsId": whsId,
        "lastReceiptRunNo": lastReceiptRunNo,
        "lastRefundRunNo": lastRefundRunNo,
        "cashierPosFg": cashierPosFg,
        "posScreenType": posScreenType,
        "posTouchPanelId": posTouchPanelId,
        "maxCashInDrawer": maxCashInDrawer,
        "autoChargeFg": autoChargeFg,
        "autoChargeRate": autoChargeRate,
        "mandatorySalesmanFg": mandatorySalesmanFg,
        "mandatoryMemberFg": mandatoryMemberFg,
        "cashierId": cashierId,
        "shiftStatus": shiftStatus,
        "singInTime": singInTime.toIso8601String(),
        "nwType": nwType,
        "nw_Ip": nwIp,
        "nw_Command": nwCommand,
        "security_Auth": securityAuth,
        "security_Ref1": securityRef1,
        "security_Ref2": securityRef2,
      };
}
