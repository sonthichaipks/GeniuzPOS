import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PadButton {
  final String label;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final int kybTBLR;
  final Color btnColor;
  final double btnXwid;
  final double btnFSize;
  final bool isViewed;
  final TextEditingController txtPlu;

  const PadButton({
    @required this.label,
    this.imageUrl = "",
    this.cmdCode = "",
    this.kybCode = "",
    this.kybTBLR = 1,
    this.btnColor,
    this.btnXwid,
    this.btnFSize = 14,
    this.isViewed = false,
    this.txtPlu,
  });
}
