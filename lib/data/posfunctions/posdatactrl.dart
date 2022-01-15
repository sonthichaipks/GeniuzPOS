import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDisc.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranHd.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranReceipt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vatExcluded.dart';
import 'package:com_csith_geniuzpos/services/request/posdata_request.dart';

import '../wsHelper.dart';

class PosDataCtrl {
  PosDataCtrl();
  Future<List<CsPlu>> getPlusWS(String plu) async {
    List<CsPlu> list;

    var data = await wsList(plu);
    if (data != null) {
      list = csPluFromJson(data);
    }
    return list;
  }

  Future<List<PluPrice>> getPromoListWS(String plu) async {
    List<PluPrice> list;

    var data = await wsList(plu);
    if (data != null) {
      list = pluPriceFromJson(data);
    }
    return list;
  }

  Future<List<PosShiftLogin>> getSignInWS(String poslogin) async {
    List<PosShiftLogin> list;

    var data = await wsList(poslogin); // url + posid / casierid
    if (data != null) {
      list = posShiftLoginFromJson(data);
    }
    return list;
  }

  Future<String> execShiftWS(String posexec) async {
    var data = await wsExec(posexec); // url + /a/ posid / casierid / begcash
    if (data != null) {
      return data;
    }
    return null;
  }

  Future<List<VatExCluded>> getVatExCluded(String plu) async {
    List<VatExCluded> list;

    var data = await wsList(plu);
    if (data != null) {
      list = vatExCludedFromJson(data);
    }
    return list;
  }
}
