import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget rtsalheadtotal(double totalSales) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    Container(
      height: Palette.fullsalesheadcheight(),
      width: Palette.salesitemwidth() - Palette.stdbutton_width * 4.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          left: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: (totalSales > 999999)
            ? const EdgeInsets.fromLTRB(2, 22, 4, 5)
            : const EdgeInsets.fromLTRB(2, 12, 4, 5),
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
                    fontSize: (totalSales > 999999) ? 48 : 54,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    ),
  ]);
}
