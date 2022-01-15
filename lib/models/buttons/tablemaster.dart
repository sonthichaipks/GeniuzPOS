import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TableAndPostions {
  final String zoneno;
  final String tableno;
  final String label;
  final int seatcount;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final int kybTBLR;
  final Color btnColor;
  final double btnPosXStart;
  final double btnPosYStart;
  final double btnXwid;
  final double btnYheight;
  final double btnFSize;
  final bool isViewed;

  const TableAndPostions({
    @required this.zoneno,
    @required this.tableno,
    @required this.label,
    this.seatcount = 4,
    this.imageUrl = "",
    this.cmdCode = "",
    this.kybCode = "",
    this.kybTBLR = 1,
    this.btnColor,
    this.btnPosXStart,
    this.btnPosYStart,
    this.btnXwid,
    this.btnYheight,
    this.btnFSize = 14,
    this.isViewed = false,
  });
}
