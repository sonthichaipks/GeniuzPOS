import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDisc.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranHd.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranReceipt.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/services/request/posfnc_request.dart';
import 'package:flutter/cupertino.dart';

//-----------SALES ITEM------------------
abstract class PosFncCallBack {
  void onCallPosFncSuccess(String result);
  void onCallPosFncError(String error);
}

class PosFncCallResponse {
  PosFncCallBack _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncCallResponse(this._callBackGet);

  doEntry(String inputvalues, int shiftkey, int keyvalue) async {
    posfncreq
        .entryInput(inputvalues, shiftkey, keyvalue)
        .then((result) => _callBackGet.onCallPosFncSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallPosFncError(onError.toString()));
  }
}

//-----------SALES SUMMARY --------------
abstract class PosSumCallBack {
  void onCallSumSalesItemSuccess(SalesItemSummary result);
  void onCallSumSalesItemError(String error);
}

class PosSumSalesItemCallResponse {
  PosSumCallBack _callBackGet;
  PosFuncionRequest posSalesSumreq = new PosFuncionRequest();
  PosSumSalesItemCallResponse(this._callBackGet);

  doCalSalesItemSum(BuildContext context) async {
    posSalesSumreq
        .sumSalesItemList(context)
        .then((result) => _callBackGet.onCallSumSalesItemSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallSumSalesItemError(onError.toString()));
  }
}

//-----------SALES ITEM SAVE------------------
abstract class PosSaveCallBack {
  void onCallPosSaveSuccess(int result);
  void onCallPosSaveError(String error);
}

class PosSaveCallResponse {
  PosSaveCallBack _callBackGet;
  PosFuncionRequest posSaveReq = new PosFuncionRequest();
  PosSaveCallResponse(this._callBackGet);

  SavePosTrans(BuildContext context, int mode) async {
    posSaveReq
        .savePosTrans(context, mode)
        .then((result) => _callBackGet.onCallPosSaveSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallPosSaveError(onError.toString()));
  }
}
//-----------SALES ITEM REFUND REQUEST HERE------------------
//http://127.0.0.1:9393/savePosTrans/1GS00200122000037 - for getPosTranHD
//http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3 - for getPosTranDt
//http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4 - for getPosTranDisc
//http://127.0.0.1:9393/savePosTrans/1GS00200122000037/2/3/4/5/6 - for getPosTranReceipt

//-----------Table --------------
abstract class TableAddCallBack {
  void onCallTableAddSuccess(String result);
  void onCallTableAddError(String error);
}

class TableAddCallResponse {
  TableAddCallBack _callBackGet;
  PosFuncionRequest tableAddreq = new PosFuncionRequest();
  TableAddCallResponse(this._callBackGet);

  doAddTable(BuildContext context, String zoneno, String tableno, String info,
      double _x, double _y) async {
    tableAddreq
        .addTable(context, zoneno, tableno, info, _x, _y)
        .then((result) => _callBackGet.onCallTableAddSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallTableAddError(onError.toString()));
  }
}

abstract class TableUpdateCallBack {
  void onCallTableUpdateSuccess(String result);
  void onCallTableUpdateError(String error);
}

class TableUpdateCallResponse {
  TableUpdateCallBack _callBackGet;
  PosFuncionRequest tableUpdatereq = new PosFuncionRequest();
  TableUpdateCallResponse(this._callBackGet);

  doUpdateTable(BuildContext context, String zoneno, String tableno,
      String info, double _x, double _y) async {
    tableUpdatereq
        .updateTable(context, zoneno, tableno, info, _x, _y)
        .then((result) => _callBackGet.onCallTableUpdateSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallTableUpdateError(onError.toString()));
  }
}

abstract class SalesItemAddCallBack {
  void onCallSalesItemAddSuccess(String result);
  void onCallSalesItemAddError(String error);
}

class SalesItemAddCallResponse {
  SalesItemAddCallBack _callBackGet;
  PosFuncionRequest salesitemAddreq = new PosFuncionRequest();
  SalesItemAddCallResponse(this._callBackGet);

  doSalesItemAdd(BuildContext context, SalesItems sales) async {
    salesitemAddreq
        .salesitemAdd(context, sales)
        .then((result) => _callBackGet.onCallSalesItemAddSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallSalesItemAddError(onError.toString()));
  }
}

abstract class PosFncAddFree {
  void onCallPosFncFreeSuccess(String result);
  void onCallPosFncFreeError(String error);
}

class PosFncAddFreeCallResponse {
  PosFncAddFree _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncAddFreeCallResponse(this._callBackGet);

  doAddFree(BuildContext context) async {
    posfncreq
        .entryFree(context)
        .then((result) => _callBackGet.onCallPosFncFreeSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosFncFreeError(onError.toString()));
  }
}

abstract class PosFncAddNew {
  void onCallPosFncAddNewSuccess(String result);
  void onCallPosFncAddNewError(String error);
}

class PosFncAddNewCallResponse {
  PosFncAddNew _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncAddNewCallResponse(this._callBackGet);

  doAddNew(BuildContext context, SalesItems sales) async {
    posfncreq
        .salesItemAdd(context, sales)
        .then((result) => _callBackGet.onCallPosFncAddNewSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosFncAddNewError(onError.toString()));
  }
}

abstract class PosFncVoidAll {
  void onCallPosFncVoidSuccess();
  void onCallPosFncVoidError();
}

class PosFncVoidAllCallResponse {
  PosFncVoidAll _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncVoidAllCallResponse(this._callBackGet);

  doVoidAll(BuildContext context) async {
    posfncreq
        .salesItemVoidAll(context)
        .then((result) => _callBackGet.onCallPosFncVoidSuccess())
        .catchError((onError) => _callBackGet.onCallPosFncVoidError());
  }
}

abstract class PosFncVoidAitem {
  void onCallPosFncVaSuccess();
  void onCallPosFncVaError();
}

class PosFncVoidAitemCallResponse {
  PosFncVoidAitem _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncVoidAitemCallResponse(this._callBackGet);

  doVoidAitem(BuildContext context, int index) async {
    posfncreq
        .salesItemVoidAitem(context, index)
        .then((result) => _callBackGet.onCallPosFncVaSuccess())
        .catchError((onError) => _callBackGet.onCallPosFncVaError());
  }
}

abstract class PosFncVoidBDCB {
  void onCallPosFncVbdcbSuccess(double amount);
  void onCallPosFncVbdcbError();
}

class PosFncVoidBDCBResponse {
  PosFncVoidBDCB _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncVoidBDCBResponse(this._callBackGet);

  doVoidBDCBAitem(BuildContext context, int index) async {
    posfncreq
        .bDCBVoidAitem(context, index)
        .then((amount) => _callBackGet.onCallPosFncVbdcbSuccess(amount))
        .catchError((onError) => _callBackGet.onCallPosFncVbdcbError());
  }
}

abstract class PosFncGetAitem {
  void onCallPosFncGetItemSuccess(SalesItems result);
  void onCallPosFncGetItemError();
}

class PosFncGetAitemCallResponse {
  PosFncGetAitem _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncGetAitemCallResponse(this._callBackGet);

  doGetAitem(BuildContext context, int index) async {
    posfncreq
        .salesItemGetAitem(context, index)
        .then((result) => _callBackGet.onCallPosFncGetItemSuccess(result))
        .catchError((onError) => _callBackGet.onCallPosFncGetItemError());
  }
}

abstract class PosFncGetBDCBalance {
  void onCallPosBDCBSuccess(double bdcbalance);
  void onCallPosBDCBError();
}

class PosFncGetBDCBResponse {
  PosFncGetBDCBalance _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosFncGetBDCBResponse(this._callBackGet);

  doGetBDCB(double sumsalesitem, double discount, double charge) async {
    posfncreq
        .discChgBalAmount(sumsalesitem, discount, charge)
        .then((bdcbalance) => _callBackGet.onCallPosBDCBSuccess(bdcbalance))
        .catchError((onError) => _callBackGet.onCallPosBDCBError());
  }
}

//-----------------------------------------
abstract class PosHold {
  void onCallPosHoldSuccess(String result);
  void onCallPosHoldError(String error);
}

class PosHoldCallResponse {
  PosHold _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosHoldCallResponse(this._callBackGet);

  doPosHold() async {
    posfncreq
        .salesHold()
        .then((result) => _callBackGet.onCallPosHoldSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallPosHoldError(onError.toString()));
  }
}

abstract class PosReturn {
  void onCallPosReturnSuccess(String result);
  void onCallPosReturnError(String error);
}

class PosReturnCallResponse {
  PosReturn _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosReturnCallResponse(this._callBackGet);

  doPosReturn() async {
    posfncreq
        .salesReturn()
        .then((result) => _callBackGet.onCallPosReturnSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallPosReturnError(onError.toString()));
  }
}

abstract class PosDeposit {
  void onCallPosDepositSuccess(String result);
  void onCallPosDepositError(String error);
}

class PosDepositCallResponse {
  PosDeposit _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosDepositCallResponse(this._callBackGet);

  doPosDeposit(double amtDeposit) async {
    posfncreq
        .salesDeposit(amtDeposit)
        .then((result) => _callBackGet.onCallPosDepositSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosDepositError(onError.toString()));
  }
}

abstract class PosamtDisc {
  void onCallPosamtDiscSuccess(String result);
  void onCallPosamtDiscError(String error);
}

class PosamtDiscCallResponse {
  PosamtDisc _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosamtDiscCallResponse(this._callBackGet);

  doPosDeposit(double amtDeposit) async {
    posfncreq
        .salesDeposit(amtDeposit)
        .then((result) => _callBackGet.onCallPosamtDiscSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosamtDiscError(onError.toString()));
  }
}

abstract class PosPercDisc {
  void onCallPosPercDiscSuccess(String result);
  void onCallPosPercDiscError(String error);
}

class PosPercDiscCallResponse {
  PosPercDisc _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosPercDiscCallResponse(this._callBackGet);

  doPosPercDisc(double perDisc) async {
    posfncreq
        .salesPercDisc(perDisc)
        .then((result) => _callBackGet.onCallPosPercDiscSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosPercDiscError(onError.toString()));
  }
}

abstract class PosamtChrg {
  void onCallPosamtChrgSuccess(String result);
  void onCallPosamtChrgError(String error);
}

class PosamtChrgCallResponse {
  PosamtChrg _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosamtChrgCallResponse(this._callBackGet);

  doPosamtChrg(double amtChrg) async {
    posfncreq
        .salesPercCharge(amtChrg)
        .then((result) => _callBackGet.onCallPosamtChrgSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosamtChrgError(onError.toString()));
  }
}

abstract class PosPercChrg {
  void onCallPosPercChrgSuccess(String result);
  void onCallPosPercChrgError(String error);
}

class PosPercChrgCallResponse {
  PosPercChrg _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosPercChrgCallResponse(this._callBackGet);

  doPosPercChrg(double percChrg) async {
    posfncreq
        .salesPercCharge(percChrg)
        .then((result) => _callBackGet.onCallPosPercChrgSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosPercChrgError(onError.toString()));
  }
}

abstract class PosCouponDisc {
  void onCallPosCouponDiscSuccess(String result);
  void onCallPosCouponDiscError(String error);
}

class PosCouponDiscCallResponse {
  PosCouponDisc _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosCouponDiscCallResponse(this._callBackGet);

  doPosCouponDisc(double couponDisc) async {
    posfncreq
        .salesCouponDisce(couponDisc)
        .then((result) => _callBackGet.onCallPosCouponDiscSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosCouponDiscError(onError.toString()));
  }
}

abstract class PosCashIn1 {
  void onCallPosCashInSuccess(String result);
  void onCallPosCashInError(String error);
}

class PosCashInCallResponse {
  PosCashIn1 _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosCashInCallResponse(this._callBackGet);

  doPosCashIn(double cashIn) async {
    posfncreq
        .salesCashIn(cashIn)
        .then((result) => _callBackGet.onCallPosCashInSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallPosCashInError(onError.toString()));
  }
}

abstract class PosCashOut {
  void onCallPosCashOutSuccess(String result);
  void onCallPosCashOutError(String error);
}

class PosCashOutCallResponse {
  PosCashOut _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  PosCashOutCallResponse(this._callBackGet);

  doPosCashOut(double cashOut) async {
    posfncreq
        .salesCashOut(cashOut)
        .then((result) => _callBackGet.onCallPosCashOutSuccess(result))
        .catchError((onError) =>
            _callBackGet.onCallPosCashOutError(onError.toString()));
  }
}

//-----------REFUND Response-------
//--HD
abstract class RefundHDCallBack {
  void onRefundHDSuccess(List<GetPosTranHd> result);
  void onRefundHDError(String error);
}

class RefundHDCallResponse {
  RefundHDCallBack _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  RefundHDCallResponse(this._callBackGet);

  getRefundBillHD(String url) async {
    posfncreq
        .getBillForRefundHD(url)
        .then((result) => _callBackGet.onRefundHDSuccess(result))
        .catchError(
            (onError) => _callBackGet.onRefundHDError(onError.toString()));
  }
}

//---DT
abstract class RefundDTCallBack {
  void onRefundDTSuccess(List<GetPosTranDt> result);
  void onRefundDTError(String error);
}

class RefundDTCallResponse {
  RefundDTCallBack _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  RefundDTCallResponse(this._callBackGet);

  getRefundBillDT(String url) async {
    posfncreq
        .getBillForRefundDT(url)
        .then((result) => _callBackGet.onRefundDTSuccess(result))
        .catchError(
            (onError) => _callBackGet.onRefundDTError(onError.toString()));
  }
}

//---Disc
abstract class RefundDiscCallBack {
  void onRefundDiscSuccess(List<GetPosTranDisc> result);
  void onRefundDiscError(String error);
}

class RefundDiscCallResponse {
  RefundDiscCallBack _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  RefundDiscCallResponse(this._callBackGet);

  getRefundBillDisc(String url) async {
    posfncreq
        .getBillForRefundDisc(url)
        .then((result) => _callBackGet.onRefundDiscSuccess(result))
        .catchError(
            (onError) => _callBackGet.onRefundDiscError(onError.toString()));
  }
}

//---Receipt
abstract class RefundRecvCallBack {
  void onRefundRecvSuccess(List<GetPosTranReceipt> result);
  void onRefundRecvError(String error);
}

class RefundRecvCallResponse {
  RefundRecvCallBack _callBackGet;
  PosFuncionRequest posfncreq = new PosFuncionRequest();
  RefundRecvCallResponse(this._callBackGet);

  getRefundBillRecv(String url) async {
    posfncreq
        .getBillForRefundRecv(url)
        .then((result) => _callBackGet.onRefundRecvSuccess(result))
        .catchError(
            (onError) => _callBackGet.onRefundRecvError(onError.toString()));
  }
}
//-----------END REFUND Response

