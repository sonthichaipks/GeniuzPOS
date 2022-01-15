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

Widget frameBUtton(BuildContext context) {
  PosHeadItem _posHeadItems;
  String patt =
      '[ฺBRANCH] | [POSSTATION] | [CASHIER] | [SALESMAN] | [MEMBER] ' +
          '| ' +
          DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
  int checkValue = 0;

  // PosCtrl posctrl61 = posCtrlList[59]; //PosStation
  // String curPosStation =
  //     PosControlFnc().getCurrentSettingValues(context, posctrl61);

  PosCtrl posctrl61 = posCtrlList[MyConfig().i_posId]; //PosStation
  String curPosStation =
      PosControlFnc().getCurrentSettingValues(context, posctrl61);

  if (curPosStation == null || curPosStation == '') {
    patt = '  GENIUSPOZ | ADMINISTRATOR MODE |  PANEL MAINTENANCE  | '
            .padRight(160, ' ')
            .substring(0, 159) +
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    checkValue += 1;
  } else {
    PosCtrl posctrl60 = posCtrlList[MyConfig().i_configShopId]; //Shop
    String curBranch =
        PosControlFnc().getCurrentSettingValues(context, posctrl60);

    PosCtrl posctrl62 = posCtrlList[MyConfig().i_configCashier]; //Cashier
    String curCashier =
        PosControlFnc().getCurrentSettingValues(context, posctrl62);

    PosCtrl posctrl63 = posCtrlList[MyConfig().i_configSaleman]; //Salesman
    String curSalesman =
        PosControlFnc().getCurrentSettingValues(context, posctrl63);

    PosCtrl posctrl64 = posCtrlList[MyConfig().i_configMember]; //Member
    String curMember =
        PosControlFnc().getCurrentSettingValues(context, posctrl64);

    if (curBranch.isNotEmpty) {
      patt = patt.replaceAll('[ฺBRANCH]',
          Palette.branch_lbl + curBranch.padRight(34).substring(0, 33));
      checkValue += 1;
    }
    if (curPosStation.isNotEmpty) {
      patt = patt.replaceAll('[POSSTATION]',
          Palette.posst_lbl + curPosStation.padRight(20).substring(0, 19));
      checkValue += 1;
    }
    if (curCashier.isNotEmpty) {
      patt = patt.replaceAll('[CASHIER]',
          Palette.cashier_lbl + curCashier.padRight(30).substring(0, 29));
      checkValue += 1;
    }
    if (curSalesman.isNotEmpty) {
      patt = patt.replaceAll('[SALESMAN]',
          Palette.salesman_lbl + curSalesman.padRight(30).substring(0, 29));
      checkValue += 1;
    }
    if (curMember.isNotEmpty) {
      List<String> cmb = curMember.split(':');
      if (cmb.length > 0) {
        patt = patt.replaceAll('[MEMBER]',
            Palette.member_lbl + cmb[0].padRight(45).substring(0, 44));
        checkValue += 1;
      }
    }
  }
  if (checkValue > 0) {
    _posHeadItems = (PosHeadItem(
        label: patt,
        inform: '',
        imageUrl: '',
        cmdCode: '',
        kybCode: '',
        btnXwid: 1.5,
        btnColor: Palette.stdbutton_theme_1));
  }
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
