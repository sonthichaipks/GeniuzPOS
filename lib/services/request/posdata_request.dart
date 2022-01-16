import 'package:com_csith_geniuzpos/data/posfunctions/posdatactrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDisc.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranHd.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranReceipt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vatExcluded.dart';

class PosDataRequest {
  PosDataCtrl con = new PosDataCtrl();

  Future<List<CsPlu>> getPluList(String searchplu) {
    //String url = PosControlFnc().getPLUurl(context) + '/i/' + searchplu;
    return con.getPlusWS(searchplu);
  }

  Future<CsPlu> getPlu(CsPlu pludata) async {
    if (pludata != null) {
      return pludata;
    }

    return null;
  }

  Future<List<PluPrice>> getPromoPrice(String searchplu) async {
    return con.getPromoListWS(searchplu);
  }

  Future<List<PosShiftLogin>> getPosSignIn(String possignin) {
    return con.getSignInWS(possignin);
  }

  Future<void> exSaveActivePIP(String posip) {
    return con.exSaveActivePIP(posip);
  }

  Future<String> execPosShift(String posexec) {
    return con.execShiftWS(posexec);
  }

  Future<List<VatExCluded>> getVatExCluded(String searchplu) {
    return con.getVatExCluded(searchplu);
  }
}
