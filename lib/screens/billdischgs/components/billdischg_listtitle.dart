import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget billdischgTitle() {
  return Row(
    children: [
      Container(
        width: Palette.restsalesitemwidth() * 1.16,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.transparent),
              left: BorderSide(width: 1.0, color: Colors.transparent),
              right: BorderSide(width: 1.0, color: Colors.transparent),
              bottom: BorderSide(width: 1.0, color: Colors.transparent),
            )),
        child: Stack(
          children: [
            Positioned(
                top: 4,
                left: 30,
                child: Text(
                  Palette.billdischg_listtitle,
                  style: const TextStyle(
                    //  decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    letterSpacing: 0.1,
                  ),
                )),
            Positioned(
              top: 4,
              right: 42,
              child: Text(Palette.title_amount,
                  style: const TextStyle(
                    //  decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontFamily: 'Micrsoft Sans Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    letterSpacing: 0.1,
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
