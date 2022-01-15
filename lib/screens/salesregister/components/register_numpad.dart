import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_btnFix.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_hdouble.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';
import 'package:flutter/material.dart';

Widget registerNumpad(BuildContext context, PosFncCallResponse _responseInput) {
  final double positionOfButton =
      Palette.stdbutton_width + Palette.stdspacer_widht;

  final double l1 = Palette.stdbutton_height + Palette.stdspacer_widht;
  final double l2 = Palette.stdbutton_height * 2 + Palette.stdspacer_widht * 2;
  final double l3 = Palette.stdbutton_height * 3 + Palette.stdspacer_widht * 3;
  final double l4 = Palette.stdbutton_height * 4 + Palette.stdspacer_widht * 4;
  return Container(
    width: 400,
    height: 400,
    child: Stack(
      children: [
        //-----------Line7
        //---[CLS] 2 row one column org.6->add.on.to.11
        // positionPosButtons(
        //     context, _responseInput, stdButtuon7, l1, positionOfButton, 11),
        positionPos2HeightButtons(context, _responseInput, stdButtuon7, l1,
            positionOfButton, 11, FncItems().dummy),

        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 2, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 3, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon7, l1, positionOfButton * 4, 9),
        //-----------Line8
        positionFixButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 2, 7),
        positionPosButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 3, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon8, l2, positionOfButton * 4, 9),
        //-----------Line9
        //---[back space] 2row one column
        positionPos2HeightButtons(context, _responseInput, stdButtuon8, l3,
            positionOfButton, 11, FncItems().dummy),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 2, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 3, 8),
        positionFixButtons(
            context, _responseInput, stdButtuon9, l3, positionOfButton * 4, 9),
        //-----------Line10
        // positionPosButtons(
        //     context, _responseInput, stdButtuon10, l4, positionOfButton, 6),
        positionFixButtons(
            context, _responseInput, stdButtuon10, l4, positionOfButton * 2, 7),
        positionFixButtons(
            context, _responseInput, stdButtuon10, l4, positionOfButton * 3, 8),
      ],
    ),
  );
}
