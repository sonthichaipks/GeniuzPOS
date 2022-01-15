import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_hdouble.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';
import 'package:flutter/material.dart';

Widget cashioNumpad(BuildContext context, PosFncCallResponse _responseInput) {
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
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton, 20),
        positionFixButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 2.5, 13),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 4, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 5, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l2, positionOfButton, 21),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 6, 9),
        positionFixButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 2.5, 12),
        positionFixButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 4, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 5, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 6, 9),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l3, positionOfButton, 22),
        positionFixButtons(context, _responseInput, stdButtuon8, l3,
            positionOfButton * 2.5, 13),
        positionPosButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 4, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 5, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 6, 9),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l4, positionOfButton, 23),
        positionFixButtons(context, _responseInput, stdButtuon8, l4,
            positionOfButton * 2.5, 14),
        positionFixButtons(
            context, _responseInput, stdButtuon10, l4, positionOfButton * 4, 7),
        positionFixButtons(context, _responseInput, stdButtuon10, l4,
            positionOfButton * 5, 11),
      ],
    ),
  );
}
