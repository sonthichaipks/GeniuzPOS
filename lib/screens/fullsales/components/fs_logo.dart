import 'package:com_csith_geniuzpos/screens/nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget logohead(BuildContext context, int mode) {
  return Row(children: [
    GestureDetector(
      onPanUpdate: (details) {
        if (mode == 1) {
          if (details.delta.dx > 0) {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 4));
            Navigator.push(context, route);
          } else {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 3));
            Navigator.push(context, route);
          }
        }
      },
      child: Container(
        height: Palette.fullsalesheadcheight(),
        width: Palette.stdbutton_width * 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.white),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
        child: Palette().showLogo(),
      ),
    )
  ]);
}
