import 'dart:async';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/posmodels/paymentInfo.dart';
import '../wsHelper.dart';

class CardsCouponCtr {
  //----------Member--------------
  Future<List<PaymentInfo>> getCardsCouponListWS(
      String cardtype, String url) async {
    List<PaymentInfo> list;
    var data = await wsList(url + '/' + cardtype);
    if (data != null) {
      list = paymentInfoFromJson(data);
    }

    return list;
  }

  Future<CardsCoupon> getResultSearchToCCPForm(CardsCoupon cardsCoupon) async {
    if (cardsCoupon != null) {
      return cardsCoupon;
    }

    return null;
  }

  //----------......--------------
}
