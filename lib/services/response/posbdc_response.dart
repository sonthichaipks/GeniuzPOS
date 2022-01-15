import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/services/request/posbdc_request.dart';
import 'package:flutter/cupertino.dart';

abstract class PosBDCAddNew {
  void onCallPosBDCAddNewSuccess(double result);
  void onCallPosBDCAddNewError(String error);
}

class PosDBCAddNewCallResponse {
  PosBDCAddNew _callBackGet;
  PosBillDCRequest posfncreq = new PosBillDCRequest();
  PosDBCAddNewCallResponse(this._callBackGet);

  doAddNew(BuildContext context, SalesItems sales) async {
    posfncreq
        .bdcItemAdd(context, sales)
        .then((result) => _callBackGet.onCallPosBDCAddNewSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosBDCAddNewError(onError.toString()));
  }
}

abstract class PosBDCGetBDCBalance {
  void onCallPosBDCBSuccess(double bdcbalance);
  void onCallPosBDCBError();
}

class PosBDCGetBDCBResponse {
  PosBDCGetBDCBalance _callBackGet;
  PosBillDCRequest posfncreq = new PosBillDCRequest();
  PosBDCGetBDCBResponse(this._callBackGet);

  doGetBDCB(double sumsalesitem, double discount, double charge) async {
    posfncreq
        .discChgBalAmount(sumsalesitem, discount, charge)
        .then((bdcbalance) => _callBackGet.onCallPosBDCBSuccess(bdcbalance))
        .catchError((onError) => _callBackGet.onCallPosBDCBError());
  }
}

abstract class PosBDCVoidBDCB {
  void onCallPosFncVbdcbSuccess(double amount);
  void onCallPosFncVbdcbError();
}

class PosBDCVoidBDCBResponse {
  PosBDCVoidBDCB _callBackGet;
  PosBillDCRequest posfncreq = new PosBillDCRequest();
  PosBDCVoidBDCBResponse(this._callBackGet);

  doVoidBDCBAitem(BuildContext context, int index) async {
    posfncreq
        .bDCBVoidAitem(context, index)
        .then((amount) => _callBackGet.onCallPosFncVbdcbSuccess(amount))
        .catchError((onError) => _callBackGet.onCallPosFncVbdcbError());
  }
}

//-----------SALES SUMMARY --------------
abstract class PosSumBdcCallBack {
  void onCallSumBdcItemSuccess(SalesItemSummary result);
  void onCallSumBdcItemError(String error);
}

class PosSumBdcItemCallResponse {
  PosSumBdcCallBack _callBackGet;
  PosBillDCRequest posSalesSumreq = new PosBillDCRequest();
  PosSumBdcItemCallResponse(this._callBackGet);

  doCalBDCItemSum(BuildContext context) async {
    posSalesSumreq
        .sumBDCItemList(context)
        .then((result) => _callBackGet.onCallSumBdcItemSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallSumBdcItemError(onError.toString()));
  }
}

//-----------BDCB INITIAL--------------
abstract class PosInitBdcCallBack {
  void onCallInitBdcSuccess();
  void onCallInitBdcError(String error);
}

class PosSumInitBdcResponse {
  PosInitBdcCallBack _callBackGet;
  PosBillDCRequest InitBdc = new PosBillDCRequest();
  PosSumInitBdcResponse(this._callBackGet);

  doInitBdc(BuildContext context) async {
    InitBdc.bDCBVoidALL(context).catchError(
        (onError) => _callBackGet.onCallInitBdcError(onError.toString()));
  }
}
