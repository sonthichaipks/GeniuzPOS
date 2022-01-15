import 'dart:typed_data';

import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';

class EscPosRequest {
  PdfPrintCtrl escpos = new PdfPrintCtrl();
  Future<Uint8List> POSprintPages(BuildContext context, PdfPageFormat format,
      String title, double cashTr, String docitemlabel) async {
    return escpos.generatePdf(context, format, title, cashTr, docitemlabel);
  }
}
