//---abstract----USE BY STATE / IMPLEMENT------------------

import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';
import 'package:com_csith_geniuzpos/services/request/person_request.dart';

abstract class GetSearchMemberCallBack {
  void onSearchMemeberSuccess(PsMember psMember);
  void onSearchMemberError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetSearchMemberResponse {
  GetSearchMemberCallBack _callBackGet;
  SearchPersonRequest searchMemberRequest = new SearchPersonRequest();
  GetSearchMemberResponse(this._callBackGet);

  getResultSearchToMemberForm(PsMember _psMember) {
    searchMemberRequest
        .getResultSearchToMemberForm(_psMember)
        .then((psMember) => _callBackGet.onSearchMemeberSuccess(psMember))
        .catchError((onError) => _callBackGet.onSearchMemberError(onError));
  }
}

abstract class GetMemberListCallBack {
  void onSearchMemeberListSuccess(List<PsMember> psMembers);
  void onSearchMemberListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetMemberListResponse {
  GetMemberListCallBack _callBackGet;
  SearchPersonRequest searchMemberListRequest = new SearchPersonRequest();
  GetMemberListResponse(this._callBackGet);

  getMemberListForm(String search, String url) {
    searchMemberListRequest
        .getMemberListWS(search, url)
        .then((psMembers) => _callBackGet.onSearchMemeberListSuccess(psMembers))
        .catchError(
            (onError) => _callBackGet.onSearchMemeberListSuccess(onError));
  }
}

//------------
abstract class GetSearchSalmanrCallBack {
  void onSearchSalmanSuccess(Salesman salman);
  void onSearchSalmanError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetSearchSalmanResponse {
  GetSearchSalmanrCallBack _callBackGet;
  SearchPersonRequest searchMemberRequest = new SearchPersonRequest();
  GetSearchSalmanResponse(this._callBackGet);

  getResultSearchToSalmanForm(Salesman _salman) {
    searchMemberRequest
        .getResultSearchToSalmanForm(_salman)
        .then((salman) => _callBackGet.onSearchSalmanSuccess(salman))
        .catchError(
            (onError) => _callBackGet.onSearchSalmanError(onError.toString()));
  }
}

abstract class GetSalesmanListCallBack {
  void onSearchSalesmanListSuccess(List<Salesman> psSalesmans);
  void onSearchSalesmanListError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetSalesmanListResponse {
  GetSalesmanListCallBack _callBackGet;
  SearchPersonRequest searchSalesmanListRequest = new SearchPersonRequest();
  GetSalesmanListResponse(this._callBackGet);

  getSalesmanListForm(String search, String url) {
    searchSalesmanListRequest
        .getSalmanListWS(search, url)
        .then((psSalesmans) =>
            _callBackGet.onSearchSalesmanListSuccess(psSalesmans))
        .catchError(
            (onError) => _callBackGet.onSearchSalesmanListError(onError));
  }
}
