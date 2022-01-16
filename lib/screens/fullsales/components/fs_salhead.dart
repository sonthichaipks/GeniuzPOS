import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/screens/resturants/rest_salespage.dart';
import 'package:com_csith_geniuzpos/screens/retails/retail_salespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget fssalhead(BuildContext context) {
  String docno = PosControlFnc()
      .getRunno(context, MyConfig().a_cycleRcptBegEnd); //'101214183125';

  return Row(children: [
    GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        } else {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
      },
      child: Container(
        height: Palette.fullsalesheadcheight() - 8,
        width: Palette.stdbutton_width * 4 + 66,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.white),
            right: BorderSide(width: 1.0, color: Colors.white),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                    text: 'เลขที่ใบเสร็จฯ : ' + docno + '\r\n',
                    style: TextStyle(
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.8,
                      letterSpacing: 0.4,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: '\r\nรวมราคาทั้งสิ้น',
                    style: TextStyle(
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1,
                      letterSpacing: 0.4,
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
