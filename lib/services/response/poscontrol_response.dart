import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/services/request/posctrol_request.dart';
import 'package:flutter/cupertino.dart';

abstract class GetPosCtrlCallBack {
  void onGetPosCtrlSuccess(PosCtrl posControl);
  void onGetPosCtrlError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPosCtrlResponse {
  GetPosCtrlCallBack _callBackGet;
  PosCtrlRequest poscontrolRequest = new PosCtrlRequest();
  GetPosCtrlResponse(this._callBackGet);
  getPosCtrl(PosCtrl posCtrl, int index) {
    poscontrolRequest
        .getResultSearchToSalmanForm(posCtrl, index)
        .then((posControl) => _callBackGet.onGetPosCtrlSuccess(posControl))
        .catchError(
            (onError) => _callBackGet.onGetPosCtrlError(onError.toString()));
  }
}

//---set ACM Sales Items Summary---
abstract class GetSalSUmItemCallBack {
  void onGetSalSumSuccess(String ok);
  void onGetSalSumError(String error);
}

class GetPSalSUmItemResponse {
  GetSalSUmItemCallBack _callBackGet;
  PosCtrlRequest posSalSum = new PosCtrlRequest();
  GetPSalSUmItemResponse(this._callBackGet);
  upACMSalSum(BuildContext context, SalesItemSummary _salesitemsum) {
    posSalSum.setACMBySalesItemSummary(context, _salesitemsum);
  }
}

//---set ACM Sales Items Summary---
abstract class clsSalSUmItemCallBack {
  void onGetSalSumSuccess(String ok);
  void onGetSalSumError(String error);
}

class clsSalSUmItemResponse {
  clsSalSUmItemCallBack _callBackCls;
  PosCtrlRequest posSalSum = new PosCtrlRequest();
  clsSalSUmItemResponse(this._callBackCls);
  clsACMSalSum(BuildContext context) {
    posSalSum.clearACMBySalesItemSummary(context);
  }
}
