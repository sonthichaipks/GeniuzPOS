import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget totalSales() {
  return Container(
    child: Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(16, 16.0, 0, 5),
        child: Column(
          children: [
            Text('22,805.00',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  fontWeight: FontWeight.w300,
                  fontSize: 48,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    ]),
  );
}
