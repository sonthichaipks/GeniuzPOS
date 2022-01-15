import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget txtInputline() {
  return Row(
    children: [
      Container(
        width: Palette.promdescwidth(),
        height: Palette.onelineheigth() * 0.7,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            )),
        child: Container(
          child: Row(
            //  shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                        Palette.stdspacer_widht, 8, 0, 8),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        children: <TextSpan>[
                          TextSpan(
                              text: 'ป้อนข้อมูล ',
                              style: TextStyle(
                                fontFamily: 'Leelawadee',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black,
                                letterSpacing: 1,
                              )),
                          TextSpan(
                              text:
                                  '                                             จำนวน ',
                              style: TextStyle(
                                fontFamily: 'Leelawadee',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
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
      ),
    ],
  );
}
