import 'package:com_csith_geniuzpos/data/posfunctions/posparamctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getActivePosStation.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vposparam.dart';
import 'package:flutter/cupertino.dart';

class PosCsParamRequest {
  PosParamCtrl con = new PosParamCtrl();

  Future<List<VpoSparam>> getPosParam(String posid) {
    return con.getCsParamWS(posid);
  }

  Future<String> loadPosParam(BuildContext context, VpoSparam v) {
    return con.addFromCsParam(context, v);
  }

  Future<List<GetActivePosStation>> getActivePosStation(String posid) {
    return con.getActivePosStation(posid);
  }
}
