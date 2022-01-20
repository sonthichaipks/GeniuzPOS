import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget posAcmTitle() {
  return Row(
    children: [
      Container(
        width: Palette.stdbutton_width * 7,
        height: 30,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 386,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                  child: Spacer()),
            ),
            Positioned(
              top: 0,
              left: 273,
              child: Container(
                  width: 273,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                  child: Spacer()),
            ),
            Positioned(
                top: 4,
                left: 60,
                child: Text(
                  Palette.posctrl_title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  ),
                )),
            Positioned(
              top: 4,
              left: 360,
              child: Text(Palette.posacmf111,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
