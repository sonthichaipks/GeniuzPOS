import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posAcmModel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/wsHelper.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vposparam.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PosParamCtrl {
  PosParamCtrl();
  Future<List<VpoSparam>> getCsParamWS(String posid) async {
    List<VpoSparam> list;
    //  String urlAndPosid =
    //         PosControlFnc().getCsParamUrl(context);
    var data = await wsList(posid);
    if (data != null) {
      list = vpoSparamFromJson(data);
    }
    return list;
  }

  Future<String> addFromCsParam(BuildContext context, VpoSparam v) async {
    PosAcmModel model = Provider.of<PosAcmModel>(context, listen: false);

    String vl = v.toJson().toString().replaceAll('{', '').replaceAll('}', '');
    var vll = vl.split(',');
    model.deleteAllItem();
    for (int i = 0; i < vll.length - 1; ++i) {
      var vlll = vll[i].split(':');
      String vname = vlll[0].trimLeft();
      var value = vlll[1].trimLeft();
      if (vname == 'id') {
        vname = MyConfig().poscycleName;
        value = DateFormat('yyMMdd hh:mm:ss').format(DateTime.now());
      }
      if (value == null || value == 'null') {
        value = '';
      }

      await model.addItem(PosControl(
          posctrlkey: cspno.format(i), posctrlinfo: vname, posctrldata: value));
    }

    return 'OK';
  }

  // //-----direct get params value ---
  // int getParamKey(String ck) {
  //   switch (ck) {
  //     case '10006':
  //       return 33;
  //       break;
  //     default:
  //       return 0;
  //       break;
  //   }
  // }
}
