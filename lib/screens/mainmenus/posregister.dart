import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/mainmenus/posfront_ftl1.dart';
import 'package:com_csith_geniuzpos/screens/mainmenus/posfront_ftl2.dart';
import 'package:com_csith_geniuzpos/screens/mainmenus/posfront_ftl3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logoheadf1.dart';

part 'configf1.dart';

PosControlModel configModel;

Widget posRegister(BuildContext context, String databasename, String branches,
    String posstation) {
  context.watch<PosControlModel>().getItem();
  return Consumer<PosControlModel>(builder: (context, model, child) {
    configModel = model;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(children: [
        Positioned(
          top: 646,
          left: 10,
          child: logoheadf1(context),
        ),
        Positioned(
          top: 620,
          left: 173,
          child: posfrontftl1(context),
        ),
        Positioned(
          top: 679,
          left: 173,
          child: posfrontftl2(),
        ),
        Positioned(
          top: 699,
          left: 173,
          child: posfrontftl3(),
        ),
      ]),
    );
  });
}
