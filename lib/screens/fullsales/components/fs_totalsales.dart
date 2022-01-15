import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fstotalSales() {
  return Row(
    children: [
      Positioned(
        top: 4,
        right: 6,
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: '22,805.00',
                  style: TextStyle(
                    // fontFamily: 'Leelawadee',
                    fontWeight: FontWeight.bold,
                    fontSize: 68,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    ],
  );
}
