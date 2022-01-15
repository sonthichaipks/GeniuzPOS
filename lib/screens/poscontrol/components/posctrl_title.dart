import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget posctrlhdcTitle() {
  return Row(
    children: [
      Container(
        width: Palette.stdbutton_width * 7,
        height: 30,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 386,
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
            // Positioned(
            //   top: 0,
            //   left: 160,
            //   child: Container(
            //       width: 160,
            //       height: 28,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border(
            //             top: BorderSide(width: 1.0, color: Colors.grey),
            //             left: BorderSide(width: 1.0, color: Colors.grey),
            //             right: BorderSide(width: 1.0, color: Colors.grey),
            //             bottom: BorderSide(width: 1.0, color: Colors.grey),
            //           )),
            //       child: Spacer()),
            // ),
            Positioned(
              top: 0,
              left: 242,
              child: Container(
                  width: 304,
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
                left: 60,
                child: Text(
                  'NAME',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    fontFamily: 'Tahoma',
                    letterSpacing: 0.1,
                  ),
                )),
            // Positioned(
            //   top: 4,
            //   left: 190,
            //   child: Text('ID',
            //       style: const TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.w400,
            //         fontSize: 12.0,
            //         fontFamily: 'Tahoma',
            //         letterSpacing: 0.1,
            //       )),
            // ),
            Positioned(
              top: 4,
              left: 320,
              child: Text('CURRENT SETTING',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
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
