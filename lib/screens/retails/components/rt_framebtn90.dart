import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';

Widget frmaebtn90(BuildContext context, PosFncCallResponse _responseInput) {
  final double positionOfButton =
      Palette.stdbutton_width + Palette.stdspacer_widht;

  final double btnheight9 = Palette.stdbutton_height * 6.85 +
      Palette.stdbutton_height * 2 +
      Palette.stdspacer_widht * 2;

  final double btnheight10 =
      btnheight9 + Palette.stdbutton_height + Palette.stdspacer_widht;

  return Stack(
    children: [
      //-----------Line9
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          Palette.stdspacer_widht, 0),
      positionFixButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 1.5, 1),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 2.5, 2),
      positionFixButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 3.5, 3),
      positionFixButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 4.5, 4),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 5.5, 5),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 6.5, 6),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 7.5, 7),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 8.5, 8),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 9.5, 9),
      positionFixButtons(context, _responseInput, stdButtuon9, btnheight9,
          positionOfButton * 10.5, 10),

      //-----------Line10

      positionFixButtons(context, _responseInput, stdButtuon10, btnheight10,
          Palette.stdspacer_widht, 0),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 1.5, 1),
      positionFixButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 2.5, 2),
      positionFixButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 3.5, 3),
      positionFixButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 4.5, 4),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 5.5, 5),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 6.5, 6),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 7.5, 7),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 8.5 + Palette.stdspacer_widht, 8),
      positionFixButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 10.5, 9),
      // positionPosButtons(
      //     context, stdButtuon10, btnheight10, positionOfButton * 10.5, 10),
    ],
  );
}
