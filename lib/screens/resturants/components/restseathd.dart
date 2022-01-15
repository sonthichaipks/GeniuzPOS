import 'package:com_csith_geniuzpos/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget restseathead(BuildContext context) {
  return Row(children: [
    GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 2));
          Navigator.push(context, route);
        } else {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 3));
          Navigator.push(context, route);
        }
      },
      child: Container(
        height: Palette.fullsalesheadcheight(),
        width: Palette.stdbutton_width * 11.36, //9.95,
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
          padding: const EdgeInsets.fromLTRB(48, 22, 8, 8),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                    text:
                        'เลือกโต๊ะที่ต้องการ ตามด้วยเลือกปุ่มฟังก์ชั่นที่ต้องการทำงานกับโต๊ะที่เลือก',
                    style: TextStyle(
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.8,
                      letterSpacing: 0.4,
                      color: Colors.black,
                    )),
                // TextSpan(
                //     text: '\r\nรวมราคาทั้งสิ้น',
                //     style: TextStyle(
                //       fontFamily: 'Micrsoft Sans Serif',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       height: 1,
                //       letterSpacing: 0.4,
                //       color: Colors.black,
                //     )),
              ],
            ),
          ),
        ),
      ),
    ),
  ]);
}
