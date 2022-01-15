import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget fssalesTitle() {
  return Row(
    children: [
      Container(
        width: Palette.stdbutton_width * 12.5 + Palette.stdspacer_widht * 11,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.white),
            )),
        child: Stack(
          children: [
            Positioned(
                top: 4,
                left: 110,
                child: Text(
                  'รายละเอียดสินค้า',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 0.1,
                  ),
                )),
            Positioned(
              top: 4,
              left: 390,
              child: Text('รหัสสินค้า (จำนวน @ ราคาต่อหน่วย)',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 0.1,
                  )),
            ),
            Positioned(
              top: 4,
              right: 210,
              child: Text('รายการส่วนลด/ชาร์จ',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 0.1,
                  )),
            ),
            Positioned(
              top: 4,
              right: 55,
              child: Text('จำนวนเงิน',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 0.1,
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
