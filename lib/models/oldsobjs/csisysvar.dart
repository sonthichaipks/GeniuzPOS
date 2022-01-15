// To parse this JSON data, do
//
//     final csiSysvar = csiSysvarFromJson(jsonString);

import 'dart:convert';

List<CsiSysvar> csiSysvarFromJson(String str) =>
    List<CsiSysvar>.from(json.decode(str).map((x) => CsiSysvar.fromJson(x)));

String csiSysvarToJson(List<CsiSysvar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsiSysvar {
  CsiSysvar({
    this.id,
    this.syscode,
    this.detail,
    // this.running,
    this.lastupdate,
  });

  int id;
  String syscode;
  String detail;
  int running;
  DateTime lastupdate;

  factory CsiSysvar.fromJson(Map<String, dynamic> json) => CsiSysvar(
        id: json["id"],
        syscode: json["syscode"],
        detail: json["detail"],
        //   running: json["running"],
        //   lastupdate: DateTime.parse(json["lastupdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syscode": syscode,
        "detail": detail,
        "running": running,
        "lastupdate":
            "${lastupdate.year.toString().padLeft(4, '0')}-${lastupdate.month.toString().padLeft(2, '0')}-${lastupdate.day.toString().padLeft(2, '0')}",
      };

  CsiSysvar.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.syscode = obj['syscode'];
    this.detail = obj['detail'];
    this.running = obj['running'];
    this.lastupdate = obj[(lastupdate != null)
        ? "${lastupdate.year.toString().padLeft(4, '0')}-${lastupdate.month.toString().padLeft(2, '0')}-${lastupdate.day.toString().padLeft(2, '0')}"
        : "datetime()"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "syscode": syscode,
      "detail": detail,
      "running": running,
      "lastupdate":
          "${lastupdate.year.toString().padLeft(4, '0')}-${lastupdate.month.toString().padLeft(2, '0')}-${lastupdate.day.toString().padLeft(2, '0')}",
    };
  }

  @override
  String toString() {
    return 'CsiSysvar{id: $id,syscode: $syscode,detail: $detail,running: $running, lastupdate: $lastupdate}';
  }
}
