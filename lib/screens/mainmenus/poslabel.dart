import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget poslabel(BuildContext context, int mainmenu) {
  return Column(children: [
    Container(
      height: Palette.fullsalesheadcheight() * 2,
      width: Palette.stdbutton_width * 12,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.transparent),
          left: BorderSide(width: 1.0, color: Colors.transparent),
          right: BorderSide(width: 1.0, color: Colors.transparent),
          bottom: BorderSide(width: 1.0, color: Colors.transparent),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(112, 30, 8, 8),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                    text: Palette.sysname_label,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w500,
                      fontSize: 55,
                      height: 0.8,
                      letterSpacing: 0.05,
                      color: Palette.facebookbluee,
                    )),
                TextSpan(
                    text: Palette.subsysname_label + "\r\n",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w500,
                      fontSize: 55,
                      height: 0.8,
                      letterSpacing: 0.05,
                      color: Colors.blueAccent,
                    )),
                TextSpan(
                    text: (mainmenu == 0)
                        ? Palette.sysmenu_label
                        : Palette.sysmenu1_label,
                    style: TextStyle(
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      height: 2,
                      letterSpacing: 0.1,
                      color: Colors.blue,
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  ]);
}
