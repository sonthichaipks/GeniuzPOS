import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/screens/retails/retail_salespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

import '../rest_seatzone.dart';

Widget restsalesHead(BuildContext context) {
  String docno =
      PosControlFnc().getRunno(context, MyConfig().a_cycleRcptBegEnd);
  return Row(children: [
    GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        } else {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSeatPages());
          Navigator.push(context, route);
        }
      },
      child: Container(
        width: Palette.restsalesheadwidth() - 2,
        height: Palette.fullsalesheadcheight(),
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
          padding: const EdgeInsets.all(1.0),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                    text: 'เลขที่ใบเสร็จฯ : ' + docno + '\r\nรวมราคาทั้งสิ้น',
                    style: TextStyle(
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.normal,
                      fontSize: 11.5,
                      height: 1.2,
                      letterSpacing: 0.1,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  ]);
}
