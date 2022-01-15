import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/possalesfnc.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranReceipt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranHd.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDisc.dart';
import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/pluPrice.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/screens/cashinouts/cashinout_ok.dart';
import 'package:com_csith_geniuzpos/screens/home_screen.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_group.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_retail.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_components.dart';
import 'package:com_csith_geniuzpos/services/response/panel_response.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';

class RetailSalesPages extends StatefulWidget {
  @override
  _RetailSalesPages createState() => _RetailSalesPages();
}

class _RetailSalesPages extends State<RetailSalesPages>
    implements
        PosFncCallBack,
        PosFncAddFree,
        PosFncAddNew,
        PosFncVoidAll,
        PosFncVoidAitem,
        PosFncGetAitem,
        PosSumCallBack,
        GetPluListCallBack,
        GetSearchMemberCallBack,
        GetPluCallBack,
        GetPromoListCallBack,
        execPosShiftCallBack,
        GrpPnlListCallBack,
        ItemPnlListCallBack,
        RefundHDCallBack,
        RefundDTCallBack,
        RefundDiscCallBack,
        RefundRecvCallBack {
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
  GrpPnlListResponse _responseGrpPnlList;
  ItemPnlListResponse _responseItemPnlList;
  RefundHDCallResponse _responseRefundHd;
  RefundDTCallResponse _responseRefundDt;
  RefundDiscCallResponse _responseRefundDisc;
  RefundRecvCallResponse _responseRefundRecv;
  BuildContext _context;
  List<CsPlu> getPluList;
  CsPlu csPlus;
  PluPrice csProPrice;
  PsMember csMember;
  PosButtonX bosbtnX;
  List<TouchPanel> touchpnlList;
  List<GroupPanel> groupPanelList;
  List<ItemPanel> itemPanelList;
  PosButton posGroup;
  String activeTouchPanel, activeCode, activePanel;
  int activeGroupPanel, activePanelId;

  var now = DateTime.now();
  int salesitemIndex = -1;
  int mntmode = 1;
  SalesItemSummary salesitemsum;
  SalesItems selectSalesitem;
  bool kEntry = false;

  final FocusNode _focusNode = new FocusNode();
  final PosInput _posinput = new PosInput();
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  FocusNode fcn1;
  _RetailSalesPages() {
    _posinput.focusnode = FocusNode();
    //---start response setting
    _responseInput = new PosFncCallResponse(this);
    _responseFree = new PosFncAddFreeCallResponse(this);
    _responseAddNew = new PosFncAddNewCallResponse(this);
    _responseVoidAll = new PosFncVoidAllCallResponse(this);
    _responseSumSalItem = new PosSumSalesItemCallResponse(this);
    _responseVoidAitem = new PosFncVoidAitemCallResponse(this);
    _responseGetItem = new PosFncGetAitemCallResponse(this);
    _reponsePluList = new GetPluListResponse(this);
    _reponsePromoList = new GetPromoListResponse(this);
    _responseMember = new GetSearchMemberResponse(this);
    _responsePlu = new GetPluResponse(this);
    _responseExecShift = new ExecPosShiftResponse(this);
    _responseGrpPnlList = new GrpPnlListResponse(this);
    _responseItemPnlList = new ItemPnlListResponse(this);
    //---Refund response
    _responseRefundHd = new RefundHDCallResponse(this);
    _responseRefundDt = new RefundDTCallResponse(this);
    _responseRefundDisc = new RefundDiscCallResponse(this);
    _responseRefundRecv = new RefundRecvCallResponse(this);
    //---end response setting
    posGroup = PosInput().restuantGrpPanel;
    fcn1 = FocusNode();
  }
  @override
  void initState() {
    activeTxt = _posinput.txtPlu;
    fcn1.requestFocus();
    salesitemIndex = -1;
    mntmode = 1;
    setGroupPanel();
    PosControlFnc().updatePromoDesc(context, '');
    //---send data to Server for SecondMonitor , only sales item!
    _posinput.savePOSTrans(context, 0);
    super.initState();
  }

  void _initState() {
    activeTxt = _posinput.txtPlu;
    fcn1.requestFocus();
    salesitemIndex = -1;
    mntmode = 0;
    _posinput.savePOSTrans(context, 0);
    setGroupPanel();
    super.initState();
  }

  void setGroupPanel() {
    try {
      String touchType = PosControlFnc().getTouchPanel(context);
      if (touchType != null && touchType.isNotEmpty) {
        String grpPnlUrl = PosPanelCtrl().getGrpPanelurl(context);
        activeTouchPanel = touchType.split('-')[1].trim().split(':')[0];
        _responseGrpPnlList.grpPnlList(grpPnlUrl + '/' + activeTouchPanel);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    _posinput.focusnode.dispose();
    fcn1.dispose();
    super.dispose();
  }

//---Entry reqeuest error--
  @override
  void onCallPosFncError(String error) {}
//---Entry reqeuest success--
  @override
  void onCallPosFncSuccess(String result) {
    txtinputEntry(result);
  }

  void txtinputEntry(String result) {
    if (result != "") {
      fcn1.unfocus();
      if (PosSalesFnc().funcCall(
          _context,
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
            //--confirm again here!
            showConfirmDialog(context, voidAll);
          } else if (comm[2] == 'VOIDLAST') {
            _responseVoidAitem.doVoidAitem(context, salesitemIndex);
          } else if (comm[2] == 'VOIDCCL') {
            setToSalesMode();
            Navigator.of(context).pop();
          } else if (comm[2] == 'F8') {
            //refund FORM POPUP
            String docno =
                PosControlFnc().getRunno(context, MyConfig().a_cycleRcptBegEnd);
            showRefundEnterDialog(
                _context, salesitemIndex, _posinput, _responseInput, docno);
          } else if (comm[2] == 'ALLREFUND') {
            //---Check for having BILL!
            String url = PosControlFnc()
                .getRefundUrl(context, _posinput.txt9.text, ''); //--HD
            _responseRefundHd.getRefundBillHD(url);
            Navigator.of(context).pop();
            //----
          } else if (comm[2] == 'PARREFUND') {
            //---If no have promotion in BILL only! If have must to [REFUND ALL]
            //---get bill and POPUP sales item for select sales items to refund

          } else if (comm[2] == 'Shift F3') {
            //cash out
            PosShiftLogin a = new PosShiftLogin();
            begCashDialog(context, "CASHOUT", a);
          } else if (comm[2] == 'Shift F7') {
            //set plu
          } else if (comm[2] == 'Shift F8') {
            //cash in
            PosShiftLogin a = new PosShiftLogin();
            begCashDialog(context, "CASHIN", a);
          } else if (comm[2] == 'Shift F9') {
            //hold bill
          } else if (comm[2] == 'Ctrl F10') {
            //Special command
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
        }
      } else {
        _posinput.txtPlu.text = _posinput.txtPlu.text + result;
        _posinput.setActiveTxt(_posinput.txtPlu, _posinput.focusnode);
      }
    }
  }

  void voidAll() {
    _responseVoidAll.doVoidAll(context);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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
      _posinput.salesPriceNo = _posinput.getPriceNo(_context);
      if (PosSalesFnc().pressKey(
          _context,
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
            _context,
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
  }

  void getPromoPrice(CsPlu _csplus) {
    String pluUrl = PosControlFnc().getPLUurl(context);
    pluUrl = pluUrl.replaceAll('/getsaleitem', '');
    try {
      String posMem = _posinput.getMemberIDname(context);
      if (posMem.isNotEmpty && posMem.trim() != '') {
        String url = pluUrl + '/PluPrices/i/' + posMem + '/' + _csplus.pluCode;
        _reponsePromoList.getPromoList(url);
      } else {
        String url = pluUrl + '/PluPrices/' + _csplus.pluCode;
        _reponsePromoList.getPromoList(url);
      }
    } catch (e) {
      normalDialog(context, pluUrl + ':getPromoPrice:' + e.toString());
    }
  }

  void addSalesItem() {
    try {
      if (_responseAddNew != null || _posinput.txtPlu != null) {
        //---------------CsPlus Variable----
        if (csProPrice != null) {
          //--this is normal promotion then use '@' for save promotion discount to itemdiscount
          // and (price+discamt)*qty to exprice then itemexprice = exprice - itemdiscount;
          csProPrice.promoId =
              (csProPrice.promoId != null) ? '@' + csProPrice.promoId : '0';
          csPlus.vatType = csPlus.vatType + '*';
          //--for lineitemtype='25' will use prefix '!'+ csProPrice.promoId
        }
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

          //and add discount member itemline
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
        if (_result.disccode != null && _result.disccode != '') {
          PosSalesFnc()
              .addDiscChrgFromsaleItem(_context, _responseAddNew, _result);
        }

        mntmode = 0;
        _posinput.txtPlu.text = '';
        _posinput.txtQty.text = '';
      }
    } catch (e) {
      normalDialog(_context, e.toString() + ' @addDiscChrgItem');
    }
  }

  void showPluResult(List<CsPlu> _cspluslist) {
    //---from Enter PLU or Enter searchPLU
    getPluList = _cspluslist;
    //--------------
    if (_cspluslist.length > 1) {
      showToast(context, _posinput.txtPlu.text + '=> Not unique!');
    } else if (_cspluslist.length > 0) {
      csPlus = _cspluslist[0];
      getPromoPrice(csPlus);
    } else {
      showToast(context, _posinput.txtPlu.text + '=> Not found!');
      _posinput.txtPlu.text = '';
      _posinput.txtQty.text = '';
      fcn1.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _posinput.focusnode.requestFocus();
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: rtScreenDesktop(context, _responseInput, salesitemsum),
        ));
  }

  Widget rtScreenDesktop(BuildContext context, PosFncCallResponse responseInput,
      SalesItemSummary salesitemsum) {
    return Stack(children: [
      frameBUtton(context),
      RetailSalesSummaryPages(),
      Positioned(
          top:
              Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 26,
          left: Palette.stdspacer_widht,
          child: RtsaleItem(
            responseSumSalItem: _responseSumSalItem,
            responseInput: _responseInput,
            trackingScrollController: _trackingScrollController,
            modemnt: mntmode,
          )),
      frmaebtn7(context, responseInput),
      frmaebtn90(context, responseInput),
      getRetail(),
      getGroup(),
      Container(child: pluForm())
    ]);
  }

  Widget getRetail() {
    return (itemPanelList == null || itemPanelList.length == 0)
        ? Container()
        : Rtpanel(
            starttop: 30,
            startleft: 142 +
                Palette.stdbutton_width * (8 / 6) * 4.26 +
                Palette.stdspacer_widht * 3,
            pnlbtnInputs: (PosButton input) {},
            grpCode: (posGroup != null) ? posGroup : posGroup,
            actdo: getPanel,
            itemPanelList: itemPanelList,
            maxList:
                PosPanelCtrl().maxPanelListByColumns(3, itemPanelList.length),
            pnlCount: 3);
  }

  Widget getGroup() {
    return (groupPanelList == null || groupPanelList.length == 0)
        ? Container()
        : GroupPanelForm(
            starttop: 30,
            startleft: 132 +
                Palette.stdbutton_width * (8 / 6) * 7.26 +
                Palette.stdspacer_widht * 7,
            pnlbtnInputs: (PosButton input) {
              FncItems().poscenter(context, _responseInput, input);
            },
            actdo: getPanel,
            groupPanelList: groupPanelList);
  }

  void getPanel(PosButtonX bosbtn, String btnType) {
    try {
      bosbtnX = bosbtn;
      setState(() {
        if (btnType == 'g') {
          activeGroupPanel = bosbtn.groupId;

          String groupId = activeGroupPanel.toString();
          String itemPnlUrl = PosPanelCtrl().getItemPanelurl(context);

          _responseItemPnlList
              .itemPnlList(itemPnlUrl + '/' + activeTouchPanel + '/' + groupId);
        } else {
          _posinput.txtPlu.text = bosbtn.kybCode;
          var tl = bosbtn.kybCode.length;
          if (tl > 0) {
            txtinputEntry("ENTER");
          }
        }
      });
    } catch (e) {
      showToast(context, e.toString());
    }
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

//--------Response function below;
//---Free is not implement now
  @override
  void onCallPosFncFreeError(String error) {}

  @override
  void onCallPosFncFreeSuccess(String result) {
    setState(() {});
  }

//---Void all sales item
  @override
  void onCallPosFncVoidError() {
    salesitemIndex = -1;
  }

  @override
  void onCallPosFncVoidSuccess() {
    if (_posinput.salesItemCount(_context) == 0) {
      _initState();
    }
    setState(() {
      mntmode = 0;
    });
  }

//---void the last sales item
  @override
  void onCallPosFncVaError() {}

  @override
  void onCallPosFncVaSuccess() {
    //---send data to Server for SecondMonitor , only sales item!
    _posinput.savePOSTrans(context, 10);
    setState(() {
      //send data
    });
  }

//----add new sales items or discount / charge item
  @override
  void onCallPosFncAddNewError(String error) {}

  @override
  void onCallPosFncAddNewSuccess(String result) {
    //---send data to Server for SecondMonitor , only sales item!
    _posinput.savePOSTrans(context, 10);
    setState(() {
      salesitemIndex = -1;
      mntmode = 0;
      //send data
    });
    fcn1.requestFocus();
  }

//----get summary for saleitems
  @override
  void onCallSumSalesItemError(String error) {}

  @override
  void onCallSumSalesItemSuccess(SalesItemSummary result) {
    setState(() {
      salesitemIndex = -1;
    });
  }

//----get sales item
  @override
  void onCallPosFncGetItemError() {}

  @override
  void onCallPosFncGetItemSuccess(SalesItems asalesitem) {
    setState(() {
      selectSalesitem = asalesitem;
      if (asalesitem.plu.isNotEmpty) {
        addDiscChrgItem(asalesitem, _posinput.txt9.text);
      }
    });
    //---need this data to show promotion at footer
  }

//----get a plu to show in plu searching
  @override
  void onPluListError(String error) {}

  @override
  void onPluListSuccess(List<CsPlu> _cspluslist) {
    showPluResult(_cspluslist);
  }

//----get a member to show in member searching
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

//---get plu promotion price
  @override
  void onPluError(String error) {}

  @override
  void onPluSuccess(CsPlu _csplus) {
    //---from searchPLU selection ready
    csPlus = _csplus;
    getPromoPrice(csPlus);
  }

//---add shift ---?
  @override
  void onPosShiftAddError(String error) {}

  @override
  void onPosShiftAddSuccess(String result) {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (value) => HomeScreen(0));
    Navigator.push(context, route);
  }

//---get group panel list--
  @override
  void ongrpPnlListError(String error) {}

  @override
  void ongrpPnlListSuccess(List<GroupPanel> _vpoTouchPanel) {
    if (_vpoTouchPanel == null || _vpoTouchPanel.length == 0) {
      groupPanelList = null;
    } else {
      String TouchType = _vpoTouchPanel[0].touchPanelType;
      String groupId = _vpoTouchPanel[0].groupButtonId.toString();
      String itemPnlUrl = PosPanelCtrl().getItemPanelurl(context);
      activeGroupPanel = _vpoTouchPanel[0].groupButtonId;
      _responseItemPnlList
          .itemPnlList(itemPnlUrl + '/' + TouchType + '/' + groupId);
      groupPanelList = _vpoTouchPanel;
      setState(() {});
    }
  }

//--- get panel item list in the group
  @override
  void onitemPnlListError(String error) {}

  @override
  void onitemPnlListSuccess(List<ItemPanel> _vpoTouchPanel) {
    if (_vpoTouchPanel == null || _vpoTouchPanel.length == 0) {
      itemPanelList = null;
    } else {
      itemPanelList = _vpoTouchPanel;
      setState(() {});
    }
  }

  @override
  void onPromoListError(String error) {
    //--must set promotion info to be null before add saleitem not promotion
    csProPrice = null;
    addSalesItem();
    PosControlFnc().updatePromoDesc(context, '');
  }

//---get promotion list
  @override
  void onPromoListSuccess(List<PluPrice> promoList) {
    //--must set promotion info before add saleitem
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

  //-----------Refund Response here---
  void setToSalesMode() {
    PosControlFnc().setBIllMode(context, 1, '');
    setState(() {});
  }

  @override
  void onRefundHDError(String error) {
    showToast(context, 'ไม่สามารถคืนได้');
    setToSalesMode();
  }

  @override
  void onRefundHDSuccess(List<GetPosTranHd> result) {
    //---set BILL MODE to Refund here
    if (result != null) {
      //clear before
      PosControlFnc().startSalesItem(context);
      PosControlFnc().setBIllMode(context, 2, result[0].docNo);

      String url =
          PosControlFnc().getRefundUrl(context, _posinput.txt9.text, ''); //--HD
      //when end refund will back to SALES by : setBIllMode(context, 1) ;
      _responseRefundDt.getRefundBillDT(url + '2/3');
      _responseRefundDisc.getRefundBillDisc(url + '2/3/4');
      _responseRefundRecv.getRefundBillRecv(url + '2/3/4/5/6');

      setState(() {});
    } else {
      setToSalesMode();
    }
  }

  @override
  void onRefundDTError(String error) {
    setToSalesMode();
  }

  @override
  void onRefundDTSuccess(List<GetPosTranDt> result) {
    //---ALL BILL ---LOAD ALL SALES ITEM TO SalesItemHiveModel
    if (result == null) {
      showToast(context, 'ไม่มีรายการ');
    } else {
      PosSalesFnc().loadSalesItemFromBill(context, _responseAddNew, result);
    }
  }

  @override
  void onRefundDiscError(String error) {}

  @override
  void onRefundDiscSuccess(List<GetPosTranDisc> result) {}

  @override
  void onRefundRecvError(String error) {}

  @override
  void onRefundRecvSuccess(List<GetPosTranReceipt> result) {}
}
