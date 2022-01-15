import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget posfrontftl3() {
  return Row(children: [
    Container(
      height: Palette.stdicon_height,
      width: Palette.stdbutton_width * 9,
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.transparent),
          left: BorderSide(width: 1.0, color: Colors.transparent),
          right: BorderSide(width: 1.0, color: Colors.transparent),
          bottom: BorderSide(width: 1.0, color: Colors.transparent),
        ),
      ),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: '', children: <TextSpan>[
            TextSpan(
                text: Palette.sysregisterd_label
                    .replaceAll('[COMPFULLNAME]', 'CITYSOFT INFOTECH CO.,LTD.'),
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 0.8,
                  letterSpacing: 0.05,
                  color: Colors.black,
                )),
          ])),
    )
  ]);
}
