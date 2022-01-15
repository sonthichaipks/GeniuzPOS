import 'dart:typed_data';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/sampledata.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfPrintCtrl {
  PdfPrintCtrl();
  PdfPageFormat format80mm = new PdfPageFormat(
      Palette.stdbutton_width * 2.67, double.infinity,
      marginAll: 4);
  PdfPageFormat formatA4 = new PdfPageFormat(595, 841, marginAll: 20);
  //----Config Data of Forms---
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final double ttfsL1 = 9;
  final double ttfsL = 8;
  final double ttfss = 7;
  final double ttfsH = 14;

  //----samples Header Data
  final String testHd1 = 'บริษัท จีเนียสรีเทล จำกัด';
  final String testHd11 = 'GENIUZ SHOP';
  final String testHd2 = 'สาขาไอคอนสยาม ชั้น 4 (00213)';
  final String testHd3 = 'ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ';
  final String testHd4 = 'โทร. 0-2691-5200, 0-2691-5202-4 โทรสาร:0-2690-0189';
  final String testHd5 = 'TID : 3462839202';
  final String testHd51 = 'ราคานี้รวมภาษีมูลค่าเพิ่มแล้ว';
  final String testHd52 = '\r\n';
  final String testHd53 = '-------------------------------------------------';
  final String testHd6 = 'Receipt #  100123000020021872';
  final String testHd61 = DateFormat('d/M/yyyy HH:mm').format(DateTime.now());
  //---Sample Body Data
  final String testPlu1 = 'ทดสอบ ภาษาไทย  ทดสอบวรรยณยุกต์';
  final String testPlu2 = 'จันทรุปราคา   ทดสอบวรรณยุกต์\r\n(10 x @150.00)';
  final String testPlu3 =
      'อนุมัติ สัจจังที่ดี๊ดี ทดสอบวรรยณยุกต์\r\n(5 x @30.00)';
  //---sample Footer Data / TOtal
  final String testAmt1 = '9,999,999.99';
  final String testAmt2 = '1,500.00';
  final String testAmt3 = '150.00';

  //----Sample Doc Data
  final _basColor = PdfColors.black;
  final String invoiceno = '128120931903';
  final lorem = pw.LoremText();

  //--------------- MAIN FUNCTION FOR GERNERATE PDF PRINTING--
  Future<Uint8List> generatePdf(BuildContext context, PdfPageFormat format,
      String checkPrintFormId, double cashtr, String docitemlabel) async {
    TtfFont ttf9 = await fontFromAssetBundle('fonts/ARIALN.ttf');
    final ttf1 = await fontFromAssetBundle('fonts/tahoma.ttf');

    final docLogo = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/doclogo.png')).buffer.asUint8List(),
    );
    final pgTheme = ThemeData.withFont(
      base: await fontFromAssetBundle('fonts/ARIALN.ttf'),
      bold: await fontFromAssetBundle('fonts/ARIALNB.ttf'),
      italic: await fontFromAssetBundle('fonts/ARIALNI.ttf'),
      boldItalic: await fontFromAssetBundle('fonts/ARIALNBI.ttf'),
    );
    final pgThemeTH = ThemeData.withFont(
      base: await fontFromAssetBundle('fonts/tahoma.ttf'),
      bold: await fontFromAssetBundle('fonts/tahomabd.ttf'),
      // italic: await fontFromAssetBundle('fonts/ARIALNI.ttf'),
      // boldItalic: await fontFromAssetBundle('fonts/ARIALNBI.ttf'),
    );

    //---SAMPLES CHOICES
    if (checkPrintFormId == 'EscPos') {
      pdf.addPage(escPos(pgTheme, format, ttf1, ttf9, docLogo));
    } else if (checkPrintFormId == 'EscCashIO') {
      pdf.addPage(escCashIO(pgTheme, format, ttf1, ttf9, docLogo));
    } else if (checkPrintFormId == 'FullTax') {
      pdf.addPage(fullText(pgThemeTH, format, ttf1, ttf9, docLogo));
//---POS FUNCTIONS CHOICES
    } else if (checkPrintFormId == '80mm_CashIO') {
      pdf.addPage(cashIO_80mm(
          context, pgTheme, format, ttf1, ttf9, docLogo, cashtr, docitemlabel));
    } else if (checkPrintFormId == '80mm_Pos') {
      pdf.addPage(slipPos_80mm(context, pgTheme, format, ttf1, ttf9, docLogo));
    } else if (checkPrintFormId == 'A4_FullTax') {
      pdf.addPage(fullText(pgThemeTH, format, ttf1, ttf9, docLogo));
    }

    return pdf.save();
  }

//-------Generate Date from checkPrintFormId by the sent context
//---Slip item display style (1-5) (1-Desc,2-Plu,3-Sku, 4-Desc/Plu, 5-Desc/Sku)
  String sitDisplayStyle;
//---Header 6 lines
//---Footer 10 lines
//---doc.variables
  String hl1, hl2, hl3, hl4, hl5, hl6;
  String fl1, fl2, fl3, fl4, fl5, fl6, fl7, fl8, fl9, flA;
  String posid, cashier, shopid, member, salesman, docno, pid;
  double tsalamt, tbdcamt, tdue, vatamt, vatable, trecvpt, tchange;
  SalesItemSummary totalsales, totalbdc, totalreceipt;
  int sic, bic, ric;

  void getConfigValue(BuildContext context) {
    try {
      sitDisplayStyle = PosControlFnc()
          .getConfigValue(context, MyConfig().i_sitDisplayStyle, '');
      if (sitDisplayStyle.isNotEmpty && sitDisplayStyle.length > 1) {
        sitDisplayStyle = sitDisplayStyle.substring(0, 1);
      }
      //-------
      hl1 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline1, '');
      hl2 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline2, '');
      hl3 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline3, '');
      hl4 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline4, '');
      hl5 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline5, '');
      hl6 =
          PosControlFnc().getConfigValue(context, MyConfig().i_headerline6, '');

      fl1 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline1, '');
      fl2 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline2, '');
      fl3 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline3, '');
      fl4 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline4, '');
      fl5 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline5, '');
      fl6 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline6, '');
      fl7 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline7, '');
      fl8 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline8, '');
      fl9 =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerline9, '');
      flA =
          PosControlFnc().getConfigValue(context, MyConfig().i_footerlineA, '');

      docno = PosControlFnc()
          .getRunno(context, MyConfig().a_cycleRcptBegEnd); //'101214183125';
      shopid = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configShopId, '');
      posid = PosControlFnc().getConfigValue(context, MyConfig().i_posId, '');
      pid = PosControlFnc().getConfigValue(context, MyConfig().i_pId, '');
      cashier = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configCashier, '');
      member = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configMember, '');
      salesman = PosControlFnc()
          .getConfigValue(context, MyConfig().i_configSaleman, '');
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  String sitDisLabel(SalesItems asit) {
    if (asit != null) {
      switch (sitDisplayStyle) {
        case "1":
          {
            return asit.salesitem.padRight(30).substring(0, 29);
          }
          break;
        case "2":
          {
            return asit.plu.padRight(30).substring(0, 29);
          }
          break;
        case "3":
          {
            return asit.plu.padRight(30).substring(0, 29);
          }
          break;
        case "4":
          {
            return asit.salesitem.padRight(30).substring(0, 29) +
                '\r\n' +
                asit.plu.padRight(30).substring(0, 29);
          }
          break;
        case "5":
          {
            return asit.salesitem.padRight(30).substring(0, 29) +
                '\r\n' +
                asit.plu.padRight(30).substring(0, 29);
          }
          break;
        default:
          {
            return asit.plu.padRight(30).substring(0, 29);
          }
          break;
      }
    } else {
      return '';
    }
  }

//---Rows of Body --SalesItem, BillDiscChg, Receipt
  List<SalesItems> saleslist, bdclist, receiptlist;
  void getList(BuildContext context, String IEmode) {
    int errnum = 0;
    PosInput _posinput = new PosInput();
    //--SalesVatType
    //---I-inclusive vat (amount * vatrate / (100+vatrate))
    //---E-exclusive vat (amount * vatrate)
    //final String IEmode = PosControlFnc().getSalesVateType(context);

    try {
      saleslist = _posinput.getSalesList(context);
      // ++errnum;
      bdclist = _posinput.getBDCList(context);
//++errnum;
      receiptlist = _posinput.getReceiptList(context);
      //  ++errnum;
      //----count
      if (saleslist != null) {
        sic = saleslist.length;
      } else {
        sic = 0;
      }
      ++errnum; //4
      if (bdclist != null) {
        bic = bdclist.length;
      } else {
        bic = 0;
      }
      ++errnum;
      if (receiptlist != null) {
        ric = receiptlist.length;
      } else {
        ric = 0;
      }
      ++errnum;
      //----total and summary records---
      if (saleslist != null && sic > 0) {
        totalsales = _posinput.getSalesSUM(context);
        tsalamt = totalsales.totalamount;
        vatamt = totalsales.totalvat;
        vatable = tsalamt - vatamt;
      } else {
        tsalamt = 0;
        vatamt = 0;
        vatable = 0;
      }
      ++errnum;
      if (bdclist != null && bic > 0) {
        totalbdc = _posinput.getBDCSUM(context);
        tdue = tsalamt + totalbdc.totalamount;
        double vatrate = 7;
        if (IEmode == 'I') {
          vatamt =
              double.parse(c2rnd.format(tdue * (vatrate / (100 + vatrate))));
          vatable = tdue - vatamt;
        } else {
          vatamt = double.parse(c2rnd.format(tdue * vatrate / 100));
          vatable = tdue;
          tdue = tdue + vatamt; //total due will add vatamt
        }
      } else {
        tdue = tsalamt;
        double vatrate = 7;
        if (IEmode == 'I') {
          vatamt =
              double.parse(c2rnd.format(tdue * (vatrate / (100 + vatrate))));
          vatable = tdue - vatamt;
        } else {
          vatamt = double.parse(c2rnd.format(tdue * vatrate / 100));
          vatable = tdue;
          tdue = tdue + vatamt; //total due will add vatamt
        }
      }
      //  ++errnum; //8
      if (receiptlist != null && ric > 0) {
        totalreceipt = _posinput.getReceiptSUM(context);
        if (totalreceipt.totalamount != tdue) {
          tchange = totalreceipt.totalamount - tdue;
        } else {
          tchange = 0;
          //totalreceipt.totalamount - tdue;
        }
      } else {
        tchange = 0;
      }
    } catch (e) {
      showToast(
          context,
          'Printing & Save & Next Running:Data Error' +
              errnum.toString() +
              e.toString());
    }
  }
//---GenPdfList

//---End Generate Data for printing
//---POS FUNCTIONS PDF PRINTING
  pw.Page cashIO_80mm(
      BuildContext context,
      ThemeData pgTheme,
      PdfPageFormat format,
      TtfFont ttf1,
      TtfFont ttf9,
      PdfImage docLogo,
      double cashtr,
      String docitemlabel) {
    getConfigValue(context);
    return pw.Page(
      theme: pgTheme,
      pageFormat: format,
      build: (context) {
        return pw.Column(children: [
          pw.Container(
            height: 50,
            width: 100,
            child: pw.Image(pw.ImageProxy(docLogo)),
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          p1column(hl1, ttf1, ttfsL),
          p2columnNV(
              'POS ID.: ' + posid.trim() + '  PID:  ' + pid.trim(),
              DateFormat('d/M/yyyy HH:mm').format(DateTime.now()),
              ttf9,
              ttf9,
              ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          p2columnNV(docitemlabel, oCcy.format(cashtr), ttf1, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          p1columnLEFT('CASHIER:  ' + cashier, ttf1, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
        ]);
      },
    );
  }

  pw.Page slipPos_80mm(BuildContext context, ThemeData pgTheme,
      PdfPageFormat format, TtfFont ttf1, TtfFont ttf9, PdfImage docLogo) {
    getConfigValue(context);
    final String IEmode = PosControlFnc().getSalesVateType(context);
    getList(context, IEmode);
    int mode = PosControlFnc().getBillmode(context);
    // if (mode == 2) {
    //   docno = docno.replaceAll('\r\n', ':');
    // }
    return pw.Page(
      theme: pgTheme,
      pageFormat: format,
      build: (context) {
        return pw.Column(children: [
          //----logo
          pw.Container(
            height: 50,
            width: 100,
            child: pw.Image(pw.ImageProxy(docLogo)),
          ),
          //----Header
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          (hl1.isNotEmpty && !hl1.contains('HEADER LINE'))
              ? p1column(hl1, ttf1, ttfsL)
              : pw.Container(),
          (hl2.isNotEmpty && !hl2.contains('HEADER LINE'))
              ? p1column(hl2, ttf1, ttfsL)
              : pw.Container(),
          (hl3.isNotEmpty && !hl3.contains('HEADER LINE'))
              ? p1column(hl3, ttf1, ttfsL)
              : pw.Container(),
          (hl4.isNotEmpty && !hl4.contains('HEADER LINE'))
              ? p1column(hl4, ttf1, ttfsL)
              : pw.Container(),
          (hl5.isNotEmpty && !hl5.contains('HEADER LINE'))
              ? p1column(hl5, ttf1, ttfsL)
              : pw.Container(),

          (hl6.isNotEmpty && !hl6.contains('HEADER LINE'))
              ? p1column(hl6, ttf1, ttfsL)
              : pw.Container(),
          pw.Padding(padding: const pw.EdgeInsets.all(4)),
          // spacer(ttf1),
          p2columnNV(
              (mode == 2)
                  ? 'Refund # ' + docno.replaceAll('\r\n', '\r\nRefer # ')
                  : 'Receipt # ' + docno,
              DateFormat('d/M/yyyy HH:mm').format(DateTime.now()),
              ttf9,
              ttf9,
              ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          //----body-----
          spacer(ttf1),
          for (int i = 0; i < sic; i++)
            (sic > i)
                ? p2columnSalesItem(
                    sitDisLabel(saleslist[i]), //.salesitem,
                    oCcy.format(saleslist[i].amount) +
                        '  ' +
                        ((saleslist[i].plu.isNotEmpty)
                            ? saleslist[i].vatcode.substring(
                                0, (saleslist[i].vatcode.contains('*')) ? 2 : 1)
                            : '   '),
                    ttf1,
                    ttf9,
                    ttfsL)
                : pw.Container(),
          //---end body---
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          spacer(ttf1),
          (totalsales != null)
              ? p2columnNV('T O T A L', oCcy.format(totalsales.totalamount),
                  ttf1, ttf9, ttfsL1)
              : pw.Container(),
          //----BDC
          for (int i = 0; i < bic; i++)
            (bic > i)
                ? p2columnNV(bdclist[i].salesitem,
                    oCcy.format(bdclist[i].amount), ttf1, ttf9, ttfsL1)
                : pw.Container(),

          //-----end BIll disc/charge
          (IEmode == 'I')
              ? (bic > 0)
                  ? p2columnNV(
                      'N E T  T O T A L', oCcy.format(tdue), ttf1, ttf9, ttfsL1)
                  : pw.Container()
              : pw.Container(),
          (totalsales.totalvat != null)
              ? p2columnNV((IEmode == 'I') ? 'Vatable' : 'N E T  T O T A L',
                  oCcy.format(vatable), ttf1, ttf9, ttfsL1)
              : pw.Container(),
          (totalsales.totalvat != null)
              ? p2columnNV('Vat', oCcy.format(vatamt), ttf1, ttf9, ttfsL1)
              : pw.Container(),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          spacer(ttf1),
          (tdue != null)
              ? p2columnNV(
                  'T O T A L  D U E', oCcy.format(tdue), ttf1, ttf9, ttfsL1)
              : pw.Container(),
          //-----Receipt
          for (int i = 0; i < ric; i++)
            (ric > i)
                ? p2columnNV(receiptlist[i].salesitem,
                    oCcy.format(receiptlist[i].amount), ttf1, ttf9, ttfsL1)
                : pw.Container(),
          //-----Summary------------
          (ric > 0)
              ? p2columnNV(
                  (mode == 2)
                      ? 'T O T A L  R E F U N D'
                      : 'T O T A L  R E C E I V E',
                  oCcy.format(totalreceipt.totalamount),
                  ttf1,
                  ttf9,
                  ttfsL1)
              : pw.Container(),
          (tchange == 0)
              ? pw.Container()
              : (mode == 2)
                  ? pw.Container()
                  : p2columnNV(
                      'C H A N G E ', oCcy.format(tchange), ttf1, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          spacer(ttf1),
          p1columnLEFT(
              'TOTAL ITEM: ' +
                  cno.format(totalsales.itemcount) +
                  '  TOTAL QTY: ' +
                  cno.format(totalsales.totalqty),
              ttf1,
              ttfsL1),
          p1columnLEFT('POS ID.: ' + posid + '  PID: ' + pid, ttf1, ttfsL1),
          p1columnLEFT('CASHIER: ' + cashier, ttf1, ttfsL1),
          (member.replaceAll('_', '') != '')
              ? p1columnLEFT('MEMBER: ' + member, ttf1, ttfsL1)
              : pw.Container(),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          // spacer(ttf1),
          (fl1.isNotEmpty && !fl1.contains('Footer LINE'))
              ? p1column(fl1, ttf1, ttfsL)
              : pw.Container(),
          (fl2.isNotEmpty && !fl2.contains('Footer LINE'))
              ? p1column(fl2, ttf1, ttfsL)
              : pw.Container(),
          (fl3.isNotEmpty && !fl3.contains('Footer LINE'))
              ? p1column(fl3, ttf1, ttfsL)
              : pw.Container(),
          (fl4.isNotEmpty && !fl4.contains('Footer LINE'))
              ? p1column(fl4, ttf1, ttfsL)
              : pw.Container(),
          (fl5.isNotEmpty && !fl5.contains('Footer LINE'))
              ? p1column(fl5, ttf1, ttfsL)
              : pw.Container(),
          (fl6.isNotEmpty && !fl6.contains('Footer LINE'))
              ? p1column(fl6, ttf1, ttfsL)
              : pw.Container(),
          (fl7.isNotEmpty && !fl7.contains('Footer LINE'))
              ? p1column(fl7, ttf1, ttfsL)
              : pw.Container(),
          (fl8.isNotEmpty && !fl8.contains('Footer LINE'))
              ? p1column(fl8, ttf1, ttfsL)
              : pw.Container(),
          (fl9.isNotEmpty && !fl9.contains('Footer LINE'))
              ? p1column(fl9, ttf1, ttfsL)
              : pw.Container(),
          (flA.isNotEmpty && !flA.contains('Footer LINE'))
              ? p1column(flA, ttf1, ttfsL)
              : pw.Container(),

          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          _barcode(docno),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          _qrcode((mode == 2)
              ? docno.replaceAll('\r\n', ':').split(':')[0]
              : docno),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
        ]);
      },
    );
  }

//----------------SAMPLE FUNCTION FOR SLIP 80mm ----------------------------
  pw.Page escPos(ThemeData pgTheme, PdfPageFormat format, TtfFont ttf1,
      TtfFont ttf9, PdfImage docLogo) {
    return pw.Page(
      theme: pgTheme,
      pageFormat: format,
      build: (context) {
        return pw.Column(children: [
          pw.Container(
            height: 50,
            width: 100,
            child: pw.Image(pw.ImageProxy(docLogo)),
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          p1column(testHd1, ttf1, ttfsL),
          p1column(testHd11, ttf1, ttfsL),
          p1column(testHd2, ttf1, ttfsL),
          p1column(testHd3, ttf1, ttfsL),
          p1column(testHd5, ttf1, ttfsL),
          p1column(testHd51, ttf1, ttfsL),
          pw.Padding(padding: const pw.EdgeInsets.all(4)),
          // spacer(ttf1),
          p2columnNV(testHd6, testHd61, ttf9, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          // spacer(ttf1),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu3, testAmt3, ttf1, ttf9, ttfsL),
          p2column(testPlu1, testAmt1, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu3, testAmt3, ttf1, ttf9, ttfsL),
          p2column(testPlu1, testAmt1, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu3, testAmt3, ttf1, ttf9, ttfsL),
          p2column(testPlu1, testAmt1, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          p2column(testPlu3, testAmt3, ttf1, ttf9, ttfsL),
          p2column(testPlu1, testAmt1, ttf1, ttf9, ttfsL),
          p2column(testPlu2, testAmt2, ttf1, ttf9, ttfsL),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          // spacer(ttf1),
          p2columnNV('Total', testAmt1, ttf1, ttf9, ttfsL1),
          p2columnNV('Vatable', testAmt2, ttf1, ttf9, ttfsL1),
          p2columnNV('Vat', testAmt3, ttf1, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          //spacer(ttf1),
          p2columnNV('T O T A L  D U E', testAmt1, ttf1, ttf9, ttfsL1),
          p2columnNV('C A S H', testAmt2, ttf1, ttf9, ttfsL1),
          p2columnNV('T O T A L  R E C E I V E', testAmt3, ttf1, ttf9, ttfsL1),
          p2columnNV('C H A N G E ', testAmt3, ttf1, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          //spacer(ttf1),
          p1columnLEFT('TOTAL ITEM: 4  TOTAL QTY:  17', ttf1, ttfsL1),
          p1columnLEFT('POS ID.: 00123  PID:  33986250012', ttf1, ttfsL1),
          p1columnLEFT('CASHIER:  00005-จันทนี ศรีสมร', ttf1, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          // spacer(ttf1),
          p1column('ใบเสร็จนี้สามารถนำไปแลกของสมนาคุณ', ttf1, ttfsL),
          p1column('ทุกๆ 500 บาทในใบเสร็จเดียวกัน สามารุถนำไปแลก', ttf1, ttfsL),
          p1column('คูปองเงินสด 20 บาท หมดเขต 30 ตุลาคม 64 นี้', ttf1, ttfsL),
          p1column(
              'ตลอดเดือน พ.ย. นี้ เตรียมพบกับงานฉลองครบรอบ 5 ปี', ttf1, ttfsL),
          p1column(
              'ในงาน BIG SURPRISE SALES !!! ลดทุกแผนกสูงสุด 80%', ttf1, ttfsL),
          p1column('T H A N K  Y O U', ttf1, ttfsL),
          p1column('P L E A S E  V I S I T  U S  A G A I N', ttf1, ttfsL),

          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          _barcode('100123000020021872'),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          _qrcode('100123000020021872'),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
        ]);
      },
    );
  }
//---Cash In/out Slip--

  pw.Page escCashIO(ThemeData pgTheme, PdfPageFormat format, TtfFont ttf1,
      TtfFont ttf9, PdfImage docLogo) {
    return pw.Page(
      theme: pgTheme,
      pageFormat: format,
      build: (context) {
        return pw.Column(children: [
          pw.Container(
            height: 50,
            width: 100,
            child: pw.Image(pw.ImageProxy(docLogo)),
          ),
          pw.Padding(padding: const pw.EdgeInsets.all(1)),
          p1column(testHd1, ttf1, ttfsL),
          p2columnNV('POS ID.: 00123  PID:  33986250012', testHd61, ttf9, ttf9,
              ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          p2columnNV('C A S H   B E G I N', testAmt2, ttf1, ttf9, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          p1columnLEFT('CASHIER:  00005-จันทนี ศรีสมร', ttf1, ttfsL1),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
        ]);
      },
    );
  }

//---Barcode---
  BarcodeWidget _qrcode(String barcode) {
    return BarcodeWidget(
      barcode: Barcode.qrCode(
        errorCorrectLevel: BarcodeQRCorrectionLevel.high,
      ),
      data: barcode,
      width: 60,
      height: 60,
    );
  }

  BarcodeWidget _barcode(String barcode) {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: barcode,
      width: 120,
      height: 60,
    );
  }

//---invoice---
  pw.MultiPage invoice(PdfPageFormat format, TtfFont ttf1, TtfFont ttf9) {
    return pw.MultiPage(
      theme: pw.ThemeData.withFont(
        base: ttf1,
        bold: ttf9,
      ),
      header: _buildHeader,
      footer: _buildFooter,
      build: (context) => [
        _contentHeader(context),
        //   _contentTable(context),
        pw.SizedBox(height: 20),
        _contentFooter(context),
        pw.SizedBox(height: 20),
        //  _termsAndConditions(context),
      ],
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: PdfColors.black,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text('invoiceNumber'),
                          pw.Text('Date:'),
                          pw.Text('14/8/21'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child: pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# 111111',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Total: ${oCcy.format(double.parse('99,999.99'))}',
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: 'SOMCHAI\n',
                          style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: '12 Moo',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for your business',
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Payment Info:',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                'paymentInfo',
                style: const pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: PdfColors.black,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.black,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Sub Total:'),
                    pw.Text('99,999.99'),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    pw.Text('${(99 * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                pw.Divider(color: PdfColors.black),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text('99,999.99'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//-----end invoice
  pw.MultiPage fullText(ThemeData pgTheme, PdfPageFormat format, TtfFont ttf1,
      TtfFont ttf9, PdfImage docLogo) {
    return pw.MultiPage(
        theme: pgTheme,
        pageFormat: format,
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          // if (context.pageNumber == 1) {
          //   return pw.SizedBox();
          // }
          return _bHeader(context, docLogo, ttf1);
        },
        footer: (pw.Context context) {
          return _bFooter(context, docLogo, ttf1);
        },
        build: (pw.Context context) {
          return _bContent(context, docLogo, ttf1);
        });
  }

//----Fulltax functions : A4 ----------------------------------
  pw.Container _bHeader(pw.Context context, PdfImage docLogo, final ttf1) {
    return pw.Container(
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
        child: pw.Row(children: <pw.Widget>[
          p2columnFT(context, docLogo, ttf1),
          //  p2columnFt2(context, ttf1),
        ]));
  }

  pw.Container _bFooter(pw.Context context, PdfImage docLogo, final ttf1) {
    return pw.Container(
        height: 200,
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                top: pw.BorderSide(width: 0.5, color: PdfColors.black))),
        child: pw.Column(children: <pw.Widget>[
          p2columnFullTaxFooter(context, ttf1),
          pw.Padding(padding: const pw.EdgeInsets.all(4)),
          p2columnFullTaxSigned(context, ttf1),
        ]));
  }

  List<pw.Widget> _bContent(pw.Context context, PdfImage docLogo, final ttf1) {
    return <pw.Widget>[
      //  p2columnFT(context, docLogo, ttf1),
      p2columnFt2(context, ttf1),
      pw.Padding(padding: const pw.EdgeInsets.all(2)),
      pTitlecolumn(
          ' ลำดับ                                                            รายการ                                                        จำนวน    หน่วย            ราคา/หน่วย    ส่วนลด/ชาร์จ             จำนวนเงิน',
          ttf1,
          7.5),
      pw.Padding(padding: const pw.EdgeInsets.all(2)),
      _contentTable(context),
      pw.Padding(padding: const pw.EdgeInsets.all(2)),
      //pw.Header(level: 1, text: ''),
    ];
  }

  pw.Row p2columnFT(pw.Context context, PdfImage docLogo, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 100,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Container(
                        child: pw.Image(pw.ImageProxy(docLogo),
                            width: 240, height: 50),
                      )),
                ])),
        //  pw.Spacer(),
        pw.Container(
            width: 410,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: _bCTB_2(context, ttf1),
                  )
                ])),
      ],
    );
  }

  pw.Row p2columnFt2(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 340,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: _bCTB_21(context, ttf1),
                  )
                ])),
        //  pw.Spacer(),
        pw.Container(
            width: 240,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: _bCTB_210(context, ttf1),
                  )
                ])),
      ],
    );
  }

  pw.Row _bCTB_2(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 290,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  p1columnLEFTB(testHd1, ttf1, 12),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(
                      'เลขที่ 9 อาคาร วรสิน ชั้น 4A ถ.วิภาวดีรังสิต แขวงจอมพล',
                      ttf1,
                      8),
                  p1columnLEFT('เขตจตุจักร กรุงเทพฯ 10900 ', ttf1, 8),
                  p1columnLEFT(
                      'โทร. 0-2691-5200, 0-2691-5202-4 โทรสาร:0-2690-0189',
                      ttf1,
                      8),
                ])),
        //pw.Spacer(),
        pw.Container(
            width: 160,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(6)),
                  p1columnRight('ใบเสร็จรับเงิน/ใบกำกับภาษี', ttf1, 13),
                  p1columnRight('RECEIPT / TAX INVOICE', ttf1, 13),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnRight('พิมพ์ครั้งที่ 2', ttf1, 8),
                ])),
      ],
    );
  }

  pw.Row _bCTB_21(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 80,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnLEFT('ชื่อลูกค้า', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT('ที่อยู่', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT('เบอร์โทร.', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT('เลขประจำตัวผู้เสียภาษี', ttf1, 8),
                ])),
        //pw.Spacer(),
        pw.Container(
            width: 400,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnLEFT(
                      ':  บริษัท ทีจี เซลลูล่าร์เวิลด์ จำกัด ', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(
                      ':  อาคารว่่องวาณิช ชั้น 5 เลขที่ 12/3 ถ.พญาไท', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':  แขวงพญาไท เขตพญาไท กรุงเทพฯ 10110', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':  0898417777', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':  346283939202', ttf1, 8),
                ])),
      ],
    );
  }

  pw.Row _bCTB_210(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 120,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnRight('สาขาที่ออกใบกำกับฯ', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnRight('วันที่ใบกำกับภาษี', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnRight('เลขที่ใบกำกับภาษี', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnRight('ออกแทนใบกำกับฯอย่างย่อเลขที่', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnRight('เลขประจำตัวผู้เสียภาษี', ttf1, 8),
                ])),
        //pw.Spacer(),
        pw.Container(
            width: 160,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnLEFT(':   00123-ไอคอนสยาม', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':   25/07/2021', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':   2200123210000001', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':   10012300005000184', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(1)),
                  p1columnLEFT(':   3102400595848', ttf1, 8),
                ])),
      ],
    );
  }

  pw.Container _contentTable(pw.Context context) {
    //const tableHeaders = ['', '', '', '', '', '', ''];
    return pw.Container(
        height: 360,
        width: double.infinity,
        decoration: pw.BoxDecoration(
            border: pw.Border(
          // top: pw.BorderSide(width: 1.0, color: PdfColors.black),
          bottom: pw.BorderSide(width: 1.0, color: PdfColors.white),
        )),
        child: pw.Table.fromTextArray(
          border: null,
          headerHeight: 0,
          headerCount: 0,
          cellHeight: 12,
          cellStyle: const pw.TextStyle(
            color: PdfColors.black,
            fontSize: 8,
          ),
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerLeft,
            4: pw.Alignment.centerRight,
            5: pw.Alignment.centerRight,
            6: pw.Alignment.centerRight,
          },
          data: List<List<String>>.generate(
            5,
            (row) => List<String>.generate(
              7,
              (col) => samSalesItems[row].getIndex(col),
            ),
          ),
        ));
  }

  pw.Row p2columnFullTaxFooter(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 350,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: _bCTB_21Footer(context, ttf1),
                  )
                ])),
        //  pw.Spacer(),
        pw.Container(
            width: 240,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: _bCTB_210Footer(context, ttf1),
                  )
                ])),
      ],
    );
  }

  pw.Row _bCTB_21Footer(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 400,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnLEFT(
                      '* ราคาขายเป็นราคาทีรวมภาษีมูลค่าเพิ่มไว้แล้ว (VAT Inclusive)',
                      ttf1,
                      8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnLEFT(
                      'V = สินค้า คิดภาษี, N = สินค้ายกเว้นภาษี', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnLEFT('หมายเหตุ:', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(15)),
                  p1columnLEFT(
                      'จํานวนเงินตัวหนังสือ : (หนึ่งหมื่นเก้าร้อยเจ็ดสิบหกบาทถ้วน)',
                      ttf1,
                      8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                ])),
      ],
    );
  }

  pw.Row _bCTB_210Footer(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 120,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnRight('รวมราคาทั้งสิ้น', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRightLine('รวมส่วนลด/ชาร์จท้ายบิล', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('ราคาสินค้าที่ยกเว้นภาษี', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('ราคาสินค้าที่ติดภาษี(ก่อนภาษี)', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRightLine('ภาษีมูลค่าเพิ่ม', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('จำนวนเงินรวมเงินทั้งสิ้น', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                ])),
        //pw.Spacer(),
        pw.Container(
            width: 80,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1columnRight('         11,200.00', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRightLine('           -240.00', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('            735.00', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('          9,571.03', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRightLine('           669.71', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1columnRight('         10,976.00', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                ])),
      ],
    );
  }

  pw.Container p2columnFullTaxSigned(pw.Context context, final ttf1) {
    return pw.Container(
        height: 90,
        alignment: pw.Alignment.centerRight,
        //   margin: const pw.EdgeInsets.only(top: 3.0 * PdfPageFormat.mm),
        //   padding: const pw.EdgeInsets.only(top: 3.0 * PdfPageFormat.mm),
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                top: pw.BorderSide(width: 0.5, color: PdfColors.black))),
        child: pw.Row(
          children: [
            pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right:
                            pw.BorderSide(width: 0.5, color: PdfColors.black))),
                width: 190,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: _bCTB_21FooterSign1(context, ttf1),
                      )
                    ])),
            //  pw.Spacer(),
            pw.Container(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right:
                            pw.BorderSide(width: 0.5, color: PdfColors.black))),
                width: 190,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: _bCTB_21FooterSign2(context, ttf1),
                      )
                    ])),
            pw.Container(
                width: 190,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: _bCTB_21FooterSign3(context, ttf1),
                      )
                    ])),
          ],
        ));
  }

  pw.Row _bCTB_21FooterSign1(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 190,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1column('ได้รับสินค้าครบถ้วนในภาพเรียบร้อยแล้ว', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1column('ผู้รับสินค้า(ลูกค้า)', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  pw.Padding(padding: const pw.EdgeInsets.all(16)),
                  p1column('......................................', ttf1, 8),
                ])),
      ],
    );
  }

  pw.Row _bCTB_21FooterSign2(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 190,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(6)),
                  p1column('ผู้รับเงิน / แคชเชียร์', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(22)),
                  p1column('......................................', ttf1, 8),
                ])),
      ],
    );
  }

  pw.Row _bCTB_21FooterSign3(pw.Context context, final ttf1) {
    return pw.Row(
      children: [
        pw.Container(
            width: 190,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(4)),
                  p1column('ผู้มีอำนาจลงนาม', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  p1column('บริษัท จีเนียสรีเทล จำกัด', ttf1, 8),
                  pw.Padding(padding: const pw.EdgeInsets.all(2)),
                  pw.Padding(padding: const pw.EdgeInsets.all(16)),
                  p1column('......................................', ttf1, 8),
                ])),
      ],
    );
  }

//----
  pw.Align p1column(final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Align(
      alignment: pw.Alignment.center,
      child: pw.Text(testHd, style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
    );
  }

  pw.Align p1columnRight(final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Align(
      alignment: pw.Alignment.topRight,
      child: pw.Text(testHd, style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
    );
  }

  pw.Container p1columnRightLine(
      final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Container(
        // alignment: pw.Alignment.centerRight,
        // margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
        padding: const pw.EdgeInsets.only(bottom: 0.2 * PdfPageFormat.mm),
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                bottom: pw.BorderSide(width: 0.5, color: PdfColors.black))),
        child: pw.Align(
          alignment: pw.Alignment.topRight,
          child:
              pw.Text(testHd, style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
        ));
  }

  pw.Align p1columnLEFT(final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Align(
      alignment: pw.Alignment.topLeft,
      child: pw.Text(testHd,
          style: pw.TextStyle(
            font: ttf,
            fontSize: ttfsL,
            fontWeight: FontWeight.normal,
          )),
    );
  }

  pw.Container pTitlecolumn(final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Container(
        height: 16,
        width: double.infinity,
        decoration: pw.BoxDecoration(
            border: pw.Border(
          top: pw.BorderSide(width: 1.0, color: PdfColors.black),
          bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
        )),
        child: pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(testHd,
              style: pw.TextStyle(
                font: ttf,
                fontSize: ttfsL,
                fontWeight: FontWeight.normal,
              )),
        ));
  }

  pw.Align p1columnLEFTB(final String testHd, TtfFont ttf, double ttfsL) {
    return pw.Align(
      alignment: pw.Alignment.topLeft,
      child: pw.Text(testHd,
          style: pw.TextStyle(
            font: ttf,
            fontSize: ttfsL,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  pw.Align spacer(TtfFont ttf) {
    return pw.Align(
      alignment: pw.Alignment.topLeft,
      child: pw.Text('\r\n', style: pw.TextStyle(font: ttf, fontSize: 10)),
    );
  }

  pw.Row p2columnNV(final String testHd, String testAmt, TtfFont ttf,
      TtfFont ttf9, double ttfsL) {
    return pw.Row(
      children: [
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(testHd,
                style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
          ),
        ]),
        pw.Spacer(),
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(testAmt.padLeft(20).padRight(22) + '  ',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: ttf9, fontSize: ttfsL)),
          ),
        ]),
      ],
    );
  }

  pw.Row p2column(final String testHd, String testAmt, TtfFont ttf,
      TtfFont ttf9, double ttfsL) {
    return pw.Row(
      children: [
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(testHd.padRight(30).substring(0, 29),
                style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
          ),
        ]),
        pw.Spacer(),
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(testAmt.padLeft(20).padRight(22), // + 'V',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: ttf9, fontSize: ttfsL)),
          ),
        ]),
      ],
    );
  }

  pw.Row p2columnSalesItem(final String testHd, String testAmt, TtfFont ttf,
      TtfFont ttf9, double ttfsL) {
    return pw.Row(
      children: [
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(testHd,
                style: pw.TextStyle(font: ttf, fontSize: ttfsL)),
          ),
        ]),
        pw.Spacer(),
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(testAmt.padLeft(20).padRight(22), // + 'V',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: ttf9, fontSize: ttfsL)),
          ),
        ]),
      ],
    );
  }

  pw.Row subtotal2column(
      String testPlu, String testAmt, TtfFont ttf, double ttfss, double ttfsl) {
    return pw.Row(
      children: [
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text(testPlu.padRight(30),
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(font: ttf, fontSize: ttfss)),
          ),
        ]),
        pw.Spacer(),
        pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(testAmt.padLeft(20).padRight(22) + 'V',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(font: ttf, fontSize: ttfsl)),
          ),
        ]),
      ],
    );
  }
}
