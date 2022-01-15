import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget fssalheadtotal(double totalSales) {
  return Container(
    height: Palette.fullsalesheadcheight() - 8,
    width: Palette.stdbutton_width * 7.27,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.grey),
        left: BorderSide(width: 1.0, color: Colors.white),
        right: BorderSide(width: 1.0, color: Colors.grey),
        bottom: BorderSide(width: 1.0, color: Colors.grey),
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 10,
          bottom: 0,
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                    text: oCcy.format(totalSales),
                    style: TextStyle(
                      fontFamily: 'Leelawadee',
                      fontWeight: FontWeight.w500,
                      fontSize: 64,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
