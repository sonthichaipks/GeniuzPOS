import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget msgshow(BuildContext context) {
  final int messagesCount = 2;
  return Container(
    child: Column(
      children: [
        Container(
            child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _showToast(context,
                    'You have fist messsage from : JoJomew! << I LOVE YOU >> , FLUTTER!');
                _showToast(context,
                    'You have second messsage from : Potae! <<Please hum hum song>> , Any song');
              },
              child: Palette().iconShow(0),
            ),
            Positioned(
              top: 7.0,
              left: 13.0,
              right: 1.0,
              child: Text(messagesCount.toString(),
                  style: TextStyle(
                    fontFamily: 'Leelawadee',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            ),
          ],
        )),
      ],
    ),
  );
}

void _showToast(BuildContext context, String msg) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
