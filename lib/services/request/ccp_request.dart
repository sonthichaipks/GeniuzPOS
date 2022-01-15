import 'dart:async';

import 'package:com_csith_geniuzpos/data/ccps/ccpsctrl.dart';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/posmodels/paymentInfo.dart';

class SearchCCPRequest {
  CardsCouponCtr con = new CardsCouponCtr();

  Future<List<PaymentInfo>> getCCPListWS(String plu, String url) {
    var result = con.getCardsCouponListWS(plu, url);
    return result;
  }

  Future<CardsCoupon> getResultSearchToCCPForm(CardsCoupon cardsCoupon) {
    return con.getResultSearchToCCPForm(cardsCoupon);
  }
}
