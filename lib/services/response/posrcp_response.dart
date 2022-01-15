import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/services/request/posbdc_request.dart';
import 'package:com_csith_geniuzpos/services/request/posrcp_request.dart';
import 'package:flutter/cupertino.dart';

abstract class PosRCPAddNew {
  void onCallPosFncAddNewSuccess(double result);
  void onCallPosFncAddNewError(String error);
}

class PosRCPAddNewCallResponse {
  PosRCPAddNew _callBackGet;
  PosBillRCPRequest posfncreq = new PosBillRCPRequest();
  PosRCPAddNewCallResponse(this._callBackGet);

  doAddNew(BuildContext context, SalesItems sales) async {
    posfncreq
        .rcpItemAdd(context, sales)
        .then((result) => _callBackGet.onCallPosFncAddNewSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosFncAddNewError(onError.toString()));
  }
}

abstract class PosGetRCPBalance {
  void onCallPosRCPSuccess(double bdcbalance);
  void onCallPosRCPError();
}

abstract class PosFncVoidRCP {
  void onCallPosFncVrcpSuccess(double amount);
  void onCallPosFncVrcpError();
}

class PosFncVoidRCPResponse {
  PosFncVoidRCP _callBackGet;
  PosBillRCPRequest posfncreq = new PosBillRCPRequest();
  PosFncVoidRCPResponse(this._callBackGet);

  doVoidRCPAitem(BuildContext context, int index) async {
    posfncreq
        .rcpVoidAitem(context, index)
        .then((amount) => _callBackGet.onCallPosFncVrcpSuccess(amount))
        .catchError((onError) => _callBackGet.onCallPosFncVrcpError());
  }
}
