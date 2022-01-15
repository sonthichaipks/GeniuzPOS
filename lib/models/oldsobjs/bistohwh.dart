// To parse this JSON data, do
//
//     final bistohwh = bistohwhFromJson(jsonString);

import 'dart:convert';

List<Bistohwh> bistohwhFromJson(String str) =>
    List<Bistohwh>.from(json.decode(str).map((x) => Bistohwh.fromJson(x)));

String bistohwhToJson(List<Bistohwh> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bistohwh {
  Bistohwh({
    this.id,
    this.trprodcode,
    this.trprodname,
    this.trpgcode,
    this.trpgname,
    this.plu,
    this.trunit,
    this.stock,
    this.unpostInqty,
    this.unpostOutQty,
    this.rtonhand,
    this.wh1,
    this.whName,
  });

  int id;
  String trprodcode;
  String trprodname;
  String trpgcode;
  String trpgname;
  String plu;
  String trunit;
  double stock;
  double unpostInqty;
  double unpostOutQty;
  double rtonhand;
  String wh1;
  String whName;

  factory Bistohwh.fromJson(Map<String, dynamic> json) => Bistohwh(
        id: json["id"],
        trprodcode: json["trprodcode"],
        trprodname: json["trprodname"],
        trpgcode: json["trpgcode"],
        trpgname: json["trpgname"],
        plu: json["plu"],
        trunit: json["trunit"],
        stock: json["stock"].toDouble(),
        unpostInqty: json["unpostInqty"].toDouble(),
        unpostOutQty: json["unpostOutQty"].toDouble(),
        rtonhand: json["rtonhand"].toDouble(),
        wh1: json["wh1"],
        whName: json["whName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trprodcode": trprodcode,
        "trprodname": trprodname,
        "trpgcode": trpgcode,
        "trpgname": trpgname,
        "plu": plu,
        "trunit": trunit,
        "stock": stock,
        "unpostInqty": unpostInqty,
        "unpostOutQty": unpostOutQty,
        "rtonhand": rtonhand,
        "wh1": wh1,
        "whName": whName,
      };

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "trprodcode": trprodcode,
      "trprodname": trprodname,
      "trpgcode": trpgcode,
      "trpgname": trpgname,
      "plu": plu,
      "trunit": trunit,
      "stock": stock,
      "unpostInqty": unpostInqty,
      "unpostOutQty": unpostOutQty,
      "rtonhand": rtonhand,
      "wh1": wh1,
      "whName": whName,
    };
  }

  Bistohwh.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.trprodcode = obj['trprodcode'];
    this.trprodname = obj['trprodname'];
    this.trpgcode = obj['trpgcode'];
    this.trpgname = obj['trpgname'];
    this.plu = obj['plu'];
    this.trunit = obj['trunit'];
    this.stock = obj['stock'];
    this.unpostInqty = obj['unpostInqty'];
    this.unpostOutQty = obj['unpostOutQty'];
    this.rtonhand = obj['rtonhand'];
    this.wh1 = obj['wh1'];
    this.whName = obj['whName'];
  }
}
