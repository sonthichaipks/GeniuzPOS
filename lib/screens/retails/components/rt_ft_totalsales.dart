import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget footTotalSales(double totalSales, int itemcnt, double qty) {
  return Container(
    width: Palette.promdescwidth(),
    height: Palette.onelineheigth(),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          left: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        )),
    child: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Row(
          //  shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                      Palette.stdspacer_widht, 12, 0, 8),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ' +
                                cno.format(itemcnt) +
                                ' รายการ ' +
                                oCcy.format(qty) +
                                ' ชิ้น รวมเงิน',
                            style: TextStyle(
                              fontFamily: 'Leelawadee',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 1,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        right: 5,
        child: Row(
          //  shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 5, 0, 5),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: oCcy
                                .format(totalSales)
                                .padLeft(10, " ")
                                .padRight(11, " "),
                            style: TextStyle(
                              fontFamily: 'Leelawadee',
                              fontWeight: FontWeight.w500,
                              fontSize: (totalSales > 999999) ? 24 : 28,
                              color: Colors.black,
                              letterSpacing: 1,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ]),
  );
}
