import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CusIcon {
  final String label;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final Color btnColor;
  final double btnXwid;
  final double btnFSize;
  final bool isViewed;

  const CusIcon({
    @required this.label,
    this.imageUrl = "",
    this.cmdCode = "",
    this.kybCode = "",
    this.btnColor,
    this.btnXwid,
    this.btnFSize = 14,
    this.isViewed = false,
  });
}
