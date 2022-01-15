// To parse this JSON data, do
//
//     final psMember = psMemberFromJson(jsonString);

import 'dart:convert';

List<PsMember> psMemberFromJson(String str) =>
    List<PsMember>.from(json.decode(str).map((x) => PsMember.fromJson(x)));

String psMemberToJson(List<PsMember> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsMember {
  PsMember({
    this.id,
    this.mbId,
    this.mbType,
    this.mbNameT,
    this.mbNameE,
    this.mbAddress,
    this.mbProvince,
    this.mbAmphur,
    this.mbTumbol,
    this.mbZipCode,
    this.mbLineAddr1,
    this.mbLineAddr2,
    this.mbLineAddr3,
    this.mbPid,
    this.mbTelNo,
    this.mbEmail,
    this.mbGender,
    this.mbNation,
    this.mbRace,
    this.mbOccupation,
    this.mbBirthDay,
    this.mbCardType,
    this.mbApplyDate,
    this.mbExpireDate,
    this.mbCardStatus,
    this.mbPhoto,
    this.mbAccumPoint,
    this.mbNearlyExpirePoint,
    this.mbExpirePointDate,
    this.memberTypeDesc,
    this.mbDiscPs,
    this.sellUnitPriceNo,
    this.mbPriceFg,
  });

  int id;
  String mbId;
  String mbType;
  String mbNameT;
  String mbNameE;
  String mbAddress;
  String mbProvince;
  String mbAmphur;
  String mbTumbol;
  String mbZipCode;
  String mbLineAddr1;
  String mbLineAddr2;
  String mbLineAddr3;
  String mbPid;
  String mbTelNo;
  String mbEmail;
  String mbGender;
  String mbNation;
  String mbRace;
  String mbOccupation;
  DateTime mbBirthDay;
  String mbCardType;
  DateTime mbApplyDate;
  DateTime mbExpireDate;
  int mbCardStatus;
  String mbPhoto;
  double mbAccumPoint;
  double mbNearlyExpirePoint;
  DateTime mbExpirePointDate;
  String memberTypeDesc;
  double mbDiscPs;
  int sellUnitPriceNo;
  int mbPriceFg;

  factory PsMember.fromJson(Map<String, dynamic> json) => PsMember(
        id: json["id"],
        mbId: json["mbId"],
        mbType: json["mbType"],
        mbNameT: json["mbNameT"],
        mbNameE: json["mbNameE"],
        mbAddress: json["mbAddress"],
        mbProvince: json["mbProvince"],
        mbAmphur: json["mbAmphur"],
        mbTumbol: json["mbTumbol"],
        mbZipCode: json["mbZipCode"],
        mbLineAddr1: json["mbLineAddr1"],
        mbLineAddr2: json["mbLineAddr2"],
        mbLineAddr3: json["mbLineAddr3"],
        mbPid: json["mbPid"],
        mbTelNo: json["mbTelNo"],
        mbEmail: json["mbEmail"],
        mbGender: json["mbGender"],
        mbNation: json["mbNation"],
        mbRace: json["mbRace"],
        mbOccupation: json["mbOccupation"],
        mbBirthDay: DateTime.parse(json["mbBirthDay"]),
        mbCardType: json["mbCardType"],
        mbApplyDate: DateTime.parse(json["mbApplyDate"]),
        mbExpireDate: DateTime.parse(json["mbExpireDate"]),
        mbCardStatus: json["mbCardStatus"],
        mbPhoto: json["mbPhoto"],
        mbAccumPoint: json["mbAccumPoint"].toDouble(),
        mbNearlyExpirePoint: json["mbNearlyExpirePoint"].toDouble(),
        mbExpirePointDate: DateTime.parse(json["mbExpirePointDate"]),
        memberTypeDesc: json["memberTypeDesc"],
        mbDiscPs: json["mbDiscPs"].toDouble(),
        sellUnitPriceNo: json["sellUnitPriceNo"],
        mbPriceFg: json["mbPriceFg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mbId": mbId,
        "mbType": mbType,
        "mbNameT": mbNameT,
        "mbNameE": mbNameE,
        "mbAddress": mbAddress,
        "mbProvince": mbProvince,
        "mbAmphur": mbAmphur,
        "mbTumbol": mbTumbol,
        "mbZipCode": mbZipCode,
        "mbLineAddr1": mbLineAddr1,
        "mbLineAddr2": mbLineAddr2,
        "mbLineAddr3": mbLineAddr3,
        "mbPid": mbPid,
        "mbTelNo": mbTelNo,
        "mbEmail": mbEmail,
        "mbGender": mbGender,
        "mbNation": mbNation,
        "mbRace": mbRace,
        "mbOccupation": mbOccupation,
        "mbBirthDay": mbBirthDay.toIso8601String(),
        "mbCardType": mbCardType,
        "mbApplyDate": mbApplyDate.toIso8601String(),
        "mbExpireDate": mbExpireDate.toIso8601String(),
        "mbCardStatus": mbCardStatus,
        "mbPhoto": mbPhoto,
        "mbAccumPoint": mbAccumPoint,
        "mbNearlyExpirePoint": mbNearlyExpirePoint,
        "mbExpirePointDate": mbExpirePointDate.toIso8601String(),
        "memberTypeDesc": memberTypeDesc,
        "mbDiscPs": mbDiscPs,
        "sellUnitPriceNo": sellUnitPriceNo,
        "mbPriceFg": mbPriceFg,
      };
}
