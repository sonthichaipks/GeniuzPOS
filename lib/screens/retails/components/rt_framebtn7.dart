import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';

Widget frmaebtn7(BuildContext context, PosFncCallResponse _responseInput) {
  final double positionOfButton =
      Palette.stdbutton_width + Palette.stdspacer_widht;
  final double btnheight = Palette.stdbutton_height * 6.85;
  final double btnheight8 = Palette.stdbutton_height * 6.85 +
      Palette.stdbutton_height +
      Palette.stdspacer_widht;
  final double btnwidth = Palette.stdbutton_width * 4.75;
  return Stack(
    children: [
      positionPosButtons(
          context, _responseInput, stdButtuon7, btnheight, btnwidth, 4),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton, 5),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 2, 6),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 3, 7),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 4, 8),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 5, 9),
      positionFixButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 6, 10),
      positionPosButtons(
          context, _responseInput, stdButtuon8, btnheight8, btnwidth, 4),
      positionPosButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton, 5),
      positionPosButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton * 2, 6),
      positionFixButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton * 3, 7),
      positionPosButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton * 4, 8),
      positionPosButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton * 5, 9),
      positionFixButtons(context, _responseInput, stdButtuon8, btnheight8,
          btnwidth + positionOfButton * 6, 10),
    ],
  );
}
