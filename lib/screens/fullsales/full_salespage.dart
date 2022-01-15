import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';

import 'package:com_csith_geniuzpos/data/posfunctions/possalesfnc.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/screens/cashinouts/cashinout_ok.dart';
import 'package:com_csith_geniuzpos/screens/home_screen.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_components.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'components/fs_salesitem.dart';
import 'components/fssh.dart';

class FullSalesPages extends StatefulWidget {
  @override
  _FullSalesPages createState() => _FullSalesPages();
}

class _FullSalesPages extends State<FullSalesPages>
    implements
        PosFncCallBack,
        PosFncAddFree,
        PosFncAddNew,
        PosFncVoidAll,
        PosFncVoidAitem,
        PosFncGetAitem,
        PosSumCallBack,
        GetPluListCallBack,
        GetPromoListCallBack,
        GetSearchMemberCallBack,
        GetPluCallBack,
        execPosShiftCallBack {
  PosFncCallResponse _responseInput;
  TextEditingController activeTxt;
  PosFncAddFreeCallResponse _responseFree;
  PosFncAddNewCallResponse _responseAddNew;
  PosFncVoidAllCallResponse _responseVoidAll;
  PosFncVoidAitemCallResponse _responseVoidAitem;
  PosSumSalesItemCallResponse _responseSumSalItem;
  PosFncGetAitemCallResponse _responseGetItem;
  GetSearchMemberResponse _responseMember;
  GetPluListResponse _reponsePluList;
  GetPluResponse _responsePlu;
  GetPromoListResponse _reponsePromoList;
  ExecPosShiftResponse _responseExecShift;
  List<CsPlu> getPluList;
  CsPlu csPlus;
  PluPrice csProPrice;
  PsMember csMember;
  PosButton posGroup;
  BuildContext _context;
  var now = DateTime.now();
  int salesitemIndex = -1;
  int mntmode = 1;
  SalesItemSummary salesitemsum;
  SalesItems selectSalesitem;

  final FocusNode _focusNode = new FocusNode();
  final PosInput _posinput = new PosInput();
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  bool kEntry = false;
  FocusNode fcn1;
  _FullSalesPages() {
    _posinput.focusnode = FocusNode();
    _responseInput = new PosFncCallResponse(this);
    _responseFree = new PosFncAddFreeCallResponse(this);
    _responseAddNew = new PosFncAddNewCallResponse(this);
    _responseVoidAll = new PosFncVoidAllCallResponse(this);
    _responseSumSalItem = new PosSumSalesItemCallResponse(this);
    _responseVoidAitem = new PosFncVoidAitemCallResponse(this);
    _responseGetItem = new PosFncGetAitemCallResponse(this);
    _responseMember = new GetSearchMemberResponse(this);
    _reponsePluList = new GetPluListResponse(this);
    _responsePlu = new GetPluResponse(this);
    _reponsePromoList = new GetPromoListResponse(this);
    _responseExecShift = new ExecPosShiftResponse(this);
    fcn1 = FocusNode();
  }
  @override
  void initState() {
    activeTxt = _posinput.txtPlu;
    fcn1.requestFocus();
    salesitemIndex = -1;
    mntmode = 1;
    super.initState();
  }

  void _initState() {
    activeTxt = _posinput.txtPlu;
    fcn1.requestFocus();
    salesitemIndex = -1;
    mntmode = 0;

    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    _posinput.focusnode.dispose();
    fcn1.dispose();
    super.dispose();
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    txtinputEntry(result);
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (PosSalesFnc().funcCall(
          context,
          result,
          _posinput.txtPlu,
          _posinput.txtQty,
          _posinput.txt9,
          _reponsePluList,
          _responseGetItem)) {
      } else if ((result.indexOf(":") > 0)) {
        var comm = result.split(":");
        if (comm[1] == '3') {
          salesitemIndex = int.parse(comm[2]);
        } else {
          if (comm[2] == 'F4V') {
            showVoidBySelectDialog(_context, salesitemIndex, _responseInput);
          } else if (comm[2] == 'VOIDALL') {
            _responseVoidAll.doVoidAll(context);
            Navigator.of(context).pop();
          } else if (comm[2] == 'VOIDLAST') {
            _responseVoidAitem.doVoidAitem(context, salesitemIndex);
          } else if (comm[2] == 'VOIDCCL') {
            Navigator.of(context).pop();
          } else if (comm[2] == 'F8') {
            //refund
            String docno =
                PosControlFnc().getRunno(context, MyConfig().a_cycleRcptBegEnd);
            showRefundEnterDialog(
                _context, salesitemIndex, _posinput, _responseInput, docno);
          } else if (comm[2] == 'ALLREFUND') {
            //  send request to Server
            Navigator.of(context).pop();
          } else if (comm[2] == 'PARREFUND') {
            //---If no have promotion in BILL only! If have must to [REFUND ALL]
            //---get bill and POPUP sales item for select sales items to refund

            //  send request to Server
          } else if (comm[2] == 'Shift F3') {
            //cash out
            PosShiftLogin a = new PosShiftLogin();
            begCashDialog(context, "CASHOUT", a);
            //showToast(context, comm[2]);
          } else if (comm[2] == 'Shift F7') {
            //set plu
            showToast(context, comm[2]);
          } else if (comm[2] == 'Shift F8') {
            //cash in
            PosShiftLogin a = new PosShiftLogin();
            begCashDialog(context, "CASHIN", a);
            //showToast(context, comm[2]);
          } else if (comm[2] == 'Shift F9') {
            //hold bill
            showToast(context, comm[2]);
          } else if (comm[2] == 'Ctrl F10') {
            //Special command
            showToast(context, comm[2]);
          } else if (comm[2] == 'ESC') {
            //---must to update open shift from 'O' - openning to 'P'- pending
            String posShiftId = PosControlFnc().getShiftId(context);
            String posexec =
                PosControlFnc().getUpStatusShifturl(context, posShiftId, 'P');
            _responseExecShift.exPosShift(posexec);
          } else if (comm[2] == 'OUT') {
            //---must to update open shift from 'O' - openning to 'P'- pending
            String posShiftId = PosControlFnc().getShiftId(context);
            String posexec =
                PosControlFnc().getUpStatusShifturl(context, posShiftId, 'C');
            _responseExecShift.exPosShift(posexec);
          } else {
            presskey(result);
          }
        } //
      } else {
        _posinput.txtPlu.text = _posinput.txtPlu.text + result;
        _posinput.setActiveTxt(_posinput.txtPlu, _posinput.focusnode);
      }
    }
  }

  void begCashDialog(
      BuildContext context, String mnuName, PosShiftLogin activeposShift) {
    switch (mnuName) {
      case "CASHIN":
        {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.white,
                    insetAnimationDuration: const Duration(milliseconds: 100),
                    child: Container(
                      // use container to change width and height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 3),
                        ],
                      ),
                      height: Palette.stdbutton_height * 6.6,
                      width: Palette.stdbutton_width * 7.6,
                      child: CashinoutPages(goCashIn, activeposShift, 2),
                    ));
              });
        }
        break;
      case "CASHOUT":
        {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.white,
                    insetAnimationDuration: const Duration(milliseconds: 100),
                    child: Container(
                      // use container to change width and height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 3),
                        ],
                      ),
                      height: Palette.stdbutton_height * 6.6,
                      width: Palette.stdbutton_width * 7.6,
                      child: CashinoutPages(goCashOut, activeposShift, 3),
                    ));
              });
        }
        break;
    }
    //return 0;
  }

  void goCashIn(PosShiftLogin activeposShift, double cashbeg) {
    Navigator.of(context).pop();
    //----Plus to config.CashIn
    PosControlFnc().updateConfigCashIn(context, cashbeg);
    //----Print Cash in slip
  }

  void goCashOut(PosShiftLogin activeposShift, double cashbeg) {
    Navigator.of(context).pop();
    //----Plus to config.CashOut
    PosControlFnc().updateConfigCashOut(context, cashbeg);
    //----Print Cash out slip
  }

  bool checkSum() {
    return (_posinput.salesItemCount(_context) > 0);
  }

  void presskey(String result) {
    if (result != "") {
      if (PosSalesFnc().pressKey(
          context,
          result,
          _posinput.txtPlu,
          _posinput.txtQty,
          _responseAddNew,
          _responseMember,
          _responsePlu,
          _posinput.salesPriceNo,
          checkSum)) {
      } else {
        var comm = result.split(":");
        int valret = FncItems().posFunction(
            context,
            _posinput,
            posGroup,
            _responseVoidAll,
            _responseFree,
            _responseMember,
            comm[0],
            comm[2],
            checkSum);
        if (valret != 0) {
          posGroup = stdButtuon4.firstWhere((e) => e.kybCode == comm[2]);
        }
      }
    }
    kEntry = !kEntry;
    //}
  }

  void getPromoPrice(CsPlu _csplus) {
    String pluUrl = PosControlFnc().getPLUurl(context);
    pluUrl = pluUrl.replaceAll('/getsaleitem', '');
    try {
      String posMem = _posinput.getMemberIDname(context);
      if (posMem.isNotEmpty && posMem.trim() != '') {
        String url = pluUrl + '/PluPrices/i/' + posMem + '/' + _csplus.pluCode;
        _reponsePromoList.getPromoList(url);
        //  _reponsePluList.getPluList(url);
      } else {
        String url = pluUrl + '/PluPrices/' + _csplus.pluCode;
        _reponsePromoList.getPromoList(url);
        // _reponsePluList.getPluList(url);
      }
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  void addSalesItem() {
    try {
      if (_responseAddNew != null || _posinput.txtPlu != null) {
        double proPrice = 0;
        String promoId = '';
        if (csProPrice != null) {
          proPrice =
              (csProPrice.promoPrice != null) ? csProPrice.promoPrice : 0;
          promoId =
              (csProPrice.promoId != null) ? '1' + csProPrice.promoId : '0';
        }
        //---------------CsPlus Variable----
        double stkqty, mbDiscPs, salesqty;
        int allowOverStock, stockFg, mbDiscMethod, mbSellNo, mbPriceFg;
        //----STCOK RULE
        stockFg = (csPlus.stockFg == null) ? 0 : csPlus.stockFg; //--used
        //--Stock 1-Stock Control , 0-not controll
        stkqty = (csPlus.qtyOnHand == null) ? 0 : csPlus.qtyOnHand; //--used
        allowOverStock = (csPlus.allowSaleOverStock == null)
            ? 1
            : csPlus.allowSaleOverStock; //--used
        //--0--not allow, 1- allow
        salesqty = (_posinput.txtQty.text.isNotEmpty)
            ? double.parse(_posinput.txtQty.text)
            : 1;
        salesqty = (salesqty > 0) ? salesqty : 1;
        if (stkqty < salesqty) {
          //--if not allow over stock and control stock then can't sell this.
          if (allowOverStock == 0 && stockFg == 1) {
            normalDialog(context, 'NOT ENOUGHT STOCK');
            return;
          }
        }

        mbDiscMethod =
            (csPlus.mbDiscMethod == null) ? 1 : csPlus.mbDiscMethod; //--used
        //---PsPara: 1= bill disc, 2=line item disc
        mbSellNo =
            (csPlus.sellUnitPriceNo == null || csPlus.sellUnitPriceNo < 1)
                ? 1
                : csPlus.sellUnitPriceNo; //--used
        //Memebr sell price no
        mbDiscPs = (csPlus.mbDiscPs == null) ? 0 : csPlus.mbDiscPs; //--used
        //Member discount percent
        mbPriceFg = (csPlus.mbPriceFg == null) ? 2 : csPlus.mbPriceFg; //--used
        //--Member discount by 1=use DiscPs(mbDiscMethod=2,only) or 2=use PriceNo
        _posinput.salesPriceNo =
            double.parse(csPlus.sellUnitPriceNo.toString());

        if (mbPriceFg == 1 && mbDiscMethod == 2) {
          //disc% from Member And discount in line only
          // use price full of this POS STATION
          SalesItems _salesItems = PosSalesFnc().addSalesItemFromPLU(_context,
              _responseAddNew, csPlus, c2rnd.format(salesqty), 1, csProPrice);
          //_posinput.salesPriceNo);

          //and add discount member itemline
          // normalDialog(context, 'salesitem :' + _salesItems.salesitem);
          if (mbDiscPs > 0 && _salesItems.salesitem.isNotEmpty) {
            //Member discount percent
            addDiscChrgItem(_salesItems,
                Palette.btncmd_DISCM + ':' + oCcy.format(mbDiscPs / 100));
          }
        } else {
          //use priceNo
          PosSalesFnc().addSalesItemFromPLU(_context, _responseAddNew, csPlus,
              _posinput.txtQty.text, _posinput.salesPriceNo, csProPrice);
        }
        mntmode = 0;
        _posinput.txtPlu.text = '';
        _posinput.txtQty.text = '';
      }
    } catch (e) {
      normalDialog(_context, e.toString() + ' @addSalesItem');
    }
  }

  void addDiscChrgItem(SalesItems _selectSalesitem, String btncmd) {
    try {
      if (_responseAddNew != null ||
          _posinput.txtPlu != null ||
          _posinput.txtQty != null) {
        SalesItems _result =
            PosSalesFnc().btncmdresult(context, _selectSalesitem, btncmd);
        if (_result.disccode != '')
          PosSalesFnc()
              .addDiscChrgFromsaleItem(context, _responseAddNew, _result);
        mntmode = 0;
        _posinput.txtPlu.text = '';
        _posinput..txtQty.text = '';
      }
    } catch (e) {
      normalDialog(context, e.toString() + ' @addDiscChrgItem');
    }
  }

  void showPluResult(List<CsPlu> _cspluslist) {
    getPluList = _cspluslist;
    //--------------
    if (_cspluslist.length > 1) {
      showToast(context, _posinput.txtPlu.text + '=> Not unique!');
      // FncItems().searchPLU(
      //     context,
      //     activeTxt.text,
      //     _responseAddNew,
      //     _posinput.txtPlu,
      //     _posinput.txtQty,
      //     _responsePlu,
      //     _posinput.salesPriceNo);
    } else if (_cspluslist.length > 0) {
      //  normalDialog(context, " Found! ");
      csPlus = _cspluslist[0];
      getPromoPrice(csPlus);
      // addSalesItem();
    } else {
      showToast(context, _posinput.txtPlu.text + '=> Not found!');
      _posinput.txtPlu.text = '';
      _posinput.txtQty.text = '';
      fcn1.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<PosControlModel>().getItem();
    // _posinput.salesPriceNo = _posinput.getPriceNo(context);
    _context = context;
    _posinput.focusnode.requestFocus();
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: fullScreenDesktop(context, _responseInput, salesitemsum),
        ));
  }

  Widget fullScreenDesktop(BuildContext context,
      PosFncCallResponse responseInput, SalesItemSummary salesitemsum) {
    return Stack(children: [
      frameBUtton(context),
      FullSalesSummaryPages(),
      Positioned(
        top: Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 30,
        left: Palette.stdspacer_widht,
        child: FullsaleItem(
          responseSumSalItem: _responseSumSalItem,
          responseInput: _responseInput,
          trackingScrollController: _trackingScrollController,
          modemnt: mntmode,
        ),
      ),
      frmaebtn7(context, responseInput),
      frmaebtn90(context, responseInput),
      Container(child: pluForm())
    ]);
  }

  Widget pluForm() {
    return Stack(
      children: [
        Positioned(
          top: 555,
          left: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: Palette.entrypanelwidth(),
                height: Palette.onelineheigth() * 0.7,
                child: Row(
                  children: [
                    Container(
                      width: Palette.pluinoutwidth(),
                      height: Palette.onelineheigth() * 0.7,
                      padding: const EdgeInsets.all(2),
                      child: TextField(
                        controller: _posinput.txtPlu,
                        focusNode: fcn1,
                        onSubmitted: (result) {
                          var tl = result.length;
                          if (tl > 0) {
                            // if (tl > 12) {
                            //   if (_posinput.isNumeric(result)) {
                            //     activeTxt.text = result.substring(0, 13);
                            //   } else {
                            //     activeTxt.text = result;
                            //   }
                            // } else {
                            //   activeTxt.text = result;
                            // }

                            txtinputEntry("ENTER");
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Entry: here: ',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CsiStyle().primaryColor)),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: Palette.pluinoutwidth() * 0.3,
                      height: Palette.onelineheigth() * 0.7,
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: TextField(
                        controller: _posinput.txtQty,
                        onSubmitted: (value) {},
                        onChanged: (text) {},
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CsiStyle().primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onCallPosFncFreeError(String error) {}

  @override
  void onCallPosFncFreeSuccess(String result) {
    setState(() {});
  }

  @override
  void onCallPosFncVoidError() {}

  @override
  void onCallPosFncVoidSuccess() {
    setState(() {
      if (_posinput.salesItemCount(_context) == 0) {
        initState();
      }
    });
  }

  @override
  void onCallPosFncVaError() {
    salesitemIndex = -1;
  }

  @override
  void onCallPosFncVaSuccess() {
    if (_posinput.salesItemCount(_context) == 0) {
      _initState();
    }
    setState(() {
      mntmode = 0;
    });
  }

  @override
  void onCallPosFncAddNewError(String error) {}

  @override
  void onCallPosFncAddNewSuccess(String result) {
    setState(() {
      salesitemIndex = -1;
      mntmode = 0;
    });
    fcn1.requestFocus();
  }

  @override
  void onCallSumSalesItemError(String error) {
    //  normalDialog(context, error);
  }

  @override
  void onCallSumSalesItemSuccess(SalesItemSummary result) {
    setState(() {
      salesitemIndex = -1;
    });
  }

  @override
  void onCallPosFncGetItemError() {}
  @override
  void onCallPosFncGetItemSuccess(SalesItems asalesitem) {
    //setState(() {
    //---need this data to show promotion at footer
    selectSalesitem = asalesitem;
    if (asalesitem.plu.isNotEmpty) {
      // normalDialog(context, _posinput.txt9.text + ':' + asalesitem.plu);
      addDiscChrgItem(asalesitem, _posinput.txt9.text);
    }
    // });
  }

  @override
  void onPluListError(String error) {
    //   setState(() {});
  }

  @override
  void onPluListSuccess(List<CsPlu> _cspluslist) {
    // setState(() {
    showPluResult(_cspluslist);
    // });
  }

  @override
  void onSearchMemberError(String error) {}

  @override
  void onSearchMemeberSuccess(PsMember _psMember) {
    //---get the Member Data then --- refresh binding to member forms---
    if (_psMember != null) {
      setState(() {
        csMember = _psMember;
        _posinput.getMemberValue(context, _psMember);
      });
    }
  }

  @override
  void onPluError(String error) {}

  @override
  void onPluSuccess(CsPlu _csplus) {
    csPlus = _csplus;
    getPromoPrice(csPlus);
    //addSalesItem();
  }

  @override
  void onPosShiftAddError(String error) {}

  @override
  void onPosShiftAddSuccess(String result) {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (value) => HomeScreen(0));
    Navigator.push(context, route);
  }

  @override
  void onPromoListError(String error) {
    addSalesItem();
    PosControlFnc().updatePromoDesc(context, '');
  }

  @override
  void onPromoListSuccess(List<PluPrice> promoList) {
    csProPrice = promoList[0];
    addSalesItem();
    setState(() {
      String promoDesc = csProPrice.pluDesc +
          '@' +
          oCcy.format(csProPrice.basePriceByPos) +
          '=>' +
          oCcy.format(csProPrice.promoPrice);
      PosControlFnc().updatePromoDesc(context, promoDesc);
    });
  }
}
