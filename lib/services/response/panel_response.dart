import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';
import 'package:com_csith_geniuzpos/services/request/panel_request.dart';

abstract class PanelCallBack {
  void onLogPanelSuccess(List<TouchPanel> _vpoTouchPanel);
  void onLogPanelError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class LogPanelResponse {
  PanelCallBack _callBackGet;
  PosPanelRequest logParamRequest = new PosPanelRequest();
  LogPanelResponse(this._callBackGet);

  loadPanel(String pnlUrl) {
    logParamRequest
        .loadTouchPanel(pnlUrl)
        .then(
            (_vpoTouchPanel) => _callBackGet.onLogPanelSuccess(_vpoTouchPanel))
        .catchError((onError) => _callBackGet.onLogPanelError(onError));
  }
}

abstract class AddPanelCallBack {
  void onAddPanelSuccess(String ok);
  void onAddPanelError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class AddPanelResponse {
  AddPanelCallBack _callBackGet;
  PosPanelRequest exePanelRequest = new PosPanelRequest();
  AddPanelResponse(this._callBackGet);

  exeAboutPanelToWS(String pnlUrl) {
    exePanelRequest
        .exeAboutPanelToWS(pnlUrl)
        .then((ok) => _callBackGet.onAddPanelSuccess(ok))
        .catchError((onError) => _callBackGet.onAddPanelError(onError));
  }
}

abstract class GrpPnlListCallBack {
  void ongrpPnlListSuccess(List<GroupPanel> _vpoTouchPanel);
  void ongrpPnlListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GrpPnlListResponse {
  GrpPnlListCallBack _callBackGet;
  PosPanelRequest grpPnlListRequest = new PosPanelRequest();
  GrpPnlListResponse(this._callBackGet);

  grpPnlList(String pnlUrl) {
    grpPnlListRequest
        .loadGrpPanel(pnlUrl)
        .then((_vpoTouchPanel) =>
            _callBackGet.ongrpPnlListSuccess(_vpoTouchPanel))
        .catchError((onError) => _callBackGet.ongrpPnlListError(onError));
  }
}

abstract class ItemPnlListCallBack {
  void onitemPnlListSuccess(List<ItemPanel> _vpoTouchPanel);
  void onitemPnlListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class ItemPnlListResponse {
  ItemPnlListCallBack _callBackGet;
  PosPanelRequest itemPnlListRequest = new PosPanelRequest();
  ItemPnlListResponse(this._callBackGet);

  itemPnlList(String pnlUrl) {
    itemPnlListRequest
        .loadItemPanel(pnlUrl)
        .then((_vpoTouchPanel) =>
            _callBackGet.onitemPnlListSuccess(_vpoTouchPanel))
        .catchError((onError) => _callBackGet.onitemPnlListError(onError));
  }
}
