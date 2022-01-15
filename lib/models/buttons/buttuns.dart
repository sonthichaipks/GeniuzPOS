import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PosButton {
  final String label;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final Color btnColor;
  final double btnXwid;
  final double btnFSize;
  final bool isViewed;
  final TextEditingController txtPlu;

  const PosButton({
    @required this.label,
    this.imageUrl = "",
    this.cmdCode = "",
    this.kybCode = "",
    this.btnColor,
    this.btnXwid,
    this.btnFSize = 14,
    this.isViewed = false,
    this.txtPlu,
  });
}

class PosButtonX {
  PosButtonX(
      {this.label,
      this.imageUrl,
      this.cmdCode,
      this.kybCode,
      this.btnColor,
      this.btnXwid,
      this.btnFSize,
      this.txtColor,
      this.replresentOf,
      this.id,
      this.panelId,
      this.groupId,
      this.itemId});
  final String label;
  final String imageUrl;
  final String cmdCode;
  final String kybCode;
  final Color btnColor;
  final double btnXwid;
  final double btnFSize;
  final Color txtColor;
  final int replresentOf;
  final int id;
  final String panelId;
  final int groupId;
  final int itemId;
}
