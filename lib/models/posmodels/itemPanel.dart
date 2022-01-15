// To parse this JSON data, do
//
//     final itemPanel = itemPanelFromJson(jsonString);

import 'dart:convert';

List<ItemPanel> itemPanelFromJson(String str) =>
    List<ItemPanel>.from(json.decode(str).map((x) => ItemPanel.fromJson(x)));

String itemPanelToJson(List<ItemPanel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemPanel {
  ItemPanel({
    this.id,
    this.touchPanelType,
    this.groupButtonId,
    this.itemButtonId,
    this.itemButtonLabel,
    this.itemButtonImage,
    this.linkCode,
    this.linkCodeFg,
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
  int itemButtonId;
  String itemButtonLabel;
  String itemButtonImage;
  String linkCode;
  int linkCodeFg;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime lastUpdate;
  String bgColor;
  String txtColor;
  double txtFontSize;

  factory ItemPanel.fromJson(Map<String, dynamic> json) => ItemPanel(
        id: json["id"],
        touchPanelType: json["touchPanelType"],
        groupButtonId: json["groupButtonId"],
        itemButtonId: json["itemButtonId"],
        itemButtonLabel: json["itemButtonLabel"],
        itemButtonImage: json["itemButtonImage"],
        linkCode: json["linkCode"],
        linkCodeFg: json["linkCodeFg"],
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
        "itemButtonId": itemButtonId,
        "itemButtonLabel": itemButtonLabel,
        "itemButtonImage": itemButtonImage,
        "linkCode": linkCode,
        "linkCodeFg": linkCodeFg,
        "createBy": createBy,
        "createDate": createDate.toIso8601String(),
        "updateBy": updateBy,
        "lastUpdate": lastUpdate.toIso8601String(),
        "bgColor": bgColor,
        "txtColor": txtColor,
        "txtFontSize": txtFontSize,
      };
}
