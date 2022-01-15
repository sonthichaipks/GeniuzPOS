import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget memberhdcTitle() {
  return Row(
    children: [
      Container(
        width: Palette.stdbutton_width * 9,
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
              top: 0,
              left: 0,
              child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                  child: Spacer()),
            ),
            Positioned(
              top: 0,
              left: 60,
              child: Container(
                  width: 260,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                  child: Spacer()),
            ),
            Positioned(
              top: 0,
              left: 320,
              child: Container(
                  width: 380,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        right: BorderSide(width: 1.0, color: Colors.grey),
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )),
                  child: Spacer()),
            ),
            Positioned(
                top: 4,
                left: 10,
                child: Text(
                  'ลำดับ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  ),
                )),
            Positioned(
              top: 4,
              left: 88,
              child: Text('รหัสสมาชิก',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  )),
            ),
            Positioned(
              top: 4,
              left: 450,
              child: Text('ชื่อสมาชิก',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
