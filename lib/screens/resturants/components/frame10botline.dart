import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_posibutton.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/positiondouble.dart';

Widget frmae10botline(BuildContext context, PosFncCallResponse _responseInput) {
  final double positionOfButton =
      (Palette.stdbutton_width + Palette.stdspacer_widht - 1.25) * 12.5 / 9;

  final double btnheight9 = Palette.stdbutton_height * 6.85 +
      Palette.stdbutton_height * 2 +
      Palette.stdspacer_widht * 2;

  final double btnheight10 =
      btnheight9 + Palette.stdbutton_height + Palette.stdspacer_widht;

  final double btnheight12 =
      Palette.stdbutton_height + Palette.stdspacer_widht * 1;

  return Stack(
    children: [
      // //-----------Line9
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * (1.3),
          positionOfButton * 7.5 + positionOfButton * 0.5,
          0),
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * 2.3,
          positionOfButton * 7.5 + positionOfButton * 0.5,
          1),
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * 3.3,
          positionOfButton * 7.5 + positionOfButton * 0.5,
          2),
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * 4.3,
          positionOfButton * 7.5 + positionOfButton * 0.5,
          3),
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * 5.3,
          positionOfButton * 7.5 + positionOfButton * 0.5,
          4),
      restpositionButtons(
          context,
          _responseInput,
          stdButtuon12,
          btnheight12 * 6.3,
          positionOfButton * 7.5 + positionOfButton * 0.5,
          5),

      positionDouble(context, _responseInput, stdButtuon13, btnheight12 * 7.33,
          positionOfButton * 7.5 + positionOfButton * 0.5, 0),
      positionDouble(context, _responseInput, stdButtuon13, btnheight12 * 8.87,
          positionOfButton * 7.5 + positionOfButton * 0.5, 1),

      // positionPosButtons(context, _responseInput, stdButtuon12, btnheight12 * 9,
      //     positionOfButton * 7.5, 8),
      // positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
      //     positionOfButton * 8.5, 8),
      // positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
      //     positionOfButton * 9.5, 9),
      // positionPosButtons(context, _responseInput, stdButtuon9, btnheight9,
      //     positionOfButton * 10.5, 10),

      //-----------Line10

      restpositionButtons(
          context, _responseInput, stdButtuon11, btnheight10, 0, 0),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 1, 1),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 2, 2),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 3, 3),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 4, 4),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 4.83, 5),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 5.83, 6),
      restpositionButtons(context, _responseInput, stdButtuon11, btnheight10,
          positionOfButton * 6.92, 7),
      // positionPosButtons(context, _responseInput, stdButtuon11, btnheight10,
      //     positionOfButton * 8, 8),
      // positionPosButtons(context, _responseInput, stdButtuon11, btnheight10,
      //     positionOfButton * 12 + Palette.stdspacer_widht, 8),

      // positionPosButtons(
      //     context, stdButtuon10, btnheight10, positionOfButton * 10.5, 10),
    ],
  );
}
