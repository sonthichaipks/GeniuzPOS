import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/posmodels/paymentInfo.dart';
import 'package:com_csith_geniuzpos/services/request/ccp_request.dart';

abstract class GetPaymentInfoCallBack {
  void onGetPaymentSuccess(List<PaymentInfo> cardsCoupon);
  void onGetPaymentError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetPaymentInfoResponse {
  GetPaymentInfoCallBack _callBackGet;
  SearchCCPRequest paymentRequest = new SearchCCPRequest();
  GetPaymentInfoResponse(this._callBackGet);

  getResultPaymentInfo(String paytype, String url) {
    paymentRequest
        .getCCPListWS(paytype, url)
        .then((_cardsCoupon) => _callBackGet.onGetPaymentSuccess(_cardsCoupon))
        .catchError(
            (onError) => _callBackGet.onGetPaymentError(onError.toString()));
  }
}

abstract class GetSearchCCPCallBack {
  void onSearchCCPSuccess(CardsCoupon cardsCoupon);
  void onSearchCCPError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class GetSearchCCPResponse {
  GetSearchCCPCallBack _callBackGet;
  SearchCCPRequest searchCCPRequest = new SearchCCPRequest();
  GetSearchCCPResponse(this._callBackGet);

  getResultSearchToCCPForm(CardsCoupon _cardsCoupon) {
    searchCCPRequest
        .getResultSearchToCCPForm(_cardsCoupon)
        .then((cardsCoupon) => _callBackGet.onSearchCCPSuccess(cardsCoupon))
        .catchError(
            (onError) => _callBackGet.onSearchCCPError(onError.toString()));
  }
}
