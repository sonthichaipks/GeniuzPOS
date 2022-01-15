// To parse this JSON data, do
//
//     final groupPanel = groupPanelFromJson(jsonString);

import 'dart:convert';

List<GroupPanel> groupPanelFromJson(String str) =>
    List<GroupPanel>.from(json.decode(str).map((x) => GroupPanel.fromJson(x)));

String groupPanelToJson(List<GroupPanel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupPanel {
  GroupPanel({
    this.id,
    this.touchPanelType,
    this.groupButtonId,
    this.groupButtonLabel,
    this.groupButtonImage,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.lastUpdate,
    this.bgColor,
    this.txtColor,
    this.txtFontSize,
  });

  int id;
  String touchPanelType;
  int groupButtonId;
  String groupButtonLabel;
  String groupButtonImage;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime lastUpdate;
  String bgColor;
  String txtColor;
  double txtFontSize;

  factory GroupPanel.fromJson(Map<String, dynamic> json) => GroupPanel(
        id: json["id"],
        touchPanelType: json["touchPanelType"],
        groupButtonId: json["groupButtonId"],
        groupButtonLabel: json["groupButtonLabel"],
        groupButtonImage: json["groupButtonImage"],
        createBy: json["createBy"],
        createDate: DateTime.parse(json["createDate"]),
        updateBy: json["updateBy"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        bgColor: json["bgColor"],
        txtColor: json["txtColor"],
        txtFontSize: json["txtFontSize"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "touchPanelType": touchPanelType,
        "groupButtonId": groupButtonId,
        "groupButtonLabel": groupButtonLabel,
        "groupButtonImage": groupButtonImage,
        "createBy": createBy,
        "createDate": createDate.toIso8601String(),
        "updateBy": updateBy,
        "lastUpdate": lastUpdate.toIso8601String(),
        "bgColor": bgColor,
        "txtColor": txtColor,
        "txtFontSize": txtFontSize,
      };
}
