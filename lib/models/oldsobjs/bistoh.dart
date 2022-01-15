// To parse this JSON data, do
//
//     final bistoh = bistohFromJson(jsonString);

import 'dart:convert';

List<Bistoh> bistohFromJson(String str) =>
    List<Bistoh>.from(json.decode(str).map((x) => Bistoh.fromJson(x)));

String bistohToJson(List<Bistoh> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bistoh {
  Bistoh({
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

  factory Bistoh.fromJson(Map<String, dynamic> json) => Bistoh(
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
      );

  Bistoh.fromMap(dynamic obj) {
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
  }

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
      "rtonhand": rtonhand
    };
  }

  @override
  String toString() {
    return 'Bistoh{id: $id,trprodcode: $trprodcode,trprodname: $trprodname,trpgcode: $trpgcode, trpgname: $trpgname, plu: $plu, trunit: $trunit, stock: $stock, unpostInqty: $unpostInqty, unpostOutQty: $unpostOutQty, rtonhand: $rtonhand}';
    //'Bistoh{id: $id, transName: $transName, amount: $amount}';
  }
}
