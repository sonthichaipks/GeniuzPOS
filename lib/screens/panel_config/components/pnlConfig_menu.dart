import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/posctrls/posheaditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/widgets/poswidgets/poshead.dart';
import 'package:intl/intl.dart';

Widget pnlMenu(BuildContext context) {
  PosHeadItem _posHeadItems;
  String patt =
      '  GENIUSPOZ | ADMINISTRATOR MENU |  PANEL MAINTENANCE  |  CHANGE POS ID |'
              .padRight(160, ' ')
              .substring(0, 159) +
          ' [CURRENT PANEL] '.padRight(60, ' ') +
          DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  PosCtrl posctrl1 = posCtrlList[MyConfig().i_configPanel]; //Cashier
  String touchPanel =
      PosControlFnc().getCurrentSettingValues(context, posctrl1);

  if (touchPanel != null && touchPanel.isNotEmpty) {
    patt = patt.replaceAll('[CURRENT PANEL]', touchPanel);
  }
  _posHeadItems = (PosHeadItem(
      label: patt,
      inform: '',
      imageUrl: '',
      cmdCode: '',
      kybCode: '',
      btnXwid: 1.5,
      btnColor: Palette.stdbutton_theme_1));

  return CustomScrollView(slivers: <Widget>[
    //-----Sale Titles Line
    // UI: Branch, POS STATION, CASHIER, SALESMAN, MEMBER, DATE TIME
    //---------------------
    SliverAppBar(
      toolbarHeight: 30,
      pinned: true,
      flexibleSpace: Container(
        child: PosHead(
          posheaditems:
              (_posHeadItems == null) ? posHeadItems[0] : _posHeadItems,
        ),
      ),
    ),
  ]);
}
