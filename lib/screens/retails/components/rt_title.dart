import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget rtsalesTitle() {
  return Row(
    children: [
      Container(
        width: Palette.salesitemwidth() - 1,
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
                left: 180,
                child: Text(
                  'รายการสินค้า',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.1,
                  ),
                )),
            Positioned(
              top: 4,
              right: 58,
              child: Text('จำนวนเงิน',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.1,
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
