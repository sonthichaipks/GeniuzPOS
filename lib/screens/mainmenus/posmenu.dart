import 'package:com_csith_geniuzpos/screens/mainmenus/menucomponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

class PosMenu extends StatefulWidget {
  final PosFncCallResponse responseInput;
  final int mainmenu;
  const PosMenu(
      {Key key, @required this.responseInput, @required this.mainmenu})
      : super(key: key);
  @override
  _PosMenu createState() => _PosMenu();
}

class _PosMenu extends State<PosMenu> {
  @override
  void dispose() {
    super.dispose();
  }

  double layoutheight = Palette.stdbutton_height * 10 + 15;
  double layoutwidth =
      (Palette.stdbutton_width + Palette.stdspacer_widht) * 12.5;
  PadButton poszone = stdButtuon14[0];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: layoutheight,
      width: layoutwidth,
      child: (widget.mainmenu == 0)
          ? Stack(
              children: [
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[1]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[2]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[0]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[3]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[4]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[5]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[6]),
              ],
            )
          : Stack(
              children: [
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[0]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[7]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[8]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[9]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[10]),
                menuPositionButtons(context, widget.responseInput,
                    stdButtuon14[1], stdButtuonMenu[11]),
              ],
            ),
    );
  }
}
