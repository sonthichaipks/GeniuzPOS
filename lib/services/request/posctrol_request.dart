import 'dart:async';

import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:flutter/cupertino.dart';

class PosCtrlRequest {
  PosControlFnc con = new PosControlFnc();

  Future<PosCtrl> getResultSearchToSalmanForm(PosCtrl posCtrl, int index) {
    return con.getResultSearchToPosCtrl(posCtrl, index);
  }

  Future<String> setACMBySalesItemSummary(
      BuildContext context, SalesItemSummary _salesitemsum) {
    return con.setACMBySalesItemSummary(context, _salesitemsum);
  }

  Future<String> clearACMBySalesItemSummary(BuildContext context) {
    //--------SetVariables and check null------
    return con.clearACMBySalesItemSummary(context);
  }
}
