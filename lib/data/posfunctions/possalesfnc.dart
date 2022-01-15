import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posbdc_response.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/services/response/posrcp_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'fncitems.dart';

class PosSalesFnc {
  PosSalesFnc();
  final PosInput _posinput = new PosInput();
  bool funcCall(
      BuildContext context,
      String result,
      TextEditingController activeTxt,
      TextEditingController entQty,
      TextEditingController entBtnCmd,
      GetPluListResponse _reponsePluList,
      PosFncGetAitemCallResponse _responseGetItem) {
    if (result != "") {
      // _posinput.savePOSTrans(context, 10);
      var tl = activeTxt.text.length;
      if (result == "BACKSPACE") {
        if (tl > 0) {
          activeTxt.text = activeTxt.text.substring(0, tl - 1);
        } else {}
      } else if (result == Palette.btncmd_CHGP) {
        if (FncItems().isNumeric(activeTxt.text)) {
          //ชาร์จ %\r\nCharge %
          entBtnCmd.text = result + ':' + activeTxt.text;
          _responseGetItem.doGetAitem(context, 1);
        }
        activeTxt.text = "";
      } else if (result == Palette.btncmd_DISCP) {
        if (FncItems().isNumeric(activeTxt.text)) {
          //ลด %\r\nDisc. %
          entBtnCmd.text = result + ':' + activeTxt.text;
          _responseGetItem.doGetAitem(context, 1);
        }
        activeTxt.text = "";
      } else if (result == Palette.btncmd_CHGB) {
        if (FncItems().isNumeric(activeTxt.text)) {
          //ชาร์จบาท\r\nCharge
          entBtnCmd.text = result + ':' + activeTxt.text;
          _responseGetItem.doGetAitem(context, 1);
        }
        activeTxt.text = "";
      } else if (result == Palette.btncmd_DISCB) {
        if (FncItems().isNumeric(activeTxt.text)) {
          //ลดบาท\r\nDisc.Amt.
          entBtnCmd.text = result + ':' + activeTxt.text;
          _responseGetItem.doGetAitem(context, 1);
        }
        activeTxt.text = "";
      } else if (result == Palette.btncmd_DISCCP) {
        // CcpIsOkPages
        //entBtnCmd.text = result + ':' + activeTxt.text;
        FncItems().showPopSearchCCP(
            context, activeTxt.text, _responseGetItem, entBtnCmd);
      } else if (result == "*") {
        if (FncItems().isNumeric(activeTxt.text)) {
          entQty.text = activeTxt.text;
        }
        activeTxt.text = "";
      } else if (result == "CLS") {
        entQty.text = "";
        activeTxt.text = "";
      } else if (result == "ENTER") {
        //------enter plu code at POS entry
        if (activeTxt.text != "") {
          //----check member for member price
          String posMem = _posinput.getMemberIDname(context);
          if (posMem.isNotEmpty && posMem != ' ') {
            String url = PosControlFnc().getPLUurl(context) +
                '/i/' + //--must find posid again
                posMem +
                '/' +
                activeTxt.text;

            _reponsePluList.getPluList(url);
          } else {
            String url =
                PosControlFnc().getPLUurl(context) + '/' + activeTxt.text;
            _reponsePluList.getPluList(url);
          }
        } else {
          _posinput.savePOSTrans(context, 10);
        }
      } else {
        return false;
      }
    }
    return true;
  }

  bool pressKey(
      BuildContext context,
      String result,
      TextEditingController activeTxt,
      TextEditingController entQty,
      PosFncAddNewCallResponse _responseAddNew,
      GetSearchMemberResponse _responseMember,
      GetPluResponse _responsePlu,
      double sellPriceNo,
      Function doact) {
    if (result.indexOf(':') > 0) {
      var comm = result.split(":");
      if (comm[0] + comm[1] == '11') {
        if (result == "1:1:F12") {
          //--- go to receipt page from sales page!
          if (_posinput.salesItemCount(context) > 0) {
            //---send sales items and bill discount charge to sever
            //---mean to end of sales
            _posinput.savePOSTrans(context, 20);
            FncItems().showPopReceipt(context, doact);
          } else {
            normalDialog(context, 'Please take sales before!');
          }
        } else if (result == "1:1:F11") {
          //--- go to bill discount / charge page from sales page!
          if (_posinput.salesItemCount(context) > 0) {
            //---send sales items  to sever
            //---mean to end of sales
            _posinput.savePOSTrans(context, 10);
            FncItems().showPopBillDiscChg(context);
          } else {
            normalDialog(context, 'Please take sales before!');
          }
        } else if (result == "1:1:F4") {
          //--must check mbDiscMethod=2 only , and saleitem_count=0
          //--if must check mbDiscMethod=1 must from billDIscCharge only
          // showToast(context, result);
          //---check saleitems count = 0 only --
          try {
            int mbdiscmth = _posinput.getMbDisc(context);
            int salescnt = _posinput.salesItemCount(context);
            if (salescnt > 0 || mbdiscmth == 1) {
              if (salescnt > 0) {
                showToast(context, 'Member available when have not sales!');
              } else {
                showToast(context,
                    'Member discount method is available at total sales!');
              }
            } else {
              FncItems().showPopSearchMember(
                  context, _responseMember, activeTxt.text);
            }
          } catch (e) {
            showToast(context, 'Error!' + e.toString());
          }
        } else if (result == "1:1:F3") {
          FncItems().showPopSearchSalesMan(context, activeTxt.text);
        } else if (result == "1:1:F2") {
          FncItems().searchPLU(context, activeTxt.text, _responseAddNew,
              activeTxt, entQty, _responsePlu, sellPriceNo);
        }
        return true;
      }
    }
    return false;
  }

  bool funcBillDCCall(
      BuildContext context,
      String result,
      TextEditingController activeTxt,
      TextEditingController entBtnCmd,
      TextEditingController entSalesSum,
      TextEditingController entBDCSum,
      PosDBCAddNewCallResponse _responseAddNew,
      PosBDCGetBDCBResponse _responseGetItem,
      PosBDCVoidBDCBResponse _responseVoidAitem,
      int salitmax,
      int curitindex,
      Function doact) {
    int mode = PosControlFnc().getBillmode(context);
    if (result != "") {
      var tl = activeTxt.text.length;
      try {
        if (result == "BACKSPACE") {
          if (tl > 0) {
            activeTxt.text = activeTxt.text.substring(0, tl - 1);
          } else {}
        } else if (result == Palette.btncmd_CHGP) {
          if (FncItems().isNumeric(activeTxt.text)) {
            double salsum, bdcsum, netsales, actvol;
            salsum = (entSalesSum.text.isNotEmpty)
                ? double.parse(entSalesSum.text.replaceAll(',', ''))
                : 0.0;
            bdcsum = (entBDCSum.text.isNotEmpty)
                ? double.parse(entBDCSum.text.replaceAll(',', ''))
                : 0.0;
            netsales = salsum + bdcsum;
            actvol = netsales *
                ((entBDCSum.text.isNotEmpty)
                    ? double.parse(activeTxt.text.trim())
                    : 0.0) /
                100;
            //ชาร์จ %\r\nCharge %

            entBtnCmd.text = result + ':' + activeTxt.text;
            _responseGetItem.doGetBDCB(netsales, 0, actvol);
          }
          activeTxt.text = "";
        } else if (result == Palette.btncmd_DISCP) {
          if (FncItems().isNumeric(activeTxt.text)) {
            double salsum, bdcsum, netsales, actvol;
            salsum = (entSalesSum.text.isNotEmpty)
                ? double.parse(entSalesSum.text.replaceAll(',', ''))
                : 0.0;
            bdcsum = (entBDCSum.text.isNotEmpty)
                ? double.parse(entBDCSum.text.replaceAll(',', ''))
                : 0.0;
            netsales = salsum + bdcsum;
            actvol = netsales *
                ((entBDCSum.text.isNotEmpty)
                    ? double.parse(activeTxt.text.trim())
                    : 0.0) /
                100;
            //ลด %\r\nDisc. %
            entBtnCmd.text = result + ':' + activeTxt.text;

            _responseGetItem.doGetBDCB(netsales, actvol, 0);
          } else {
            return false;
          }
          activeTxt.text = "";
        } else if (result == Palette.btncmd_CHGB) {
          if (FncItems().isNumeric(activeTxt.text)) {
            double salsum, bdcsum, netsales, actvol;
            salsum = (entSalesSum.text.isNotEmpty)
                ? double.parse(entSalesSum.text.replaceAll(',', ''))
                : 0.0;
            bdcsum = (entBDCSum.text.isNotEmpty)
                ? double.parse(entBDCSum.text.replaceAll(',', ''))
                : 0.0;
            netsales = salsum + bdcsum;
            actvol = ((entBDCSum.text.isNotEmpty)
                ? double.parse(activeTxt.text.trim())
                : 0.0);
            //ชาร์จบาท\r\nCharge

            entBtnCmd.text = result + ':' + activeTxt.text;
            _responseGetItem.doGetBDCB(netsales, 0, actvol);
          }
          activeTxt.text = "";
        } else if (result == Palette.btncmd_DISCB) {
          if (FncItems().isNumeric(activeTxt.text)) {
            double salsum, bdcsum, netsales, actvol;
            salsum = (entSalesSum.text.isNotEmpty)
                ? double.parse(entSalesSum.text.replaceAll(',', ''))
                : 0.0;
            bdcsum = (entBDCSum.text.isNotEmpty)
                ? double.parse(entBDCSum.text.replaceAll(',', ''))
                : 0.0;
            netsales = salsum + bdcsum;
            actvol = ((entBDCSum.text.isNotEmpty)
                ? double.parse(activeTxt.text.trim())
                : 0.0);

            //ลดบาท\r\nDisc.Amt.
            entBtnCmd.text = result + ':' + activeTxt.text;

            _responseGetItem.doGetBDCB(netsales, actvol, 0);
          }
          activeTxt.text = "";
        } else if (result == Palette.btncmd_DISCM) {
          //-----itemtype = 20---
          if (FncItems().isNumeric(activeTxt.text)) {
            double salsum, bdcsum, netsales, actvol;
            salsum = (entSalesSum.text.isNotEmpty)
                ? double.parse(entSalesSum.text.replaceAll(',', ''))
                : 0.0;
            bdcsum = (entBDCSum.text.isNotEmpty)
                ? double.parse(entBDCSum.text.replaceAll(',', ''))
                : 0.0;
            netsales = salsum + bdcsum;
            actvol = netsales *
                ((entBDCSum.text.isNotEmpty)
                    ? double.parse(activeTxt.text.trim())
                    : 0.0) /
                100;
            //ลด %\r\nDisc. %
            entBtnCmd.text = result + ':' + activeTxt.text;

            _responseGetItem.doGetBDCB(netsales, actvol, 0);
          }
          activeTxt.text = "";
        } else if (result == Palette.btncmd_DISCCP) {
          // CcpIsOkPages
          entBtnCmd.text = result + ':' + activeTxt.text;
        } else if (result == "VOIDBCK") {
          //--check Line Index > lastsalesitem
          if (mode == 2) {
            Navigator.of(context).pop(true);
          } else {
            if (_posinput.bdcitemCount(context) > 0) {
              _responseVoidAitem.doVoidBDCBAitem(context, 1);
            } else {
              Navigator.of(context).pop(true);
            }
          }

          activeTxt.text = "";
        } else if (result == "VOIDALL") {
          if (mode == 2) {
            Navigator.of(context).pop(true);
          } else {
            if (_posinput.bdcitemCount(context) > 0) {
              _responseVoidAitem.doVoidBDCBAitem(context, -1);
            } else {
              Navigator.of(context).pop(true);
            }
          }
        } else if (result == "CLS") {
          activeTxt.text = "";
        } else if (result == "ENTER") {
        } else {
          return false;
        }
      } catch (e) {
        normalDialog(context, e.toString());
      }
    }
    return true;
  }

  bool funcBillRCPCall(
      BuildContext context,
      String result,
      TextEditingController activeTxt,
      TextEditingController entBtnCmd,
      TextEditingController entSalesSum,
      TextEditingController entBDCSum,
      PosFncVoidRCPResponse _responseVoidAitem,
      int salitmax,
      int curitindex,
      Function doact) {
    if (result != "") {
      _posinput.savePOSTrans(context, 20);
      var tl = activeTxt.text.length;
      try {
        if (result == "BACKSPACE") {
          if (tl > 0) {
            activeTxt.text = activeTxt.text.substring(0, tl - 1);
          } else {}
        } else if (result == "VOIDBCK") {
          //--check Line Index > lastsalesitem
          if (_posinput.rcpitemCount(context) > 0) {
            //void a last line
            _responseVoidAitem.doVoidRCPAitem(context, 1);
          } else {
            Navigator.of(context).pop(true);
          }
          activeTxt.text = "";
        } else if (result == "VOIDALL") {
          if (_posinput.rcpitemCount(context) > 0) {
            _responseVoidAitem.doVoidRCPAitem(context, -1);
          } else {
            Navigator.of(context).pop(true);
          }
        } else if (result == "CLS") {
          activeTxt.text = "";
        } else {
          return false;
        }
      } catch (e) {
        normalDialog(context, e.toString());
      }
    }
    return true;
  }

  void loadSalesItemFromBill(
      BuildContext context,
      PosFncAddNewCallResponse responseAddNew,
      List<GetPosTranDt> _listPostranDt) {
    try {
      if (_listPostranDt != null && _listPostranDt.length > 0) {
        for (GetPosTranDt _posTranDt in _listPostranDt) {
          //--GetPosTranDt to SalesItem
          if (_posTranDt.lineItemType == '10') {
            addSalesItemFromPosTranDt(context, responseAddNew, _posTranDt);
          } else {
            addDiscChrgFromPosTranDt(context, responseAddNew, _posTranDt);
          }
        }
      }
      // }
    } catch (e) {
      normalDialog(context, e.toString() + ' :add discount/charge item');
    }
  }

  //-----Refund item---only!
  SalesItems addSalesItemFromPosTranDt(BuildContext context,
      PosFncAddNewCallResponse responseAddNew, GetPosTranDt _posTrDt) {
    try {
      //---------------Basic Variable-----
      String saleitem = _posTrDt.itemDesc;

      String vatcode;
      if (_posTrDt.promoId.isNotEmpty) {
        vatcode = _posTrDt.itemVatType +
            '*' +
            c2rnd
                .format(_posTrDt.itemVatRate * 100)
                .replaceAll('.00', '')
                .trim() +
            ' ';
      } else {
        vatcode = _posTrDt.itemVatType +
            c2rnd
                .format(_posTrDt.itemVatRate * 100)
                .replaceAll('.00', '')
                .trim() +
            ' ';
      }
      //--new spec same slip--- + csPlus.vatRateCode;
      String vplu = _posTrDt.pluCode;
      String pludisplay = '';
      String disccode = '';
      double qty, amt, discamt, price; //, discper;
      qty = _posTrDt.qty;
      price = _posTrDt.itemNetSales / qty;

      if (qty != 1) {
        pludisplay = " (" + df.format(qty) + " @ ";
      }

      if (_posTrDt.promoId.isNotEmpty) {
        disccode = _posTrDt.promoId;
        discamt = _posTrDt.itemDiscount;
      } else {
        discamt = 0;
      }
      amt = price * qty; //after this must use round method;

      if (qty != 1) {
        pludisplay = pludisplay + oCcy.format(price) + ")";
      }

      pludisplay = vplu + ' ' + pludisplay;
      SalesItems result = SalesItems(
          saleitem,
          pludisplay,
          qty,
          price,
          disccode,
          discamt,
          amt,
          vatcode,
          _posTrDt.lineItemNo.toString(),
          _posTrDt.lineItemNo);
      if (responseAddNew != null) {
        responseAddNew.doAddNew(context, result);
      }
      return result;
    } catch (e) {
      normalDialog(context, e.toString() + ' :add sales item');
    }
    return new SalesItems('', '', 0, 0, '', 0, 0, '', '', 0);
  }

  void addDiscChrgFromPosTranDt(BuildContext context,
      PosFncAddNewCallResponse responseAddNew, GetPosTranDt _posTrDt) {
    try {
      String vatcode = 'V7';

      SalesItems result;
      if (_posTrDt.lineItemType.substring(0, 1) == '2') {
        result = SalesItems(
            _posTrDt.itemDesc,
            '',
            0,
            0,
            _posTrDt.promoId,
            _posTrDt.discamt,
            _posTrDt.discamt,
            vatcode,
            _posTrDt.refLineItemNo.toString(),
            _posTrDt.lineItemNo);
      } else {
        result = SalesItems(
            _posTrDt.itemDesc,
            '',
            0,
            0,
            _posTrDt.promoId,
            _posTrDt.chargeAmt,
            _posTrDt.chargeAmt,
            vatcode,
            _posTrDt.refLineItemNo.toString(),
            _posTrDt.lineItemNo);
      }
      if (responseAddNew != null) {
        responseAddNew.doAddNew(context, result);
      }
    } catch (e) {
      normalDialog(context, e.toString() + ' :add discount/charge item');
    }
  }

//-----------------
  SalesItems addSalesItemFromPLU(
      BuildContext context,
      PosFncAddNewCallResponse responseAddNew,
      CsPlu csPlus,
      String vqty,
      double sellPriceNo,
      PluPrice csProPrice) {
    try {
      //---------------Basic Variable-----
      String saleitem = '';
      if (csPlus.pluShortDesc != null) {
        saleitem =
            ((csPlus.pluShortDesc.isNotEmpty) ? csPlus.pluShortDesc : '') +
                ', ' +
                ((csPlus.sellUnit.isNotEmpty) ? csPlus.sellUnit : '');
      }

      String vatcode = csPlus.vatType +
          csPlus.vatRateCode +
          ' '; //--new spec same slip--- + csPlus.vatRateCode;
      String vplu = csPlus.pluCode;
      String pludisplay = '';
      String disccode = '';
      double qty, amt, discamt, price; //, discper;
      qty = 1;
      price = csPlus.sellUnitPrice1;
      if (vqty.isNotEmpty) {
        qty = double.parse(vqty);
      }
      if (qty != 1) {
        pludisplay = " (" + df.format(qty) + " @ ";
      }

      if (sellPriceNo == 1) {
        price = csPlus.sellUnitPrice1;
      } else if (sellPriceNo == 2) {
        price = csPlus.sellUnitPrice2;
      } else if (sellPriceNo == 3) {
        price = csPlus.sellUnitPrice3;
      } else if (sellPriceNo == 4) {
        price = csPlus.sellUnitPrice4;
      } else if (sellPriceNo == 5) {
        price = csPlus.sellUnitPrice5;
      } else if (sellPriceNo == 6) {
        price = csPlus.sellUnitPrice6;
      } else {
        price = csPlus.sellUnitPrice1;
      }
      //compare the best price at last!
      //--incase of mbprice no : promoPrice
      if (csProPrice != null && csProPrice.promoPrice > 0) {
        //--add discount from promotion to psPosTranDt->[itemDiscount] :24/11/21
        discamt = (csProPrice.basePriceByPos - csProPrice.promoPrice) * qty;
        price = csProPrice.promoPrice;
        //--apply disccode in lineitemtype='10' to pass varibale for [promoId]
        disccode = (csProPrice.promoId.isNotEmpty) ? csProPrice.promoId : '';
      } else {
        discamt = 0;
      }
      amt = price * qty; //after this must use round method;

      if (qty != 1) {
        pludisplay = pludisplay + oCcy.format(price) + ")";
      }

      pludisplay = vplu + ' ' + pludisplay;
      SalesItems result = SalesItems(saleitem, pludisplay, qty, price, disccode,
          discamt, amt, vatcode, 'pcs', 0); //csPlus.sellUnit);
      responseAddNew.doAddNew(context, result);
      return result;
    } catch (e) {
      normalDialog(context, e.toString() + ' :add sales item');
    }
    return new SalesItems('', '', 0, 0, '', 0, 0, '', '', 0);
  }

  void addDiscChrgFromsaleItem(BuildContext context,
      PosFncAddNewCallResponse responseAddNew, SalesItems _selectSalesitem) {
    try {
      responseAddNew.doAddNew(context, _selectSalesitem);
    } catch (e) {
      normalDialog(context, e.toString() + ' :add discount/charge item');
    }
  }

  void addDiscChrgFromBDCItem(BuildContext context,
      PosDBCAddNewCallResponse responseAddNew, SalesItems _selectSalesitem) {
    try {
      responseAddNew.doAddNew(context, _selectSalesitem);
    } catch (e) {
      normalDialog(context, e.toString() + ' :add discount/charge item');
    }
  }

  void addReceitpItem(BuildContext context,
      PosRCPAddNewCallResponse responseAddNew, SalesItems _selectSalesitem) {
    try {
      responseAddNew.doAddNew(context, _selectSalesitem);
    } catch (e) {
      normalDialog(context, e.toString() + ' :add discount/charge item');
    }
  }

  SalesItems btncmdresult(
      BuildContext context, SalesItems lslit, String btncmd) {
    SalesItems result;
    try {
      if (btncmd != '') {
        List<String> btncmds = btncmd.split(':');
        String detail = "";
        if (btncmds.length > 0) {
          double cmdv, cmdamt;
          cmdv = double.parse(btncmds[1]);
          //----check itemtype accept '10', salesitem
          if (btncmds[0] == Palette.btncmd_CHGP) {
            //-----itemtype = 31---
            cmdamt = (cmdv / 100) * lslit.amount;
            detail = Palette.dischg_space +
                Palette.lblcmd_CHGP +
                pCcy.format(cmdv / 100);
          } else if (btncmds[0] == Palette.btncmd_CHGB) {
            //-----itemtype = 32---
            cmdamt = cmdv;
            detail = Palette.dischg_space +
                Palette.lblcmd_CHGB; // + oCcy.format(cmdv);
          } else if (btncmds[0] == Palette.btncmd_DISCM) {
            //-----itemtype = 20---
            cmdamt = (-1) * cmdv * lslit.amount;
            detail =
                Palette.dischg_space + Palette.lblcmd_DISCM + pCcy.format(cmdv);
          } else if (btncmds[0] == Palette.btncmd_DISCP) {
            //-----itemtype = 21---

            cmdamt = (-1) * (cmdv / 100) * lslit.amount;
            detail = Palette.dischg_space +
                Palette.lblcmd_DISCP +
                pCcy.format(cmdv / 100);
          } else if (btncmds[0] == Palette.btncmd_DISCB) {
            cmdamt = (-1) * cmdv;
            //-----itemtype = 22---
            detail = Palette.dischg_space +
                Palette.lblcmd_DISCB; //+ oCcy.format(cmdv);
          } else if (btncmds[0] == Palette.btncmd_DISCCP) {
            cmdamt = (-1) * (cmdv / 100) * lslit.amount;
            String ccpNo = btncmds[2];
            detail = Palette.dischg_space + Palette.lblcmd_DISCCP + ccpNo;
          } else if (btncmds[0] == Palette.btncmd_DISCCB) {
            cmdamt = (-1) * cmdv;
            String ccpNo = btncmds[2];
            detail = Palette.dischg_space + Palette.lblcmd_DISCCB + ccpNo;
          } else {
            //---receipt---
            cmdamt = cmdv;
            detail = btncmds[0];
          }
          //---Get rounded---(get mode from Pos Config, id.=53 and getRoundAmt)

          int mode = _posinput.getDiscRoundMode(context);
          cmdamt = _posinput.getRoundAmt(cmdamt, mode);

          //-----plu = itemtypeCode + ':' + plu > will check when save item , not save this.plu!
          result = new SalesItems(detail, btncmds[0] + ':' + lslit.plu, 0.0,
              0.0, btncmds[0], cmdv, cmdamt, lslit.vatcode, 'Pcs', 0);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }
}
