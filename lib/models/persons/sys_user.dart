// To parse this JSON data, do
//
//     final sysUser = sysUserFromJson(jsonString);

import 'dart:convert';

List<SysUser> sysUserFromJson(String str) =>
    List<SysUser>.from(json.decode(str).map((x) => SysUser.fromJson(x)));

String sysUserToJson(List<SysUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SysUser {
  SysUser({
    this.fCodeUser,
    this.fNameUser,
    this.fPassword,
    this.fLevel,
    this.fGldeptCode,
    this.fSecGroup,
    this.fUserCreate,
    this.fUserCreateDate,
    this.fUserCreateTime,
    this.fUserUpdate,
    this.fUserUpdateDate,
    this.fUserUpdateTime,
  });

  String fCodeUser;
  String fNameUser;
  String fPassword;
  int fLevel;
  String fGldeptCode;
  String fSecGroup;
  String fUserCreate;
  DateTime fUserCreateDate;
  String fUserCreateTime;
  DateTime fUserUpdate;
  DateTime fUserUpdateDate;
  String fUserUpdateTime;

  factory SysUser.fromJson(Map<String, dynamic> json) => SysUser(
        fCodeUser: json["fCodeUser"],
        fNameUser: json["fNameUser"],
        fPassword: json["fPassword"],
        fLevel: json["fLevel"],
        fGldeptCode: json["fGldeptCode"],
        fSecGroup: json["fSecGroup"],
        fUserCreate: json["fUserCreate"],
        fUserCreateDate: DateTime.parse(json["fUserCreateDate"]),
        fUserCreateTime: json["fUserCreateTime"],
        fUserUpdate: DateTime.parse(json["fUserUpdate"]),
        fUserUpdateDate: DateTime.parse(json["fUserUpdateDate"]),
        fUserUpdateTime: json["fUserUpdateTime"],
      );

  Map<String, dynamic> toJson() => {
        "fCodeUser": fCodeUser,
        "fNameUser": fNameUser,
        "fPassword": fPassword,
        "fLevel": fLevel,
        "fGldeptCode": fGldeptCode,
        "fSecGroup": fSecGroup,
        "fUserCreate": fUserCreate,
        "fUserCreateDate": fUserCreateDate.toIso8601String(),
        "fUserCreateTime": fUserCreateTime,
        "fUserUpdate":
            "${fUserUpdate.year.toString().padLeft(4, '0')}-${fUserUpdate.month.toString().padLeft(2, '0')}-${fUserUpdate.day.toString().padLeft(2, '0')}",
        "fUserUpdateDate": fUserUpdateDate.toIso8601String(),
        "fUserUpdateTime": fUserUpdateTime,
      };

  Map<String, dynamic> toMap() {
    return {
      "fCodeUser": fCodeUser,
      "fNameUser": fNameUser,
      "fPassword": fPassword,
      "fLevel": fLevel,
      "fGldeptCode": fGldeptCode,
      "fSecGroup": fSecGroup,
      "fUserCreate": fUserCreate,
      "fUserCreateDate": fUserCreateDate.toIso8601String(),
      "fUserCreateTime": fUserCreateTime,
      "fUserUpdate": fUserUpdate,
      "fUserUpdateDate": fUserUpdateDate.toIso8601String(),
      "fUserUpdateTime": fUserUpdateTime,
    };
  }

  SysUser.fromMap(dynamic obj) {
    this.fCodeUser = obj["fCodeUser"];
    this.fNameUser = obj["fNameUser"];
    this.fPassword = obj["fPassword"];
    this.fLevel = obj["fLevel"];
    this.fGldeptCode = obj["fGldeptCode"];
    this.fSecGroup = obj["fSecGroup"];
    this.fUserCreate = obj["fUserCreate"];
    this.fUserCreateDate = DateTime.parse(obj["fUserCreateDate"]);
    this.fUserCreateTime = obj["fUserCreateTime"];
    this.fUserUpdate = obj["fUserUpdate"];
    this.fUserUpdateDate = DateTime.parse(obj["fUserUpdateDate"]);
    this.fUserUpdateTime = obj["fUserUpdateTime"];
  }
}
