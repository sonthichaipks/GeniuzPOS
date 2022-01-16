import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posAcmModel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posparamctrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/possalesfnc.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';

import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/models/posmodels/getPosTranDt.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vatExcluded.dart';
import 'package:com_csith_geniuzpos/models/posmodels/vposparam.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

import 'package:com_csith_geniuzpos/screens/mainmenus/menucomponent.dart';
import 'package:com_csith_geniuzpos/screens/mainmenus/posregister.dart';
import 'package:com_csith_geniuzpos/screens/poscontrol/posctrl_pages.dart';
import 'package:com_csith_geniuzpos/screens/posparams/posparams_pages.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_components.dart';
import 'package:com_csith_geniuzpos/screens/salesregister/components/register_menu.dart';
import 'package:com_csith_geniuzpos/screens/salesregister/sales_register.dart';
import 'package:com_csith_geniuzpos/screens/searchsalman/salman_info_ok.dart';
import 'package:com_csith_geniuzpos/screens/setactivepos/set_activepip.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/services/response/psparam_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';

import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:show_network_interface_info/model/NetworkDevice.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cardscoupons/components/ccp_searchresult.dart';
import 'posparams/components/posparam_searchresult.dart';

class HomeScreen extends StatefulWidget {
  final int mainmenu;
  HomeScreen(this.mainmenu);
  @override
  _HomeScreenState createState() => _HomeScreenState(mainmenu);

  // @override
  // Widget build(BuildContext context) {
  //   return _HomeScreenState(mainmenu);
  // }
}

class _HomeScreenState extends State<HomeScreen>
    implements
        GetpsParamCallBack,
        PosFncCallBack,
        PosFncAddNew,
        GetSearchMemberCallBack,
        LogParamCallBack,
        PosSaveCallBack,
        RefundDTCallBack {
  final int mainmenu;
  PosFncCallResponse _responseInput;
  GetSearchMemberResponse _responseMember;
  GetCsParamResponse _responseCsParam;
  LogCsParamResponse _responseLogParam;
  PosSaveCallResponse _responsePosSave;
  RefundDTCallResponse _responseRefundDt; //test
  PosInput _posinput = new PosInput();
  BuildContext _context;
  PosButton posMenu;
  PsMember csMember;

  bool kEntry = false;
  int firstOpen = 0;
  _HomeScreenState(this.mainmenu) {
    posMenu = PosInput().mainmenuData;
    _responseInput = new PosFncCallResponse(this);
    _responseMember = new GetSearchMemberResponse(this);
    _responseCsParam = new GetCsParamResponse(this);
    _responseLogParam = new LogCsParamResponse(this);
    _responsePosSave = new PosSaveCallResponse(this);
    _responseRefundDt = new RefundDTCallResponse(this);
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SalesItemHiveModel>().getItem();
    context.watch<BillDCItemHiveModel>().getItem();
    context.watch<ReceiptItemHiveModel>().getItem();

    return Scaffold(body: homeScreenDesktop(context));
  }

  void setToSalesMode() {
    PosControlFnc().setBIllMode(context, 1, '');
  }

  void presskey(String result) {
    if (kEntry) {
      if (result != "") {
        kEntry = !kEntry;
        if (result == "F1") {
          firstOpen = 0;

          showLoadParamDialog(context, 'Parameters Update', 'Load Now',
              'Load new POS STATION parameters again ? \r\n If Load success , will close applcation autometicly, \r\n   you must start it again!');
        } else if (result == "1:1:F2") {
          FncItems().searchPLU(_context, '567', null, null, null, null, 1);
        }
      }
    }
    kEntry = true;
  }

  showLoadParamDialog(
      BuildContext context, String title, String subtitle, String detail) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text(subtitle,
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.red,
          )),
      onPressed: () {
        String url = PosControlFnc().getCsParamUrl(context);
        _responseCsParam.getCsParamForm(url);
        showToast(context, 'load param:' + url);
      },
    );

    Widget launchButton = TextButton(
      child: Text("Exit"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(detail,
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.blue,
          )),
      actions: [
        remindButton,
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget homeScreenDesktop(BuildContext context) {
    _context = context;
    context.watch<PosAcmModel>().getItem();
    if (firstOpen == 0) {
      getCurPluUrl();
      setToSalesMode();
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage(posMenu.imageUrl),
                fit: BoxFit.fill,
              ),
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
          child: Stack(children: [
            frameBUtton(context),
            posRegister(context, '', '', ''),
            Positioned(
              top: 670,
              left: 966,
              child: config(),
            ),
            poslabel(context, mainmenu),
            Padding(
              padding: const EdgeInsets.fromLTRB(416, 150, 0, 0),
              child: GestureDetector(
                onTap: () {
                  presskey('F1');
                },
                child: Container(
                    height: Palette.fullsalesheadcheight() * 0.3,
                    width: Palette.stdbutton_width * 2.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.transparent),
                        left: BorderSide(width: 1.0, color: Colors.transparent),
                        right:
                            BorderSide(width: 1.0, color: Colors.transparent),
                        bottom:
                            BorderSide(width: 1.0, color: Colors.transparent),
                      ),
                    ),
                    child: posDateTimeLabel()),
              ),
            ),
            Positioned(
              top: -90,
              left: -56,
              child: PosMenu(responseInput: _responseInput, mainmenu: mainmenu),
            ),
          ]),
        ),
      ),
    );
    //});
  }

  Widget config() {
    return Builder(builder: (BuildContext context) {
      return Row(children: [
        Container(
          height: Palette.stdbutton_width * 0.55,
          width: Palette.stdbutton_width * 0.55,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.transparent),
              left: BorderSide(width: 1.0, color: Colors.transparent),
              right: BorderSide(width: 1.0, color: Colors.transparent),
              bottom: BorderSide(width: 1.0, color: Colors.transparent),
            ),
          ),
          child: Container(
              child: GestureDetector(
            onTap: () {
              FncItems()
                  .menucenter(context, _responseInput, stdButtuonMenu[21]);
            },
            onDoubleTap: () => _showActivePIPDialog(context),
            child: Image.asset(
              'assets/main_config.png',
              height: 130,
              width: 150,
            ),
          )),
        )
      ]);
    });
  }

  Future<void> _showActivePIPDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                height: Palette.stdbutton_height * 4.8,
                width: Palette.stdbutton_width * 9.2,
                child: ActivePipPages(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    txtinputEntry(result);
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "SignIn") {
        setToSalesMode();
        showPopupTask(_context, "SIGNIN", null);
      } else if (result == "Initial") {
      } else if (result == "TaxInvoice") {
      } else if (result == "PriceCheck") {
        //---test
        // try {
        // String url = PosControlFnc()
        //     .getRefundUrl(context, '1GS00200122000002', ''); //--HD
        // //when end refund will back to SALES by : setBIllMode(context, 1) ;
        // _responseRefundDt.getRefundBillDT(url + '2/3');

        //   _responsePosSave.SavePosTrans(context, 42);
        // } catch (e) {
        //   showToast(context, e.toString());
        // }
        //  showToast(context, url);
        //--end test

        _posinput.salesPriceNo = _posinput.getPriceNo(_context);
        FncItems().searchPLU(
            _context, '', null, null, null, null, _posinput.salesPriceNo);
      } else if (result == "CloseShift") {
      } else if (result == "EndOfDay") {
      } else if (result == "VatRefund") {
      } else if (result == "GoodReturn") {
      } else if (result == "PointRedeem") {
      } else if (result == "MemberRegister") {
        FncItems().showPopSearchMember(_context, _responseMember, 'C');
      } else if (result == "PasswordReset") {
        showPopupTask(_context, result, null);
      } else {}
    }
  }

  Future<void> showPopupTaskT(BuildContext context, String ccpType) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            insetAnimationDuration: const Duration(milliseconds: 100),
            child: Stack(
              children: [
                Container(
                  // use container to change width and height
                  height: Palette.stdbutton_height * 6.4,
                  width: Palette.stdbutton_width * 5,
                  child: CCPSearchListPages(
                      responseCCP: null,
                      responseInput: _responseInput,
                      actionDo: null,
                      ccType: ccpType),
                ),
              ],
            ),
          );
        });
  }

  void getCurPluUrl() async {
    String url = PosControlFnc().getPLUurl(context);
    String baseUrl = await PosControlFnc().getCurrentIP(url);

    PosControlFnc().checkCurIP_pluWSurl(context, baseUrl);

    firstOpen += 1;
  }

  String checkLoginMode() {
    //--if posid==null or =='' then Config.Mode
    //--if not is sales signin mode
    PosCtrl posctrl61 = posCtrlList[59]; //PosStation
    String curPosStation =
        PosControlFnc().getCurrentSettingValues(context, posctrl61);
    return curPosStation;
  }

  Future<void> showPopSearchSalesMan(
      BuildContext context, String values) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                height: Palette.stdbutton_height * 4.9,
                width: Palette.stdbutton_width * 7.3,
                child: SalmanInfoOkPages(),
              ),
            ],
          ),
        );
      },
    );
  }

  void loadCsParam() async {
    String url = PosControlFnc().getCsParamUrl(context);
    showToast(context, 'loadCsParam: ' + url);
    _responseCsParam.getCsParamForm(url);
  }

  Future<void> showPopupTask(
      BuildContext context, String mnuName, Function actdo) async {
    switch (mnuName) {
      case "CONFIG":
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      height: Palette.stdbutton_height * 9.8,
                      width: Palette.stdbutton_width * 7.3,
                      child: PosParamSearchPages(actdo: loadCsParam, mode: 1),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "SIGNIN":
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 8,
                      width: Palette.stdbutton_width * 10.5,
                      child: SalesSignInPages(),
                    ),
                    Positioned(
                        top: 200,
                        left: 10,
                        child: registerMenu(context, _responseInput)),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "PasswordReset":
        {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => SimpleDialog(
                    title: Text(mnuName),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    ],
                  ));
        }
        break;
    }
  }

  @override
  void onCallPosFncAddNewError(String error) {}

  @override
  void onCallPosFncAddNewSuccess(String result) {}

  @override
  void onSearchMemberError(String error) {}

  @override
  void onSearchMemeberSuccess(PsMember _psMember) {
    //---get the Member Data then --- refresh binding to member forms---

    if (_psMember != null) {
      _posinput.getMemberValue(_context, _psMember);
    }
  }

  @override
  void onpsParamError(String error) {}

  @override
  void onpsParamSuccess(List<VpoSparam> _vpoSparam) {
    try {
      if (_vpoSparam != null && _vpoSparam.isNotEmpty && _vpoSparam != '[]') {
        _responseLogParam.logCsParamForm(_context, _vpoSparam[0]);
      } else {
        firstOpen = 0;
      }
    } catch (e) {
      showToast(context, 'onpsParamSuccess but error: ' + e.toString());
    }
  }

  @override
  void onLogParamError(String error) {}

  @override
  void onLogParamSuccess(String result) {
    waitForDialog(context, 'Application will close now!', closeMe);
  }

  void closeMe() {
    Navigator.of(context).pop();
    appWindow.close();
  }

  @override
  void onVatExcludedError(String error) {}

  @override
  void onVatExcludedSuccess(List<VatExCluded> _vatExCluded) {
    if (_vatExCluded != null && _vatExCluded.length > 0) {
      double vatExCluded =
          _vatExCluded[0].vatBillExClude + _vatExCluded[0].vatCharge;
      showToast(context, oCcy.format(vatExCluded));
      if (vatExCluded != null && vatExCluded > 0) {
        setState(() {
          // rcpSetLoad(netsales + vatExCluded);
        });
      }
    }
  }

  @override
  void onCallPosSaveError(String error) {}

  @override
  void onCallPosSaveSuccess(int result) {}

  @override
  void onRefundDTError(String error) {}

  @override
  void onRefundDTSuccess(List<GetPosTranDt> result) {
    if (result == null) {
      showToast(context, 'กำลังอ่านรายการ=null');
    } else {
      PosSalesFnc().loadSalesItemFromBill(context, null, result);
    }
  }
}
