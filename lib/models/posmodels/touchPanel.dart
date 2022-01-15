// To parse this JSON data, do
//
//     final touchPanel = touchPanelFromJson(jsonString);

import 'dart:convert';

List<TouchPanel> touchPanelFromJson(String str) =>
    List<TouchPanel>.from(json.decode(str).map((x) => TouchPanel.fromJson(x)));

String touchPanelToJson(List<TouchPanel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TouchPanel {
  TouchPanel({
    this.id,
    this.touchPanelType,
    this.posScreenType,
    this.touchPanelDesc,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.lastUpdate,
  });

  int id;
  String touchPanelType;
  String posScreenType;
  String touchPanelDesc;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime lastUpdate;

  factory TouchPanel.fromJson(Map<String, dynamic> json) => TouchPanel(
        id: json["id"],
        touchPanelType: json["touchPanelType"],
        posScreenType: json["posScreenType"],
        touchPanelDesc: json["touchPanelDesc"],
        createBy: json["createBy"],
        createDate: DateTime.parse(json["createDate"]),
        updateBy: json["updateBy"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "touchPanelType": touchPanelType,
        "posScreenType": posScreenType,
        "touchPanelDesc": touchPanelDesc,
        "createBy": createBy,
        "createDate": createDate.toIso8601String(),
        "updateBy": updateBy,
        "lastUpdate": lastUpdate.toIso8601String(),
      };
}
