import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/components/fs_logo.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/restseathd.dart';

Widget restseatsh(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        top: 28,
        left: 0,
        child: logohead(context, 1),
      ),
      Positioned(
        top: 28,
        left: 132,
        child: restseathead(context),
      ),
    ],
  );
}
