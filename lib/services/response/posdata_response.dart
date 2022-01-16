import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vatExcluded.dart';
import 'package:com_csith_geniuzpos/services/request/posdata_request.dart';
import 'package:flutter/cupertino.dart';

abstract class GetPluListCallBack {
  void onPluListSuccess(List<CsPlu> csplus);
  void onPluListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPluListResponse {
  GetPluListCallBack _callBackGet;
  PosDataRequest plulistRequest = new PosDataRequest();
  GetPluListResponse(this._callBackGet);
  getPluList(String searchPlu) {
    plulistRequest
        .getPluList(searchPlu)
        .then((csplus) => _callBackGet.onPluListSuccess(csplus))
        .catchError(
            (onError) => _callBackGet.onPluListError(onError.toString()));
  }
}

abstract class GetPromoListCallBack {
  void onPromoListSuccess(List<PluPrice> promoList);
  void onPromoListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPromoListResponse {
  GetPromoListCallBack _callBackGet;
  PosDataRequest pmlistRequest = new PosDataRequest();
  GetPromoListResponse(this._callBackGet);
  getPromoList(String searchPlu) {
    pmlistRequest
        .getPromoPrice(searchPlu)
        .then((promoList) => _callBackGet.onPromoListSuccess(promoList))
        .catchError(
            (onError) => _callBackGet.onPromoListError(onError.toString()));
  }
}

abstract class GetPluCallBack {
  void onPluSuccess(CsPlu csplus);
  void onPluError(String error);
}

abstract class GetVatExcludedCallBack {
  void onVatExcludedSuccess(List<VatExCluded> vatExCluded);
  void onVatExcludedError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetVatExcludedResponse {
  GetVatExcludedCallBack _callBackGet;
  PosDataRequest vatExRequest = new PosDataRequest();
  GetVatExcludedResponse(this._callBackGet);
  getVatEx(String searchPlu) {
    vatExRequest
        .getVatExCluded(searchPlu)
        .then((vatExCluded) => _callBackGet.onVatExcludedSuccess(vatExCluded))
        .catchError(
            (onError) => _callBackGet.onVatExcludedError(onError.toString()));
  }
}
//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPluResponse {
  GetPluCallBack _callBackGet;
  PosDataRequest pluRequest = new PosDataRequest();
  GetPluResponse(this._callBackGet);
  getPlu(CsPlu csplus) {
    pluRequest
        .getPlu(csplus)
        .then((csplus) => _callBackGet.onPluSuccess(csplus))
        .catchError((onError) => _callBackGet.onPluError(onError.toString()));
  }
}

abstract class GetPosSignInCallBack {
  void onPosSigninSuccess(List<PosShiftLogin> list);
  void onPosSigninError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPosSigninResponse {
  GetPosSignInCallBack _callBackGet;
  PosDataRequest posSIgnintRequest = new PosDataRequest();
  GetPosSigninResponse(this._callBackGet);
  getPosSignin(String possignin) {
    posSIgnintRequest
        .getPosSignIn(possignin)
        .then((list) => _callBackGet.onPosSigninSuccess(list))
        .catchError(
            (onError) => _callBackGet.onPosSigninError(onError.toString()));
  }
}

abstract class execPosShiftCallBack {
  void onPosShiftAddSuccess(String result);
  void onPosShiftAddError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class ExecPosShiftResponse {
  execPosShiftCallBack _callBackGet;
  PosDataRequest addPosShift = new PosDataRequest();
  ExecPosShiftResponse(this._callBackGet);
  exPosShift(String posexec) {
    addPosShift
        .execPosShift(posexec)
        .then((result) => _callBackGet.onPosShiftAddSuccess(result))
        .catchError(
            (onError) => _callBackGet.onPosShiftAddError(onError.toString()));
  }
}

abstract class exActivePIPCallBack {
  void onActivePipSuccess();
  void onActivePipError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class ExActivePIPResponse {
  exActivePIPCallBack _callBackGet;
  PosDataRequest activePip = new PosDataRequest();
  ExActivePIPResponse(this._callBackGet);
  exActivePip(String posexec) {
    activePip
        .exSaveActivePIP(posexec)
        .then((result) => _callBackGet.onActivePipSuccess())
        .catchError(
            (onError) => _callBackGet.onActivePipError(onError.toString()));
  }
}
