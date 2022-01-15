import 'package:com_csith_geniuzpos/models/posmodels/vposparam.dart';
import 'package:com_csith_geniuzpos/services/request/psparam_request.dart';
import 'package:flutter/cupertino.dart';

abstract class GetpsParamCallBack {
  void onpsParamSuccess(List<VpoSparam> _vpoSparam);
  void onpsParamError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetCsParamResponse {
  GetpsParamCallBack _callBackGet;
  PosCsParamRequest csParamRequest = new PosCsParamRequest();
  GetCsParamResponse(this._callBackGet);

  getCsParamForm(String posid) {
    csParamRequest
        .getPosParam(posid)
        .then((_vpoSparam) => _callBackGet.onpsParamSuccess(_vpoSparam))
        .catchError((onError) => _callBackGet.onpsParamError(onError));
  }
}

abstract class LogParamCallBack {
  void onLogParamSuccess(String ok);
  void onLogParamError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class LogCsParamResponse {
  LogParamCallBack _callBackGet;
  PosCsParamRequest logParamRequest = new PosCsParamRequest();
  LogCsParamResponse(this._callBackGet);

  logCsParamForm(BuildContext context, VpoSparam v) {
    logParamRequest
        .loadPosParam(context, v)
        .then((ok) => _callBackGet.onLogParamSuccess(ok))
        .catchError((onError) => _callBackGet.onLogParamError(onError));
  }
}
