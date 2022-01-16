import 'package:com_csith_geniuzpos/screens/fullsales/full_salespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

import '../../screens.dart';

Widget rtlogohead(BuildContext context) {
  return Row(children: [
    GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        } else {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        }
      },
      child: Container(
        height: Palette.fullsalesheadcheight(),
        width: Palette.stdbutton_width * 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
            left: BorderSide(width: 1.0, color: Colors.white),
            right: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
        child: Palette().showLogo(),
      ),
    )
  ]);
}
