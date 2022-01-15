import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget logoheadf1(BuildContext context) {
  return Row(children: [
    Container(
      height: Palette.fullsalesheadcheight(),
      width: Palette.stdbutton_width * 1.2,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.transparent),
          left: BorderSide(width: 1.0, color: Colors.transparent),
          right: BorderSide(width: 1.0, color: Colors.transparent),
          bottom: BorderSide(width: 1.0, color: Colors.transparent),
        ),
      ),
      child: Palette().showLogof1(context),
    )
  ]);
}
