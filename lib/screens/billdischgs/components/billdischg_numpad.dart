import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_hdouble.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/positiondouble.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';
import 'package:flutter/material.dart';

Widget billdischgNumpad(
    BuildContext context, PosFncCallResponse _responseInput, Function doact) {
  final double positionOfButton =
      Palette.stdbutton_width + Palette.stdspacer_widht;

  final double l1 = Palette.stdbutton_height + Palette.stdspacer_widht;
  final double l2 = Palette.stdbutton_height * 2 + Palette.stdspacer_widht * 2;
  final double l3 = Palette.stdbutton_height * 3 + Palette.stdspacer_widht * 3;
  final double l4 = Palette.stdbutton_height * 4 + Palette.stdspacer_widht * 4;
  return Container(
    width: 800,
    height: 400,
    child: Stack(
      children: [
        positionPos2HeightButtons(context, _responseInput, stdButtuon9, l1,
            positionOfButton, 11, FncItems().dummy),
        positionPosButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 2.5, 13),
        positionPosButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 4, 7),
        positionPosButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 5, 8),
        positionPosButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 6, 9),
        positionPosButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 2.5, 12),
        positionPosButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 4, 7),
        positionPosButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 5, 8),
        positionPosButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 6, 9),
        positionPos2HeightButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton, 10, FncItems().dummy),
        positionPosButtons(context, _responseInput, stdButtuon8, l3,
            positionOfButton * 2.5, 13),
        positionPosButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 4, 7),
        positionPosButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 5, 8),
        positionPosButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 6, 9),
        positionPosButtons(context, _responseInput, stdButtuon8, l4,
            positionOfButton * 2.5, 14),
        positionPosButtons(
            context, _responseInput, stdButtuon10, l4, positionOfButton * 4, 7),
        positionPosButtons(context, _responseInput, stdButtuon10, l4,
            positionOfButton * 5, 11),
      ],
    ),
  );
}
