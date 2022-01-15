import 'package:com_csith_geniuzpos/widgets/buttons/posimenubtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget registerMenu(BuildContext context, PosFncCallResponse _responseInput) {
  return Container(
      height: Palette.stdbutton_height * 8,
      width: Palette.stdbutton_width * 10.5,
      child: Stack(
        children: [
          menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
              stdButtuonMenu[12], 25, 230, 0),
          menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
              stdButtuonMenu[13], 35, 230, 1),
        ],
      ));
}
