import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_hdouble.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';

Widget billdischg11Btns(
    BuildContext context, PosFncCallResponse _responseInput, Function doact) {
  final double positionOfButton =
      Palette.stdbutton_width + Palette.stdspacer_widht;

  final double l1 = Palette.stdbutton_height + Palette.stdspacer_widht * 2;
  final double l2 =
      Palette.stdbutton_height * 2 + Palette.stdspacer_widht * 2 * 2;
  final double l3 =
      Palette.stdbutton_height * 3 + Palette.stdspacer_widht * 2 * 3;

  return Container(
    width: 800,
    height: 400,
    child: Stack(
      children: [
        positionFixButtons(
            context, _responseInput, stdButtuon10, l1, positionOfButton, 12),
        positionPosButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 15),
        positionPosButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 16),
        positionPosButtons(context, _responseInput, stdButtuon9, l1,
            positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 12),
        //------
        positionFixButtons(
            context, _responseInput, stdButtuon10, l2, positionOfButton, 13),
        positionPosButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 15),
        positionPosButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 16),
        positionPos2HeightButtons(context, _responseInput, stdButtuon7, l2,
            positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 14, doact),
        //------------
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton, 13),
        positionFixButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 14),
        positionFixButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 15),
      ],
    ),
  );
}
