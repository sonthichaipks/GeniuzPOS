import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget resttxtInputline() {
  return Row(
    children: [
      Container(
        width: Palette.restentrypanelwidth(),
        height: Palette.onelineheigth() * 0.7,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white24]),
            border: Border.all(
              color: Colors.grey,
              width: 0.3,
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
                              text: '                                  โต๊ะ ',
                              style: TextStyle(
                                fontFamily: 'Leelawadee',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black,
                                letterSpacing: 1,
                              )),
                          TextSpan(
                              text: '           จำนวน ',
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
