import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget posfrontftl1(BuildContext context) {
  PosCtrl posctrl16 = posCtrlList[21]; //Use header bill
  String curDBname =
      PosControlFnc().getCurrentSettingValues(context, posctrl16);

  PosCtrl posctrl60 = posCtrlList[58]; //Shop
  String curBranch =
      PosControlFnc().getCurrentSettingValues(context, posctrl60);

  PosCtrl posctrl61 = posCtrlList[59]; //PosStation
  String curPosStation =
      PosControlFnc().getCurrentSettingValues(context, posctrl61);
  return Row(children: [
    Container(
        height: Palette.stdicon_height,
        width: Palette.stdbutton_width * 9,
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.white),
            left: BorderSide(width: 1.0, color: Colors.white),
            right: BorderSide(width: 1.0, color: Colors.white),
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
        //child:
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: '', children: <TextSpan>[
              TextSpan(
                  text: Palette.sysinfo_label
                      .replaceAll(
                          '[DB]',
                          curDBname
                              .padRight(30)
                              .substring(0, 29)
                              .trim()) //'DB(SAMPLE)')
                      .replaceAll('[text]', 'ขณะนี้ท่านกำลังทำงานกับข้อมูลของ ')
                      .replaceAll('[text1]', 'สาขา')
                      .replaceAll(
                          '[BRANCH]',
                          curBranch
                              .padRight(25)
                              .substring(0, 24)
                              .trim()) //'001-ICONSIAM')
                      .replaceAll('[text2]', 'บนเครื่องPOS หมายเลข ')
                      .replaceAll(
                          '[POSNO]',
                          curPosStation
                              .padRight(10)
                              .substring(0, 9)
                              .trim()), // '001'),
                  style: TextStyle(
                    fontFamily: 'Leelawadee',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 0.8,
                    letterSpacing: 0.05,
                    color: Colors.black,
                  )),
            ])))
  ]);
}
