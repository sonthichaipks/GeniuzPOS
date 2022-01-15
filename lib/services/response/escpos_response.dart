import 'dart:typed_data';

import 'package:com_csith_geniuzpos/services/request/escpos_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';

abstract class POSprintCallBack {
  void onESCPOSSuccess(Uint8List pdfFile);
  void onESCPOSError(String error);
}

//--------When get result of Request---
//--------will reponse to Abstract Call back events handler That's STATE implemented.

class POSprintResponse {
  POSprintCallBack _callBackGet;
  EscPosRequest escposUtil = new EscPosRequest();
  POSprintResponse(this._callBackGet);

  posPrint(BuildContext context, PdfPageFormat format, String title,
      double cashTr, String docitemlabel) {
    escposUtil.POSprintPages(context, format, title, cashTr, docitemlabel)
        .then((pdfFile) => _callBackGet.onESCPOSSuccess(pdfFile))
        .catchError(
            (onError) => _callBackGet.onESCPOSError(onError.toString()));
  }
}
