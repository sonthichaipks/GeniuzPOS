import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PosHeadItem {
  final String label;
  final String inform;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final Color btnColor;
  final double btnXwid;
  final bool isViewed;

  const PosHeadItem({
    @required this.label,
    this.inform = "",
    this.imageUrl = "",
    this.cmdCode = "",
    this.kybCode = "",
    this.btnColor,
    this.btnXwid,
    this.isViewed = false,
  });
}
