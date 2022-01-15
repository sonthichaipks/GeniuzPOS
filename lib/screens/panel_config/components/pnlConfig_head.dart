import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pnlConfigHead() {
  return Positioned(
    top: 28,
    left: 140,
    child: Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 10),
        child: Column(
          children: [
            Center(
              child: Text('TOUCH PANEL\r\n  MAINTAIN',
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                    color: Colors.blue,
                  )),
            ),
          ],
        ),
      ),
    ]),
  );
}
