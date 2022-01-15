import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget resttotalSales() {
  return Positioned(
    bottom: 1,
    right: 8,
    child: Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 10),
        child: Column(
          children: [
            Text('22,805.00',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  fontWeight: FontWeight.w300,
                  fontSize: 32,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    ]),
  );
}
