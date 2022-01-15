import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/positiondouble.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';

Widget receipts11Btns(BuildContext context, PosFncCallResponse _responseInput) {
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
        positionFixButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 17),
        positionFixButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 18),
        // positionPosButtons(context, _responseInput, stdButtuon9, l1,
        //     positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 12),
        positionPosButtons(
            context, _responseInput, stdButtuon7, l2, positionOfButton, 19),
        positionPosButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 17),
        positionFixButtons(context, _responseInput, stdButtuon8, l2,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 18),
        // positionPos2HeightButtons(context, _responseInput, stdButtuon7, l2,
        //     positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 14),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton, 14),
        positionFixButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 16),
        positionFixButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 17),

        curveButtons(context, _responseInput, stdButtuon0[8], 286, 429,
            Palette.stdbutton_width * 1.1, Palette.stdbutton_height * 1.05),
        curveButtons(context, _responseInput, stdButtuon0[7], 286, 499,
            Palette.stdbutton_width * 1.1, Palette.stdbutton_height * 1.05),

        positionPosButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton, 14),
        positionPosButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 2.5 + Palette.stdspacer_widht, 16),
        positionPosButtons(context, _responseInput, stdButtuon10, l3,
            positionOfButton * 4 + Palette.stdspacer_widht * 2, 17),

        positionDouble(context, _responseInput, stdButtuon10, l1,
            positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 18),
        positionDouble(context, _responseInput, stdButtuon10, l2 * 1.26,
            positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 19),

        // restpositionButtons(context, _responseInput, stdButtuon10, l1,
        //     positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 18),
        // restpositionButtons(context, _responseInput, stdButtuon10, l2 * 1.3,
        //     positionOfButton * 5.5 + Palette.stdspacer_widht * 3, 19),
      ],
    ),
  );
}
