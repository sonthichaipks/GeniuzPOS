import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pluhdcTitle() {
  return Row(
    children: [
      Container(
        width: Palette.stdbutton_width * 7,
        height: 30,
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border(
        //       top: BorderSide(width: 1.0, color: Colors.grey),
        //       left: BorderSide(width: 1.0, color: Colors.grey),
        //       right: BorderSide(width: 1.0, color: Colors.grey),
        //       bottom: BorderSide(width: 1.0, color: Colors.grey),
        //     )),
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
                  width: 262,
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
              left: 222,
              child: Container(
                  width: 324,
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
                  '#',
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
              left: 85,
              child: Text('PLU',
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
              left: 320,
              child: Text(Palette.plu_f11,
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
