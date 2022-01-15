import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posfuncsctrl.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:provider/provider.dart';

class PosInput {
  PosInput();
  TextEditingController txtPlu = new TextEditingController();
  TextEditingController txtTable = new TextEditingController();
  TextEditingController txtQty = new TextEditingController();
  TextEditingController txtUser = new TextEditingController();
  TextEditingController txtPass = new TextEditingController();
//----Sales-member-ok----
  TextEditingController txtMemberCode = new TextEditingController();
  TextEditingController txtMemberName = new TextEditingController();
  TextEditingController txtMemberType = new TextEditingController();
  TextEditingController txtMemberBD = new TextEditingController();
  TextEditingController txtMemberCurPoint = new TextEditingController();
  TextEditingController txtMemebrCurCash = new TextEditingController();
  TextEditingController txtMemberMemory = new TextEditingController();
  TextEditingController txtMemberExpireDate = new TextEditingController();
  //----Search-member-list--
  TextEditingController txtMemberSearch = new TextEditingController();
  //-------Bill-DiscountCharge---&--BILL-RECEIPTS---------------------
  TextEditingController txt1 = new TextEditingController();
  TextEditingController txt2 = new TextEditingController();
  TextEditingController txt3 = new TextEditingController();
  TextEditingController txt4 = new TextEditingController();
  TextEditingController txt5 = new TextEditingController();
  TextEditingController txt6 = new TextEditingController();
  TextEditingController txt7 = new TextEditingController();
  TextEditingController txt8 = new TextEditingController();
  TextEditingController txt9 = new TextEditingController();

  FocusNode focusnode = FocusNode();
  PosButton mainmenuData = stdButtuon0[0];
  PosButton retailGrpPanel = stdButtuon4[2];
  PosButton restuantGrpPanel = stdButtuon2[2];
  List<TableUsage> restTableusageList = <TableUsage>[];

  double salesPriceNo = 1;

  final kTableColumn1 = <DataColumn>[
    DataColumn(
      label: Text(''),
    ),
  ];

  final kTableColumn3 = <DataColumn>[
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
  ];

  final kTableColumn5 = <DataColumn>[
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
    DataColumn(
      label: Text(''),
    ),
  ];

  final kTableColumnRTsales = <DataColumn>[
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'รายการสินค้า\r\n',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'รหัสสินค้า/(จำนวน @ ราคาต่อหน่วย)\r\n',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'จำนวนเงิน\r\n',
            textAlign: TextAlign.left,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Text(''),
    ),
  ];

  final kTableColumBilDisChg = <DataColumn>[
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            '          รายการสินค้า\r\n',
            textAlign: TextAlign.left,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'จำนวนเงิน\r\n',
            textAlign: TextAlign.right,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
  ];

  final kTableColumRest = <DataColumn>[
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            '          รายการสินค้า\r\n',
            textAlign: TextAlign.left,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'จำนวนเงิน\r\n',
            textAlign: TextAlign.right,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
  ];

  final kTableColumnFullSales = <DataColumn>[
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'รายการสินค้า\r\n',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'รหัสสินค้า/(จำนวน @ ราคาต่อหน่วย)\r\n',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'รายการส่วนลด/ชาร์จ\r\n',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Expanded(
          child: Text(
            'จำนวนเงิน\r\n',
            textAlign: TextAlign.left,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Text(''),
    ),
  ];

  final kTableColumnSearchMBList = <DataColumn>[
    DataColumn(
      label: Container(
        width: 60,
        child: Expanded(
          child: Text(
            'ลำดับ',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Container(
        width: 60,
        child: Expanded(
          child: Text(
            'รหัสสมาชิก',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Container(
        width: 60,
        child: Expanded(
          child: Text(
            'ชื่อสมาชิก',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    )
  ];

  final kTableColumnSearchPOSCTRLList = <DataColumn>[
    DataColumn(
      label: Container(
        width: 160,
        child: Expanded(
          child: Text(
            'CONFIG.ID',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Container(
        width: 200,
        child: Expanded(
          child: Text(
            'CONFIG.VALUE',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    )
  ];

  final kTableColumnSearchCCPList = <DataColumn>[
    DataColumn(
      label: Container(
        width: 60,
        child: Expanded(
          child: Text(
            '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
    DataColumn(
      label: Container(
        width: 160,
        child: Expanded(
          child: Text(
            '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontFamily: 'Micrsoft Sans Serif',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    ),
  ];

  static Widget posInputField(
      {String initialValue = "",
      Function(String) onSaved,
      String hint,
      bool hide = false,
      Icon prefixIcon,
      Widget suffixIcon,
      bool enabled = true,
      TextInputType textInputType = TextInputType.emailAddress,
      Function(bool) onSuffixIconClick,
      Function(String) validator}) {
    return SizedBox(
      child: TextFormField(
        initialValue: initialValue,
        obscureText: hide,
        onSaved: onSaved,
        enabled: enabled,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: enabled ? Colors.white : Colors.grey,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 1.0),
          ),
          hintText: hint,
        ),
        validator: validator,
        keyboardType: textInputType,
        style: CsiStyle.titleStyle(enabled ? Colors.white : Colors.white),
      ),
    );
  }

  SalesItems getSalesItem(SalesItem _hiveSalesitem) {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;
    String plu, itemtype, salesitem, disccode, vatcode;
    double qty, price, amount, disc;
    plu = '';
    itemtype = '';
    salesitem = '';
    disccode = '';
    vatcode = '';
    qty = 1;
    price = 0;
    amount = 0;
    disc = 0;
    if (_hiveSalesitem.saleskey != "null") {
      //----tablekey
      var t = _hiveSalesitem.saleskey.split(']');
      if (t.length > 1) {
        itemtype = t[1];
      }
      if (itemtype == '10') {
        plu = t[0];
      }
      //----tableinfo
      var f = _hiveSalesitem.salesinfo.split(']');
      if (f.length > 0) {
        salesitem = f[0];
      }
      if (f.length > 1) {
        disccode = f[1];
      }
      if (f.length > 2) {
        vatcode = f[2];
      }
      //----tabledata
      var l = _hiveSalesitem.salesdata.split(']');
      if (l.length > 0) {
        qty = double.parse(l[0]);
      }
      if (l.length > 1) {
        price = double.parse(l[1]);
      }
      if (l.length > 2) {
        amount = double.parse(l[2]);
      }
      if (l.length > 3) {
        disc = double.parse(l[3]);
      }
    }

    SalesItems _constSalesitem = new SalesItems(
        salesitem, plu, qty, price, disccode, disc, amount, vatcode, 'Pcs', 0);
    return _constSalesitem;
    //-----------------------------------------------------------------
  }

  int checkLastSalesItem(SalesItem _hiveSalesitem) {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;
    String salesitemtype = '';

    if (_hiveSalesitem != null) {
      if (_hiveSalesitem.saleskey.isNotEmpty) {
        var t = _hiveSalesitem.saleskey.split(']');
        if (t.length > 1) {
          salesitemtype = t[1];
          if (salesitemtype.isNotEmpty && salesitemtype.trim() != '') {
            return int.parse(salesitemtype);
            //return 10;
          }
        }
      }
      //----tablekey

    }
    return -1;
  }

  SalesItems getNullSalesItem() {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;

    SalesItems _constSalesitem =
        new SalesItems('', '', 0.0, 0.0, '', 0.0, 0.0, '', '', 0);
    return _constSalesitem;
    //-----------------------------------------------------------------
  }

//----List of Sales, BillDiscChg, Receipt
  List<SalesItems> getSalesList(BuildContext context) {
    //List<SalesItems> sl;
    List<SalesItems> list = new List<SalesItems>();
    int itemcounts = 0;
    var model = Provider.of<SalesItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;
    itemcounts = _hiveSalesitems.length;
    if (itemcounts > 0) {
      try {
        for (var _hiveSalesitem in _hiveSalesitems) {
          if (_hiveSalesitem.saleskey != "null") {
            SalesItems _constSalesitem = getSalesItem(_hiveSalesitem);
            list.add(_constSalesitem);
          }
        }
      } catch (e) {
        showToast(context, e.toString());
      }
    }
    return list;
  }

  List<SalesItems> getBDCList(BuildContext context) {
    List<SalesItems> list = new List<SalesItems>();
    int itemcounts = 0;
    var model = Provider.of<BillDCItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;
    itemcounts = _hiveSalesitems.length;
    if (itemcounts > 0) {
      for (var _hiveSalesitem in _hiveSalesitems) {
        if (_hiveSalesitem.saleskey != "null") {
          list.add(getSalesItem(_hiveSalesitem));
        }
      }
    }

    return list;
  }

  List<SalesItems> getReceiptList(BuildContext context) {
    List<SalesItems> list = new List<SalesItems>();
    int itemcounts = 0;
    var model = Provider.of<ReceiptItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;
    itemcounts = _hiveSalesitems.length;
    if (itemcounts > 0) {
      for (var _hiveSalesitem in _hiveSalesitems) {
        if (_hiveSalesitem.salesdata != "null") {
          list.add(getSalesItem(_hiveSalesitem));
        }
      }
    }
    return list;
  }

//----Count
  int salesItemCount(BuildContext context) {
    var model = Provider.of<SalesItemHiveModel>(context, listen: false);
    return model.inventoryList.length;
  }

  int bdcitemCount(BuildContext context) {
    var model = Provider.of<BillDCItemHiveModel>(context, listen: false);
    return model.inventoryList.length;
  }

  int rcpitemCount(BuildContext context) {
    var model = Provider.of<ReceiptItemHiveModel>(context, listen: false);
    return model.inventoryList.length;
  }

//------Save PosTrans
  Future<int> savePOSTrans(BuildContext context, int mode) {
    //---mode : 1-sales items, 2-Bill Discount Charge items, 3- Receipt items
    // int lsalesitem = 0;
    PosFunctionCtrl wsfnc = new PosFunctionCtrl();
    String cashier, docno, refdocno, docnoVE, posid, pluUrl;
    refdocno = '';
    try {
      cashier = PosControlFnc().getConfigCashier(context);
      int modeOfBill = PosControlFnc().getBillmode(context);
      if (modeOfBill == 2) {
        docno = PosControlFnc().getRunno(context, MyConfig().a_cycleRfndBegEnd);
        List<String> _docno = docno.replaceAll('\r\n', ':').split(':');
        if (_docno.length > 0) {
          docno = _docno[0].trim();
        }
        if (_docno.length > 1) {
          refdocno = _docno[1].trim();
        }
      } else {
        docno = PosControlFnc().getRunno(context, MyConfig().a_cycleRcptBegEnd);
      }
      //---set stamp for temp transaction with add '-EV'
      //---Temp trans for cal. VatExclude or second monitor usage
      docnoVE = docno + '-EV';

      PosCtrl posctrlPosId = posCtrlList[MyConfig().i_posId];
      posid =
          PosControlFnc().getCurrentSettingValues(context, posctrlPosId).trim();
      pluUrl = PosControlFnc().getPLUurl(context);
      pluUrl = pluUrl.replaceAll('/getsaleitem', '');
      String salesVatType = PosControlFnc().getSalesVateType(context);

      //-------Clear all temp trans
      if (mode == 0) {
        //---Clear when go back to sales pages
        clearTempTrans(context, wsfnc, pluUrl, posid, docnoVE);
        // String initBill =
        //     pluUrl + '/savePosTrans/' + posid + '/' + docnoVE + '/S/0/ALL';
        // wsfnc.savePosTranWS(initBill, 0);
      }
      //-------------Save PostranDT ------

      if (mode == 10) {
        //---send SALES ITEM temp trans to server
        //---Clear when go back to sales pages
        // String initBill =
        //     pluUrl + '/savePosTrans/' + posid + '/' + docnoVE + '/S/0/ALL';
        // wsfnc.savePosTranWS(initBill, 0);
        //--save Temp for cal. VatExclude
        SavePosTranDt(context, wsfnc, pluUrl, posid, docnoVE, cashier);
      } //else {
      //-------------Save PostranDisc ------

      if (mode == 20) {
        //---send SALES ITEM and Bill Discount/Charge  temp trans to server
        //---Clear all temp trans
        // String initBill =
        //     pluUrl + '/savePosTrans/' + posid + '/' + docnoVE + '/S/0/ALL';
        // wsfnc.savePosTranWS(initBill, 0);
        // //--save Temp for cal. VatExclude
        // SavePosTranDt(context, wsfnc, pluUrl, posid, docnoVE, cashier);
        SavePosTranDisc(context, wsfnc, pluUrl, posid, docnoVE, cashier);
      } //else {
      //-------------Save PostranRecv ------
      if (mode == 40) {
        //---Clear all temp trans
        clearTempTrans(context, wsfnc, pluUrl, posid, docnoVE);
        // String initBill =
        //     pluUrl + '/savePosTrans/' + posid + '/' + docnoVE + '/S/0/ALL';
        // wsfnc.savePosTranWS(initBill, 0);

        //--save all postrans. to SERVER for ending this docno.
        SavePosTranDt(context, wsfnc, pluUrl, posid, docno, cashier);
        SavePosTranDisc(context, wsfnc, pluUrl, posid, docno, cashier);
        SavePosTranRecv(context, wsfnc, pluUrl, posid, docno, cashier);

        String shiftId = PosControlFnc().getShiftId(context);
        String cashBegInOut = PosControlFnc().getCashBegInOut(context);

        SavePosTranHd(context, wsfnc, pluUrl, posid, docno, refdocno, cashier,
            shiftId, cashBegInOut, salesVatType, modeOfBill);
      }
      // }
      //}
    } catch (e) {
      showToast(
          context, e.toString() + ':posinput.savePOSTrans' + mode.toString());
    }
    //-------------Update PosControl ------ UpdatePosControl
  }

  void clearTempTrans(BuildContext context, PosFunctionCtrl wsfnc,
      String pluUrl, String posid, String docnoVE) {
    // PosFunctionCtrl wsfnc = new PosFunctionCtrl();

    String initBill =
        pluUrl + '/savePosTrans/' + posid + '/' + docnoVE + '/S/0/ALL';
    wsfnc.savePosTranWS(initBill, 0);
  }

  void SavePosTranHd(
      BuildContext context,
      PosFunctionCtrl wsfnc,
      String pluUrl,
      String posid,
      String docno,
      String refdocno,
      String cashier,
      String shiftId,
      String cashBegInOut,
      String saleVatType,
      int modeOfBill) {
    //---mode : 1-sales items, 2-Bill Discount Charge items, 3- Receipt items
    String dataSentUrl;
    String cashierId, memid, slmnid;
    PosCtrl posctrl62 = posCtrlList[MyConfig().i_configCashier];

    //----
    String curCashier =
        PosControlFnc().getCurrentSettingValues(context, posctrl62);

    PosCtrl posctrl63 = posCtrlList[MyConfig().i_configSaleman]; //Salesman
    String curSalesman =
        PosControlFnc().getCurrentSettingValues(context, posctrl63);

    PosCtrl posctrl64 = posCtrlList[MyConfig().i_configMember]; //Member
    String curMember =
        PosControlFnc().getCurrentSettingValues(context, posctrl64);
//--
    try {
      cashierId = (curCashier.split('-').length > 1)
          ? curCashier.split('-')[0].trim()
          : '';
      memid = (curMember.split('-').length > 1)
          ? curMember.split('-')[0].trim()
          : '';
      slmnid = (curSalesman.split('-').length > 1)
          ? curSalesman.split('-')[0].trim()
          : '';
      //---will get from psPara
      // saleVatType = salesVatType;
      //(mode == 1) ? 'I' : 'E';
      //---will add when is Refund Doc.
      if (modeOfBill == 2) {
        dataSentUrl = refundsaveHd(context, pluUrl, posid, docno, saleVatType,
            1, cashierId, refdocno, memid, slmnid, shiftId, cashBegInOut);
      } else {
        dataSentUrl = transaveHd(context, pluUrl, posid, docno, saleVatType, 1,
            cashierId, refdocno, memid, slmnid, shiftId, cashBegInOut);
      }

      wsfnc.savePosTranWS(dataSentUrl, modeOfBill);
      // showToast(context, dataSentUrl);
    } catch (e) {
      showToast(context,
          dataSentUrl + ':posinput.wsfnc.savePosTranWS:saveHD:' + e.toString());
    }
  }

  String refundsaveHd(
      BuildContext context,
      String pluUrl,
      String posid,
      String docno,
      String saleVatType,
      double totalverify,
      String cashier,
      String refdocno,
      String memberid,
      String salemanid,
      String shiftId,
      String cashBegInOut) {
    //---WS. at [url]/saveAposTrans/[docno]/E/lineCount/data - SaleVatType/VerifyTotal/Cashier/RefDocno/MbId/SalemanId
    //http://127.0.0.1:9393/savePosTrans/00121/1GS00200122000003/E/1/I]1]002]]]]
    String r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    r3 = '(VATT)'; //@SaleVateType
    r4 = '(TOVR)'; //@TotalVerify
    r5 = '(CSH)'; //@Cashier
    r6 = '(RFD)'; //@RefDocNo
    r7 = '(MBI)'; //@MbId
    r8 = '(SMI)'; //@SalesmanId
    r9 = '(SID)';
    rA = '(CBI)';
    rB = '(CBO)';

    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/R/1/' +
        r3 +
        ']' +
        r4 +
        ']' +
        r5 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        rA +
        ']' +
        rB +
        ']' +
        r9;
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      List<String> cash = cashBegInOut.split(':');
      String cashin, cashout;
      if (cash.length > 1) {
        cashin = cash[1].replaceAll(',', '');
        if (!FncItems().isNumeric(cashin)) {
          cashin = '0.0';
        }
      }
      if (cash.length > 2) {
        cashout = cash[2].replaceAll(',', '');
        if (!FncItems().isNumeric(cashout)) {
          cashout = '0.0';
        }
      }

      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r3, saleVatType);
      dataSentUrl = dataSentUrl.replaceAll(r4, c2rnd.format(totalverify));
      dataSentUrl = dataSentUrl.replaceAll(r5, cashier);
      dataSentUrl =
          dataSentUrl.replaceAll(r6, (refdocno == null ? '' : refdocno));
      dataSentUrl =
          dataSentUrl.replaceAll(r7, (memberid == null ? '' : memberid.trim()));
      dataSentUrl = dataSentUrl.replaceAll(
          r8, (salemanid == null ? '' : salemanid.trim()));
      dataSentUrl =
          dataSentUrl.replaceAll(rA, (cashin == null ? '0' : cashin.trim()));
      dataSentUrl =
          dataSentUrl.replaceAll(rB, (cashout == null ? '0' : cashout.trim()));
      return dataSentUrl.replaceAll(
          r9, (shiftId == null ? '0' : shiftId.trim()));
    } catch (e) {
      showToast(
          context,
          dataSentUrl +
              ':posinput.wsfnc.savePosTranWS:replacement:' +
              e.toString());
    }
    return '';
  }

  String transaveHd(
      BuildContext context,
      String pluUrl,
      String posid,
      String docno,
      String saleVatType,
      double totalverify,
      String cashier,
      String refdocno,
      String memberid,
      String salemanid,
      String shiftId,
      String cashBegInOut) {
    //---WS. at [url]/saveAposTrans/[docno]/E/lineCount/data - SaleVatType/VerifyTotal/Cashier/RefDocno/MbId/SalemanId
    //http://127.0.0.1:9393/savePosTrans/00121/1GS00200122000003/E/1/I]1]002]]]]
    String r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    r3 = '(VATT)'; //@SaleVateType
    r4 = '(TOVR)'; //@TotalVerify
    r5 = '(CSH)'; //@Cashier
    r6 = '(RFD)'; //@RefDocNo
    r7 = '(MBI)'; //@MbId
    r8 = '(SMI)'; //@SalesmanId
    r9 = '(SID)';
    rA = '(CBI)';
    rB = '(CBO)';

    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/E/1/' +
        r3 +
        ']' +
        r4 +
        ']' +
        r5 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        rA +
        ']' +
        rB +
        ']' +
        r9;
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      List<String> cash = cashBegInOut.split(':');
      String cashin, cashout;
      if (cash.length > 1) {
        cashin = cash[1].replaceAll(',', '');
        if (!FncItems().isNumeric(cashin)) {
          cashin = '0.0';
        }
      }
      if (cash.length > 2) {
        cashout = cash[2].replaceAll(',', '');
        if (!FncItems().isNumeric(cashout)) {
          cashout = '0.0';
        }
      }

      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r3, saleVatType);
      dataSentUrl = dataSentUrl.replaceAll(r4, c2rnd.format(totalverify));
      dataSentUrl = dataSentUrl.replaceAll(r5, cashier);
      dataSentUrl =
          dataSentUrl.replaceAll(r6, (refdocno == null ? '' : refdocno));
      dataSentUrl =
          dataSentUrl.replaceAll(r7, (memberid == null ? '' : memberid.trim()));
      dataSentUrl = dataSentUrl.replaceAll(
          r8, (salemanid == null ? '' : salemanid.trim()));
      dataSentUrl =
          dataSentUrl.replaceAll(rA, (cashin == null ? '0' : cashin.trim()));
      dataSentUrl =
          dataSentUrl.replaceAll(rB, (cashout == null ? '0' : cashout.trim()));
      return dataSentUrl.replaceAll(
          r9, (shiftId == null ? '0' : shiftId.trim()));
    } catch (e) {
      showToast(
          context,
          dataSentUrl +
              ':posinput.wsfnc.savePosTranWS:replacement:' +
              e.toString());
    }
    return '';
  }

  void SavePosTranDt(BuildContext context, PosFunctionCtrl wsfnc, String pluUrl,
      String posid, String docno, String cashier) {
    try {
      int itemCount, itemcounts, disccount;
      var model = Provider.of<SalesItemHiveModel>(context, listen: false);
      List<SalesItem> _hiveSalesitems = model.inventoryList;
      String salesdesc, plu, unit, vatcode, disccode;
      double qty, price, amount, disc, charge, vat;

      disccount = 0;
      itemcounts = _hiveSalesitems.length;
      int lineno = 0;
      int lineRefno = 1;
      var itemtype;
      int mode = int.parse(docno.substring(0, 1));
      if (itemcounts > 0) {
        // for (int i = 0; i <= itemcounts; ++i) {
        //   SalesItem _hiveSalesitem = _hiveSalesitems[
        //       i]; //solve read from last to first of hivefile data.
        for (var _hiveSalesitem in _hiveSalesitems) {
          qty = 1;
          price = 0;
          disc = 0;
          charge = 0;
          amount = 0;
          vat = 0;

          unit = 'pcs';
          salesdesc = '';
          disccode = '';
          vatcode = '';
          plu = '';

          if (_hiveSalesitem.saleskey != "null") {
            var t, f, l, er;
            try {
              t = _hiveSalesitem.saleskey.split(']');

              if (t.length > 1) {
                itemtype = t[1];
              }
              if (itemtype == '10') {
                plu = t[0];
              }

              //----tableinfo
              f = _hiveSalesitem.salesinfo.split(']');
              if (f.length > 0) {
                salesdesc = f[0];
              }
              if (f.length > 1) {
                disccode = f[1];
              }
              if (f.length > 2) {
                vatcode = f[2];
              }
              //----tabledata
              l = _hiveSalesitem.salesdata.split(']');
              if (l.length > 0) {
                qty = double.parse(l[0]);
              }
              if (l.length > 1) {
                price = double.parse(l[1]);
              }
              if (l.length > 2) {
                amount = double.parse(l[2]);
              }
              if (l.length > 3) {
                disc = double.parse(l[3]);
              }
            } catch (er) {
              showToast(context,
                  er.toString() + ':posinput.wsfnc.savePosTranWS:getValues');
            }
            if (itemtype.isNotEmpty) {
              String dataSentUrl;
              if (itemtype == '10') {
                lineno += 1;
                if (mode == 2) {
                  if (t.length > 2) {
                    //unit = t[2];
                    lineRefno = int.parse(t[2]);
                  }
                } else {
                  lineRefno = 0;
                }
                //---add lineRefno
                dataSentUrl = itemtype10(
                    pluUrl,
                    posid,
                    docno,
                    lineno,
                    salesdesc,
                    cashier,
                    plu,
                    disccode,
                    qty,
                    amount,
                    price,
                    disc,
                    vatcode,
                    unit);
                try {
                  wsfnc.savePosTranWS(dataSentUrl, 1);
                  // showToast(context, dataSentUrl);
                } catch (e) {
                  showToast(
                      context,
                      dataSentUrl +
                          ':posinput.wsfnc.savePosTranWS:DataType:10');
                }
              } else {
                //--seperate itemtype '2x' or '3x'
                double damt, camt, dpc, cpc;
                dpc = 0;
                cpc = 0;

                if (itemtype.toString().substring(0, 1) == '2') {
                  damt = amount;
                  camt = 0;
                  dpc = checkPCfromEndStringwithPC(salesdesc);
                } else {
                  damt = 0;
                  camt = amount;
                  cpc = checkPCfromEndStringwithPC(salesdesc);
                }

                //--
                dataSentUrl = itemtype2X(pluUrl, posid, docno, itemtype, lineno,
                    '', plu, disccode, dpc, damt, cpc, camt, salesdesc);

                try {
                  wsfnc.savePosTranWS(dataSentUrl, 1);
                  // showToast(context, dataSentUrl);
                } catch (e) {
                  showToast(
                      context,
                      dataSentUrl +
                          ':posinput.wsfnc.savePosTranWS:DataType:2X,3X');
                }
              }
            }
          }
        }
      } else {}
    } catch (e) {
      showToast(context, e.toString() + ':posinput.savePOSTrans DT');
    }
  }

  void SavePosTranDisc(BuildContext context, PosFunctionCtrl wsfnc,
      String pluUrl, String posid, String docno, String cashier) {
    try {
      int itemCount, itemcounts, disccount;
      var model = Provider.of<BillDCItemHiveModel>(context, listen: false);
      List<SalesItem> _hiveSalesitems = model.inventoryList;
      String salesdesc, plu, unit, vatcode, disccode;
      double qty, price, amount, disc, charge, vat;

      disccount = 0;
      itemcounts = _hiveSalesitems.length;
      int iRefNo = 0;
      var itemtype;
      if (itemcounts > 0) {
        // for (int i = 0; i < itemcounts; i++) {
        //   SalesItem _hiveSalesitem = _hiveSalesitems[
        //       i]; //solve read from last to first of hivefile data.
        for (var _hiveSalesitem in _hiveSalesitems) {
          qty = 1;
          price = 0;
          disc = 0;
          charge = 0;
          amount = 0;
          vat = 0;

          unit = 'pcs';
          salesdesc = '';
          disccode = '';
          vatcode = '';
          plu = '';

          if (_hiveSalesitem.saleskey != "null") {
            var t, f, l, er;
            try {
              t = _hiveSalesitem.saleskey.split(']');
              if (t != null) {
                if (t.length > 1) {
                  itemtype = t[1];
                }
                if (itemtype == '10') {
                  plu = t[0];
                }
              }

              //----tableinfo
              f = _hiveSalesitem.salesinfo.split(']');
              if (f != null) {
                if (f.length > 0) {
                  salesdesc = f[0];
                }
                if (f.length > 1) {
                  disccode = f[1];
                }
                if (f.length > 2) {
                  vatcode = f[2];
                }
              }

              //----tabledata
              l = _hiveSalesitem.salesdata.split(']');
              if (l != null) {
                if (l.length > 0) {
                  qty = double.parse(l[0]);
                }
                if (l.length > 1) {
                  price = double.parse(l[1]);
                }
                if (l.length > 2) {
                  amount = double.parse(l[2]);
                }
                if (l.length > 3) {
                  disc = double.parse(l[3]);
                }
              }
            } catch (er) {
              showToast(context,
                  er.toString() + ':posinput.wsfnc.savePosTranWS:getValues');
            }
            if (itemtype.isNotEmpty && er == null) {
              String dataSentUrl;
              // if (itemtype == '10') {
              iRefNo += 1;

              //--seperate itemtype '2x' or '3x'
              double damt, camt, dpc, cpc;
              dpc = 0;
              cpc = 0;

              if (itemtype.toString().substring(0, 1) == '2') {
                damt = amount;
                camt = 0;
                dpc = checkPCfromEndStringwithPC(salesdesc);
              } else {
                damt = 0;
                camt = amount;
                cpc = checkPCfromEndStringwithPC(salesdesc);
              }

              //--
              dataSentUrl = itemtypeB(pluUrl, posid, docno, itemtype, iRefNo,
                  '', plu, disccode, dpc, damt, cpc, camt);

              try {
                wsfnc.savePosTranWS(dataSentUrl, 1);
                //  showToast(context, dataSentUrl);
              } catch (e) {
                showToast(context,
                    dataSentUrl + ':posinput.wsfnc.savePosTranWS:sentData');
              }
              //}
            }
          }
        }
      } else {}
    } catch (e) {
      showToast(context, e.toString() + ':posinput.savePOSTrans DISC');
    }
  }

  void SavePosTranRecv(BuildContext context, PosFunctionCtrl wsfnc,
      String pluUrl, String posid, String docno, String cashier) {
    try {
      int itemCount, itemcounts, disccount;
      var model = Provider.of<ReceiptItemHiveModel>(context, listen: false);
      List<SalesItem> _hiveSalesitems = model.inventoryList;
      String salesdesc, plu, paytype, vatcode, disccode;
      double qty, price, amount, disc, charge, vat;

      disccount = 0;
      itemcounts = _hiveSalesitems.length;
      int iRefNo = 0;
      var itemtype;
      if (itemcounts > 0) {
        // for (int i = 0; i < itemcounts; i++) {
        //   SalesItem _hiveSalesitem = _hiveSalesitems[
        //       i]; //solve read from last to first of hivefile data.
        for (var _hiveSalesitem in _hiveSalesitems) {
          qty = 1;
          price = 0;
          disc = 0;
          charge = 0;
          amount = 0;
          vat = 0;

          paytype = '';
          salesdesc = '';
          disccode = '';
          vatcode = '';
          plu = '';

          if (_hiveSalesitem.saleskey != "null") {
            var t, f, l, er;
            try {
              t = _hiveSalesitem.saleskey.split(']');

              if (t != null) {
                if (t.length > 0) {
                  plu = t[0];
                }
                if (t.length > 1) {
                  itemtype = t[1];
                }

                if (t.length > 2) {
                  paytype = t[2];
                  if (paytype == 'Pcs') {
                    paytype = '1';
                  }
                }
              }

              //----tableinfo
              f = _hiveSalesitem.salesinfo.split(']');
              if (f != null) {
                if (f.length > 0) {
                  salesdesc = f[0];
                }
                if (f.length > 1) {
                  disccode = f[1];
                }
                if (f.length > 2) {
                  vatcode = f[2];
                }
              }

              //----tabledata
              l = _hiveSalesitem.salesdata.split(']');
              if (l != null) {
                // if (l.length > 0) {
                //   qty = double.parse(l[0]);
                // }
                // if (l.length > 1) {
                //   price = double.parse(l[1]);
                // }
                if (l.length > 2) {
                  amount = double.parse(l[2]);
                }
                // if (l.length > 3) {
                //   disc = double.parse(l[3]);
                // }

                // if (t.length > 1) {
                //   itemtype = t[1].trim();
                // }
              }
            } catch (er) {
              showToast(
                  context,
                  er.toString() +
                      ':posinput.wsfnc.savePosTranWS:getValues  RECV');
            }
            if (itemtype.isNotEmpty && er == null) {
              String dataSentUrl;
              // if (itemtype == '10') {
              iRefNo += 1;
              try {
                if (disccode.isNotEmpty && disccode.contains('#')) {
                  String paydesc = disccode;
                  plu = paydesc.split('#')[0];
                  disccode = paydesc.split('#')[1];
                }
                if (disccode.isNotEmpty && disccode.contains(':')) {
                  disccode = disccode.split(':')[0];
                }
                if (plu.isNotEmpty && plu.contains(':')) {
                  plu = plu.split(':')[0];
                }
              } catch (e) {
                plu = '';
                disccode = '';
              }
              try {
                dataSentUrl = itemtypeR(pluUrl, posid, docno, paytype, iRefNo,
                    plu, disccode, amount, 0, '', 0, 0);

                wsfnc.savePosTranWS(dataSentUrl, 1);
                //  showToast(context, dataSentUrl);
              } catch (e) {
                showToast(
                    context,
                    dataSentUrl +
                        ':posinput.wsfnc.savePosTranWS:sentData  RECV');
              }
              //}
            }
          }
        }
      } else {}
    } catch (e) {
      showToast(context, e.toString() + ':posinput.savePOSTrans RECV');
    }
  }

  double checkPCfromEndStringwithPC(String textPc) {
    double result = 0;
    textPc = textPc.trim();
    try {
      if (textPc.contains('%')) {
        String pc = textPc.substring(textPc.length - 3).replaceAll('%', '');
        if (pc.isNotEmpty) {
          return double.parse(pc) / 100;
        }
      }
    } catch (e) {}

    return result;
  }

  String itemtype10(
      String pluUrl,
      String posid,
      String docno,
      int lineno,
      String salesdesc,
      String cashier,
      String plu,
      String disccode,
      double qty,
      double amount,
      double price,
      double disc,
      String vatcode,
      String unit) {
    String r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB, rC;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    r0 = '(LINENO)';
    r3 = '(CASHIER)';
    r4 = '(SI)';
    r5 = '(PLU)';
    r6 = '(QTY)';
    r7 = '(PRICE)';
    r8 = '(DISC)';
    r9 = '(AMT)';
    rA = '(VC)';
    rB = '(UNIT)';
    rC = '(DISAMT)';
    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/B/1/' +
        r0 +
        ']' +
        r3 +
        ']' +
        r4 +
        ']' +
        r5 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        r9 +
        ']' +
        rA +
        ']' +
        rB +
        ']' +
        rC +
        ']';
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      dataSentUrl = dataSentUrl.replaceAll(r0, lineno.toString().trim());
      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r3, cashier.split('-')[0].trim());
      dataSentUrl = dataSentUrl.replaceAll(
          r4, (salesdesc != null) ? salesdesc.trim() : '');
      dataSentUrl = dataSentUrl.replaceAll(r5, plu.split('(')[0].trim());
      dataSentUrl = dataSentUrl.replaceAll(r6, df.format(qty));
      dataSentUrl = dataSentUrl.replaceAll(r7, df.format(price));
      dataSentUrl = dataSentUrl.replaceAll(r8, disccode.trim());
      dataSentUrl = dataSentUrl.replaceAll(r9, df.format(amount));
      dataSentUrl =
          dataSentUrl.replaceAll(rA, (vatcode != null) ? vatcode.trim() : 'V');
      dataSentUrl = dataSentUrl.replaceAll(rB, (unit != null) ? unit : 'pcs');
      return dataSentUrl.replaceAll(rC, df.format(disc));
    } catch (e) {
      // showToast(
      //     context, dataSentUrl + ':posinput.wsfnc.savePosTranWS:replacement');
    }
    return '';
  }

  String itemtype2X(
      String pluUrl,
      String posid,
      String docno,
      String itemtype,
      int reflineno,
      String coupontype,
      String couponno,
      String promoid,
      double discpc,
      double discamt,
      double chargepc,
      double chargeamt,
      String salesdesc) {
    String r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB, rC;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    r3 = '(SI)'; //@itemdesc
    r4 = '(ITT)'; //@itemtype
    r5 = '(RIN)'; //@reflineno
    r6 = '(CPT)'; //@coupontype
    r7 = '(CPN)'; //@couponno
    r8 = '(PID)'; //@promoid
    r9 = '(DPC)'; //@discpc
    rA = '(DAM)'; //@discamt
    rB = '(CPC)'; //@chargepc
    rC = '(CAM)'; //@chargeamt
    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/B/2X/' +
        r4 +
        ']' +
        r5 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        r9 +
        ']' +
        rA +
        ']' +
        rB +
        ']' +
        rC +
        ']' +
        r3 +
        ']';
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      dataSentUrl = dataSentUrl.replaceAll(
          r3, (salesdesc != null) ? salesdesc.trim() : '');
      dataSentUrl = dataSentUrl.replaceAll(r4, itemtype.split('-')[0].trim());
      dataSentUrl = dataSentUrl.replaceAll(r5, reflineno.toString());
      dataSentUrl = dataSentUrl.replaceAll(r6, coupontype.trim());
      dataSentUrl = dataSentUrl.replaceAll(r7, couponno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r8, promoid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r9, df.format(discpc));
      dataSentUrl = dataSentUrl.replaceAll(rA, df.format(discamt));
      dataSentUrl = dataSentUrl.replaceAll(rB, df.format(chargepc));
      return dataSentUrl.replaceAll(rC, df.format(chargeamt));
    } catch (e) {
      // showToast(
      //     context, dataSentUrl + ':posinput.wsfnc.savePosTranWS:replacement');
    }
    return '';
  }

  String itemtypeB(
      String pluUrl,
      String posid,
      String docno,
      String itemtype,
      int reflineno,
      String coupontype,
      String couponno,
      String promoid,
      double discpc,
      double discamt,
      double chargepc,
      double chargeamt) {
    String r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB, rC;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    // r3 = '(SI)'; //@itemdesc
    r4 = '(ITT)'; //@itemtype
    r5 = '(RIN)'; //@reflineno
    r6 = '(CPT)'; //@coupontype
    r7 = '(CPN)'; //@couponno
    r8 = '(PID)'; //@promoid
    r9 = '(DPC)'; //@discpc
    rA = '(DAM)'; //@discamt
    rB = '(CPC)'; //@chargepc
    rC = '(CAM)'; //@chargeamt
    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/B/B/' +
        r4 +
        ']' +
        r5 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        r9 +
        ']' +
        rA +
        ']' +
        rB +
        ']' +
        rC +
        ']';
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      // dataSentUrl = dataSentUrl.replaceAll(
      //     r3, (salesdesc != null) ? salesdesc.trim() : '');
      dataSentUrl = dataSentUrl.replaceAll(r4, itemtype.split('-')[0].trim());
      dataSentUrl = dataSentUrl.replaceAll(r5, reflineno.toString());
      dataSentUrl = dataSentUrl.replaceAll(r6, coupontype.trim());
      dataSentUrl = dataSentUrl.replaceAll(r7, couponno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r8, promoid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r9, df.format(discpc));
      dataSentUrl = dataSentUrl.replaceAll(rA, df.format(discamt));
      dataSentUrl = dataSentUrl.replaceAll(rB, df.format(chargepc));
      return dataSentUrl.replaceAll(rC, df.format(chargeamt));
    } catch (e) {
      // showToast(
      //     context, dataSentUrl + ':posinput.wsfnc.savePosTranWS:replacement');
    }
    return '';
  }

  String itemtypeR(
      String pluUrl,
      String posid,
      String docno,
      String paytype,
      int lineno,
      String reftype,
      String refno,
      double receiptamt,
      double pointburn,
      String curcycode,
      double curcyamt,
      double excrate) {
    String r1, r2, r3, r4, r5, r6, r7, r8, r9, rA, rB, rC;
    String dataSentUrl, dataVarStruct;
    r1 = '(POSID)';
    r2 = '(DOCNO)';
    r3 = '(RCA)'; //@receiptamt
    r4 = '(PMT)'; //@paytype
    r5 = '(LIN)'; //@lineno
    r6 = '(RFT)'; //@reftype
    r7 = '(RFN)'; //@refno
    r8 = '(PTB)'; //@pointburn
    r9 = '(CRC)'; //@curcycode
    rA = '(CRA)'; //@curcyamt
    rB = '(EXC)'; //@exchangerate
    // rC = '(CAM)'; //@chargeamt
    dataVarStruct = '/savePosTrans/' +
        r1 +
        '/' +
        r2 +
        '/B/R/' +
        r4 +
        ']' +
        r5 +
        ']' +
        r3 +
        ']' +
        r6 +
        ']' +
        r7 +
        ']' +
        r8 +
        ']' +
        r9 +
        ']' +
        rA +
        ']' +
        rB +
        ']';
    dataSentUrl = pluUrl + dataVarStruct;
    try {
      dataSentUrl = dataSentUrl.replaceAll(r1, posid.trim());
      dataSentUrl = dataSentUrl.replaceAll(r2, docno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r3, df.format(receiptamt));
      dataSentUrl = dataSentUrl.replaceAll(r4, paytype.split('-')[0].trim());
      dataSentUrl = dataSentUrl.replaceAll(r5, lineno.toString());
      dataSentUrl = dataSentUrl.replaceAll(r6, reftype.trim());
      dataSentUrl = dataSentUrl.replaceAll(r7, refno.trim());
      dataSentUrl = dataSentUrl.replaceAll(r8, df.format(pointburn));
      dataSentUrl = dataSentUrl.replaceAll(r9, curcycode.trim());
      dataSentUrl = dataSentUrl.replaceAll(rA, df.format(curcyamt));
      return dataSentUrl.replaceAll(rB, df.format(excrate));
    } catch (e) {
      // showToast(
      //     context, dataSentUrl + ':posinput.wsfnc.savePosTranWS:replacement');
    }
    return '';
  }

//------Summary

  SalesItemSummary getSalesSUM(BuildContext context) {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;
    int lsalesitem = 0;
    var model = Provider.of<SalesItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;

    double totalAmount, totalQty, totaldisc, totalcharge, totalvat;
    double qty, price, amount, disc, charge, vat;
    totalAmount = 0;
    totalQty = 0;
    totaldisc = 0;
    totalcharge = 0;
    totalvat = 0;

    int itemCount, itemcounts, disccount;
    itemCount = 0;
    disccount = 0;
    itemcounts = _hiveSalesitems.length;
    var itemtype;
    //SalesItem _hiveSalesitem;
    if (itemcounts > 0) {
      for (var _hiveSalesitem in _hiveSalesitems) {
        qty = 1;
        price = 0;
        disc = 0;
        charge = 0;
        amount = 0;
        vat = 0;
        if (_hiveSalesitem.saleskey != "null") {
          //----tabledata
          var l = _hiveSalesitem.salesdata.split(']');
          if (l.length > 0) {
            qty = double.parse(l[0]);
          }
          if (l.length > 1) {
            price = double.parse(l[1]);
          }
          if (l.length > 2) {
            amount = double.parse(l[2]);
            vat = amount * 0.07;
          }
          if (checkLastSalesItem(_hiveSalesitem) == 10) {
            itemCount += 1;
          }
          //---------------
          var t = _hiveSalesitem.saleskey.split(']');
          if (t.length > 1) {
            itemtype = t[1].trim();
          }
          if (itemtype.isNotEmpty) {
            if (itemtype == '20' ||
                itemtype == '21' ||
                itemtype == '22' ||
                itemtype == '23' ||
                itemtype == '24' ||
                itemtype == '25') {
              totaldisc += (-1) * amount;
              disccount += 1;
            } else if (itemtype == '31' || itemtype == '32') {
              totalcharge += amount;
            }
          }
        }
        totalQty += qty;

        totalAmount += amount;
        totalvat += vat;
        lsalesitem += 1;
      }

      SalesItemSummary result = new SalesItemSummary(
          itemCount,
          disccount,
          totalQty,
          totaldisc,
          totalcharge,
          totalAmount,
          totalvat,
          lsalesitem,
          lsalesitem, //when bill chart will start
          lsalesitem);
      return result;
    } else {
      return SalesItemSummary(
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0, //when bill chart will start
          0);
    }
    //-----------------------------------------------------------------
  }

  Future<SalesItemSummary> getSalesSUMItems(BuildContext context) async {
    return getSalesSUM(context);
  }

  SalesItemSummary getBDCSUM(BuildContext context) {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;
    int lsalesitem = 0;
    var model = Provider.of<BillDCItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;

    double totalAmount, totalQty, totaldisc, totalcharge, totalvat;
    double qty, price, amount, disc, charge, vat;
    totalAmount = 0;
    totalQty = 0;
    totaldisc = 0;
    totalcharge = 0;
    totalvat = 0;

    int itemCount, itemcounts, disccount;
    itemCount = 0;
    disccount = 0;
    itemcounts = _hiveSalesitems.length - 1;
    var itemtype;
    //SalesItem _hiveSalesitem;
    for (var _hiveSalesitem in _hiveSalesitems) {
      qty = 1;
      price = 0;
      disc = 0;
      charge = 0;
      amount = 0;
      vat = 0;
      // if (_hiveSalesitem.saleskey != "null") {
      //----tabledata
      var l = _hiveSalesitem.salesdata.split(']');
      if (l.length > 0) {
        qty = double.parse(l[0]);
      }
      if (l.length > 1) {
        price = double.parse(l[1]);
      }
      if (l.length > 2) {
        amount = double.parse(l[2]);
        vat = amount * 0.07;
      }
      if (checkLastSalesItem(_hiveSalesitem) == 10) {
        itemCount += 1;
      }
      //---------------
      var t = _hiveSalesitem.saleskey.split(']');
      if (t.length > 1) {
        itemtype = t[1].trim();
      }
      if (itemtype.isNotEmpty) {
        if (itemtype == '20' ||
            itemtype == '21' ||
            itemtype == '22' ||
            itemtype == '23' ||
            itemtype == '24' ||
            itemtype == '25') {
          totaldisc += (-1) * amount;
          disccount += 1;
        } else if (itemtype == '31' || itemtype == '32') {
          totalcharge += amount;
        }
      }

      totalQty += qty;

      totalAmount += amount;
      totalvat += vat;
      lsalesitem += 1;
    }

    SalesItemSummary result = new SalesItemSummary(
        itemCount,
        disccount,
        totalQty,
        totaldisc,
        totalcharge,
        totalAmount,
        totalvat,
        lsalesitem,
        lsalesitem, //when bill chart will start
        lsalesitem);
    return result;
    //-----------------------------------------------------------------
  }

  Future<SalesItemSummary> getBdcSUMItems(BuildContext context) async {
    return getBDCSUM(context);
  }

  SalesItemSummary getReceiptSUM(BuildContext context) {
    //---Important: Required for initalize all grid sales item-----------
    //---Do not remove this getSalesItem function;
    int lsalesitem = 0;
    var model = Provider.of<ReceiptItemHiveModel>(context, listen: false);
    List<SalesItem> _hiveSalesitems = model.inventoryList;

    double totalAmount, totalQty, totaldisc, totalcharge, totalvat;
    double qty, price, amount, disc, charge, vat;
    totalAmount = 0;
    totalQty = 0;
    totaldisc = 0;
    totalcharge = 0;
    totalvat = 0;

    int itemCount, itemcounts, disccount;
    itemCount = 0;
    disccount = 0;
    itemcounts = _hiveSalesitems.length - 1;
    var itemtype;
    //SalesItem _hiveSalesitem;
    for (var _hiveSalesitem in _hiveSalesitems) {
      qty = 1;
      price = 0;
      disc = 0;
      charge = 0;
      amount = 0;
      vat = 0;
      // if (_hiveSalesitem.saleskey != "null") {
      //----tabledata
      var l = _hiveSalesitem.salesdata.split(']');
      // if (l.length > 0) {
      //   qty = double.parse(l[0]);
      // }
      // if (l.length > 1) {
      //   price = double.parse(l[1]);
      // }
      if (l.length > 2) {
        amount = double.parse(l[2]);
        // vat = amount * 0.07;
      }
      // if (checkLastSalesItem(_hiveSalesitem) == 10) {
      itemCount += 1;
      // }
      // if (vatcode == Palette.modeType_RCP) {
      //   //  return true;
      //   } else {
      // //    return false;
      //   }
      // //---------------
      // var t = _hiveSalesitem.saleskey.split(']');
      // if (t.length > 1) {
      //   itemtype = t[1].trim();
      // }
      // if (itemtype.isNotEmpty) {
      //   if (itemtype == '20' ||
      //       itemtype == '21' ||
      //       itemtype == '22' ||
      //       itemtype == '23' ||
      //       itemtype == '24' ||
      //       itemtype == '25') {
      //     totaldisc += (-1) * amount;
      //     disccount += 1;
      //   } else if (itemtype == '31' || itemtype == '32') {
      //     totalcharge += amount;
      //   }
      // }

      //totalQty += qty;

      totalAmount += amount;
      // totalvat += vat;
      lsalesitem += 1;
    }

    SalesItemSummary result = new SalesItemSummary(
        itemCount,
        0,
        0,
        0,
        0,
        totalAmount,
        0,
        lsalesitem,
        lsalesitem, //when bill chart will start
        lsalesitem);
    return result;
    //-----------------------------------------------------------------
  }

//-----------Member
  int getMbDisc(BuildContext context) {
    int lsalesitem = 0;
    String mbDm = PosControlFnc().getMbDiscMethod(context);
    if (mbDm.isNotEmpty) {
      var mbDmNo = mbDm.split('-')[0];
      if (mbDmNo.length > 0) {
        return int.parse(mbDmNo[0]);
      }
    }
    // var model = Provider.of<SalesItemHiveModel>(context, listen: false);
    // List<SalesItem> _hiveSalesitems = model.inventoryList;
    // lsalesitem = _hiveSalesitems.length;
    return lsalesitem;
  }

  void getMemberValue(BuildContext context, PsMember _psMember) {
    PosCtrl posctrl64 = posCtrlList[62];
    String value;

    if (_psMember.mbPriceFg == 1) {
      value = _psMember.mbId +
          '-' +
          _psMember.mbNameT +
          ':' +
          pCcy.format(_psMember.mbDiscPs / 100); //
    } else {
      value = _psMember.mbId +
          '-' +
          _psMember.mbNameT +
          ':' +
          _psMember.sellUnitPriceNo.toString().trim();
    }
    //Member
    PosControlFnc().updatePosControlByItemCode(
        context,
        Palette.sales_member_configID,
        PosCtrl(
            itemcode: Palette.sales_member_configID,
            description: posctrl64.description,
            groupcode: posctrl64.groupcode,
            valuetext: value,
            valueint: posctrl64.valueint,
            valuedbl: posctrl64.valuedbl,
            image: _psMember.mbPhoto));
  }

  double getPriceNo(BuildContext context) {
    PosCtrl posctrl64 = posCtrlList[62]; //Member
    String curMember =
        PosControlFnc().getCurrentSettingValues(context, posctrl64);
    if (curMember.isNotEmpty) {
      List<String> cmb = curMember.split(':');
      if (cmb.length > 1) {
        if (cmb[1].indexOf('%') > 0) {
          return (-1) * double.parse(cmb[1].replaceAll('%', '')) / 100;
        }
        return double.parse(cmb[1]);
      } else {
        return 1;
      }
    }
    return 1;
  }

  double getRoundAmt(double amt, int mode) {
    double oamt = amt;
    try {
      if (amt < 0) {
        //---handle for minus value
        amt = (-1) * amt;
      }
      switch (mode) {
        case 0:
          {
            //---std rule  of round method to Two digit of Decimal
            amt = double.parse(c2rnd.format(amt));
          }
          break;
        case 1: //---down to XXX.25
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            double damt = amt - samt;
            if (damt > 0.75) {
              amt = samt + 0.75;
            } else if (damt > 0.50) {
              amt = samt + 0.50;
            } else if (damt > 0.25) {
              amt = samt + 0.25;
            } else {
              amt = samt;
            }
          }
          break;
        case 2: //---down to XXX.50
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            double damt = amt - samt;
            if (damt > 0.50) {
              amt = samt + 0.50;
            } else {
              amt = samt;
            }
          }
          break;
        case 3: //---down to XXX.00
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            //---std rule  of round method to Two digit of Decimal
            amt = samt;
          }
          break;
        case 4: //---up to XXX.25
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            double damt = amt - samt;
            if (damt > 0.75) {
              amt = samt + 1;
            } else if (damt > 0.50) {
              amt = samt + 0.75;
            } else if (damt > 0.25) {
              amt = samt + 0.50;
            } else if (damt > 0) {
              amt = samt + 0.25;
            } else {
              amt = samt;
            }
          }
          break;
        case 5: //---up to XXX.50
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            double damt = amt - samt;
            if (damt > 0.50) {
              amt = samt + 1;
            } else {
              amt = samt;
            }
          }
          break;
        case 6: //---up to XXX. +1
          {
            double samt = double.parse(
                double.parse(c4rnd.format(amt)).toString().split('.')[0]);
            double damt = amt - samt;
            if (damt > 0) {
              amt = samt + 1;
            } else {
              amt = samt;
            }
          }
          break;
        default:
          //---std rule  of round method to Two digit of Decimal
          amt = double.parse(c2rnd.format(amt));
          break;
      }
      if (oamt < 0) {
        //---handle for minus value
        amt = (-1) * amt;
      }
    } catch (e) {
      return oamt;
    }
    return amt;
  }

  double getRoundDif(double amt, int mode) {
    double ramt = getRoundAmt(amt, mode);
    return ramt - amt; //--if ramt - amt > 0 = profit
  }

  int getDiscRoundMode(BuildContext context) {
    PosCtrl posctrl53 = posCtrlList[53];
    String curMode =
        PosControlFnc().getCurrentSettingValues(context, posctrl53).trim();
    if (curMode.isNotEmpty && curMode.length > 0) {
      if (curMode.isNotEmpty && curMode.length > 1) {
        curMode = curMode.substring(0, 1);
      }
      int rmode = int.parse(curMode);
      if (rmode >= 0 && rmode <= 6) {
        return rmode;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  String getMemberIDname(BuildContext context) {
    PosCtrl posctrl1 = posCtrlList[0];
    PosCtrl posctrl64 = posCtrlList[62];
    PosCtrl posctrl60 = posCtrlList[59];
    String curMethod = PosControlFnc()
        .getCurrentSettingValues(context, posctrl1)
        .split('-')[0]
        .trim();
    String curPosID =
        PosControlFnc().getCurrentSettingValues(context, posctrl60); //Member
    String curMember =
        PosControlFnc().getCurrentSettingValues(context, posctrl64);
    if (curMethod == '2') {
      if (curMember.isNotEmpty) {
        List<String> cmb = curMember.split(':');
        if (cmb.length > 1) {
          List<String> mbid = cmb[0].split('-');
          if (mbid.length > 1) {
            return curPosID + '/' + mbid[0];
          } else {
            return curPosID + '/ ';
          }
        } else {
          return curPosID + '/ ';
        }
      }
    } else {
      return '';
    }
    return ' ';
  }

  void setActiveTxt(TextEditingController activeTxt, FocusNode activefocus) {
    activeTxt.selection = TextSelection(
        baseOffset:
            (activeTxt.text.length != 0) ? activeTxt.text.length - 1 : 0,
        extentOffset: activeTxt.text.length);
    // activefocus.requestFocus();
    activefocus.unfocus();
  }

  bool isNumeric(String s) {
    if (s == null || s.isEmpty) {
      return false;
    } else {
      return (num.tryParse(s) != null);
    }
  }
}
